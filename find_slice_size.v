`timescale 1ns/1ns

module find_slice_size
	(
		input signed [12:0] playerX, playerY,		// player's current X and Y position
		input signed [9:0] angle_X,					// angle that player is currently facing, fixed point format
		input signed [9:0] angle_Y,					// angle_X is the left of the decimal point, angle_Y is the right
		input [7:0] column_count,						// which column of the screen we are casting a ray for
		input clock,										// On board clock, 50 MHz on the DE1_SoC
		input resetn,										// active-low, resets the FSM and datapath registers
		input begin_calc,									// begin calculation of slice size
		output [6:0] slice_size,						// calculated slice size after casting rays for this slice
		output end_calc									// end calculation of slice size
	);
	
	// ------------------------------------------ Control to datapath --------------------------------------------------
	
	// tells the datapath to find the angle offset from the left of the player's field of view, cycle 0
	wire find_angle_offset_0;
	
	// tells the datapath to find the angle offset from the left of the player's field of view, cycle 1
	wire find_angle_offset_1;
	
	// tells the datapath to find alpha. alpha is the current raycast angle
	wire find_alpha_beta_0;
	
	// tells the datapath to find beta. beta is the angle relative to player angle, used to reverse the fishbowl effect
	wire find_alpha_beta_1;
	
	// tells the datapath to find the absolute value of beta, since cos(beta) = cos(-beta)
	wire find_alpha_beta_2;
	
	// tells the datapath to find the grid intersections of the casted ray
	wire find_ray_grid_intersections;
	
	// tells the datapath to find the distances corresponding to each of the horizontal and vertical intersections
	wire find_distances_0;
	
	// tells the datapath to calulate the absolute value of each of the distances
	wire find_distances_1;
	
	// tells the datapath to find the closer distance
	wire find_closer_distance;
	
	// tells the datapath to reverse the fishbowl effect on the closer distance, to find the un-distorted distance
	wire perform_reverse_fishbowl;
	
	// tells the datapath to use the un-distorted distance to project the walls on the screen/viewport
	wire perform_project_to_screen;
	
	// ------------------------------------------ Datapath to control --------------------------------------------------
	
	// tells the control that that raycast calculations are complete and to continue if a wall was found, or to return
	// from this module if wall was not found i.e. slice_size = 0
	wire end_calc_raycast;
	
	// ------------------------------------------ Higher-level module --------------------------------------------------
	
	// assign end_calc = ?
	
	control_find_slice_size FSM (
	
		.clock(clock),
		.resetn(resetn),
		
		// -------------------------------- inputs that affect FSM state -------------------------------------
		
		.begin_calc(begin_calc),
		
		// from the datapath
		.end_calc_raycast(end_calc_raycast),
		
		// ------------------------------------ outputs to the datapath --------------------------------------
		
		.find_angle_offset_0(find_angle_offset_0),
		.find_angle_offset_1(find_angle_offset_1),
		.find_alpha_beta_0(find_alpha_beta_0),
		.find_alpha_beta_1(find_alpha_beta_1),
		.find_alpha_beta_2(find_alpha_beta_2),
		.find_ray_grid_intersections(find_ray_grid_intersections),
		.find_distances_0(find_distances_0),
		.find_distances_1(find_distances_1),
		.find_closer_distance(find_closer_distance),
		.perform_reverse_fishbowl(perform_reverse_fishbowl),
		.perform_project_to_screen(perform_project_to_screen)
	
	);
	
	datapath_find_slice_size find_slice_size (
	
		.clock(clock),
		.resetn(resetn),
		
		// ------------------------------------ control signals from FSM --------------------------------------
		
		.find_angle_offset_0(find_angle_offset_0),
		.find_angle_offset_1(find_angle_offset_1),
		.find_alpha_beta_0(find_alpha_beta_0),
		.find_alpha_beta_1(find_alpha_beta_1),
		.find_alpha_beta_2(find_alpha_beta_2),
		.find_ray_grid_intersections(find_ray_grid_intersections),
		.find_distances_0(find_distances_0),
		.find_distances_1(find_distances_1),
		.find_closer_distance(find_closer_distance),
		.perform_reverse_fishbowl(perform_reverse_fishbowl),
		.perform_project_to_screen(perform_project_to_screen),
		
		// ------------------------------------ data input and output --------------------------------------
		
		.playerX(playerX),
		.playerY(playerY),
		.angle_X(angle_X),
		.angle_Y(angle_Y),
		.column_count(column_count),
		
		.proj_slice_size(slice_size),
		
		// ----------------------------------------- outputs to FSM -----------------------------------------
		// ------------------------- tell the FSM that ray-casting is complete ------------------------------
		
		.end_calc_raycast(end_calc_raycast)
	
	);
	
endmodule

module control_find_slice_size (input clock, resetn, begin_calc, end_calc_raycast,
										  output reg find_angle_offset_0, find_angle_offset_1, find_alpha_beta_0, 
										  find_alpha_beta_1, find_alpha_beta_2,
										  find_ray_grid_intersections, find_distances_0, find_distances_1, find_closer_distance,
										  perform_reverse_fishbowl, perform_project_to_screen);
	
	reg [3:0] current_state, next_state;
	
	localparam S_WAIT = 4'd0,
				  S_FIND_ANGLE_OFFSET_0 = 4'd1,
				  S_FIND_ANGLE_OFFSET_1 = 4'd2,
				  S_FIND_ALPHA_BETA_0 = 4'd3,
				  S_FIND_ALPHA_BETA_1 = 4'd4,
				  S_RAYCAST = 4'd5,
				  S_FIND_DISTANCES_0 = 4'd6,
				  S_FIND_DISTANCES_1 = 4'd7,
				  S_FIND_CLOSER_DIST = 4'd8,
				  S_REVERSE_FISHBOWL = 4'd9,
				  S_PROJECT_TO_SCREEN = 4'd10;
				  
	// ----------------------------------------- state table  ------------------------------------------------
	
	always @(*)
	begin: state_table
	
		case(current_state)
			S_WAIT: next_state = begin_calc ? S_FIND_ANGLE_OFFSET_0 : S_WAIT;
			S_FIND_ANGLE_OFFSET_0: next_state = S_FIND_ANGLE_OFFSET_1; // provide 2 states to compute angle offset
			S_FIND_ANGLE_OFFSET_1: next_state = S_FIND_ALPHA_BETA_0;
			S_FIND_ALPHA_BETA_0: next_state = S_FIND_ALPHA_BETA_1; // provide 2 states to compute alpha and beta
			S_FIND_ALPHA_BETA_1: next_state = S_RAYCAST;
			S_RAYCAST: next_state = end_calc_raycast ? S_FIND_DISTANCES_0 : S_RAYCAST; // stay in this state till raycasts are complete
			S_FIND_DISTANCES_0: next_state = S_FIND_DISTANCES_1; // provide 2 states to compute distances from horizontal and vertical raycasts
			S_FIND_DISTANCES_1: next_state = S_FIND_CLOSER_DIST;
			S_FIND_CLOSER_DIST: next_state = S_REVERSE_FISHBOWL; // provide 1 state to find lesser of 2 distances
			S_REVERSE_FISHBOWL: next_state = S_PROJECT_TO_SCREEN; // provide 1 state to reverse fishbowl effect
			S_PROJECT_TO_SCREEN: next_state = S_WAIT;
			default: next_state = S_WAIT;
		endcase
	
	end // state_table
	
	// ------------------------------- output logic i.e. control signal logic  -------------------------------------
	
	always @(*)
	begin: control_signals

		// prevent latching by assuming all control signals to be 0 at the beginning
		find_angle_offset_0 = 1'b0;
		find_angle_offset_1 = 1'b0;
		find_alpha_beta_0 = 1'b0;
		find_alpha_beta_1 = 1'b0;
		find_ray_grid_intersections = 1'b0;
		find_distances_0 = 1'b0;
		find_distances_1 = 1'b0;
		find_closer_distance = 1'b0;
		perform_reverse_fishbowl = 1'b0;
		perform_project_to_screen = 1'b0;
		
		case(current_state)
			S_FIND_ANGLE_OFFSET_0: find_angle_offset_0 = 1'b1;
			S_FIND_ANGLE_OFFSET_1: find_angle_offset_1 = 1'b1;
			S_FIND_ALPHA_BETA_0: find_alpha_beta_0 = 1'b1;
			S_FIND_ALPHA_BETA_1: find_alpha_beta_1 = 1'b1;
			S_RAYCAST: find_ray_grid_intersections = 1'b1;
			S_FIND_DISTANCES_0: find_distances_0 = 1'b1;
			S_FIND_DISTANCES_1: find_distances_1 = 1'b1;
			S_FIND_CLOSER_DIST: find_closer_distance = 1'b1;
			S_REVERSE_FISHBOWL: perform_reverse_fishbowl = 1'b1;
			S_PROJECT_TO_SCREEN: perform_project_to_screen = 1'b1;
		endcase
		
	end // control_signals
	
	// ------------------------------------- current state register  -------------------------------------------
	
	always @(posedge clock)
	begin: state_FFs
		if (!resetn)
			current_state <= S_WAIT;
		else
			current_state <= next_state; // at each clock cycle, move to the next computed state
	end // state_FFs
										  
endmodule

module datapath_find_slice_size (input clock, resetn, find_angle_offset_0, find_angle_offset_1, find_alpha_beta_0, 
										  find_alpha_beta_1, find_alpha_beta_2, find_ray_grid_intersections, find_distances_0, 
										  find_distances_1, find_closer_distance, perform_reverse_fishbowl, 
										  perform_project_to_screen,
										  input signed [12:0] playerX, playerY, input signed [9:0] angle_X, angle_Y,
										  input [7:0] column_count,
										  output [6:0] proj_slice_size, output end_calc_raycast);
	
	// FOV is 60 degrees, half_FOV = 30
	localparam half_FOV = 30;
	
	// Cast a ray at every 0.375 degrees
	localparam angle_between_rays_X = 0,
				  angle_between_rays_Y = 375;
	
	reg [5:0] angle_offset_X;
	reg [9:0] angle_offset_Y;
	
	// if beta is negative, compute abs(beta)
	reg [9:0] abs_beta_X, abs_beta_Y;
	
	reg signed [9:0] alpha_X, alpha_Y;
	reg signed [9:0] beta_X, beta_Y;
	
	// ------------------------------------------- raycast modules ----------------------------------------------------
	
	
	
	
	// ---------------------------------------- datapath output table  ------------------------------------------------
	
	always @(posedge clock)
	begin
	
		if (!resetn) begin
			abs_beta_X <= 0;
			abs_beta_Y <= 0;
			angle_offset_X <= 0;
			angle_offset_Y <= 0;
		end
		else begin
			
			if (find_angle_offset_0) begin
			
				// angle_between_rays_X is 0, so simply overflow from the right decimal point
				// eg. 100 * 375 / 1000 = 3.75 floored to 3
				angle_offset_X <= $floor((column_count * angle_between_rays_Y) / 1000);
			end
			
			if (find_angle_offset_1) begin
			
				// assumes angle_between_rays_X = 0
				// column_count * right side of decimal point is greater than overflow to the left,
				// then subtract the overflow. else keep the right side as it is since it does it does not overflow
				// past the decimal point
				if (column_count * angle_between_rays_Y >= 1000 * angle_offset_X)
					angle_offset_Y <= (column_count * angle_between_rays_Y) - (1000 * angle_offset_X);
				else
					angle_offset_Y <= column_count * angle_between_rays_Y;
				
			end
			
			if (find_alpha_beta_0) begin
				
				// perform fixed point subtraction: angle + half_FOV - angle_offset
				
				if (angle_offset_Y > angle_Y) begin
					if ((angle_X + half_FOV) < angle_offset_X) begin
						alpha_X <= (angle_X + half_FOV) - angle_offset_X;
						alpha_Y <= angle_offset_Y - angle_Y;
					end else begin
						alpha_X <= (angle_X + half_FOV - 1) - angle_offset_X;
						alpha_Y <= (1000 - angle_offset_Y) + angle_Y;
					end
				
				end else begin
					if ((angle_X + half_FOV) < angle_offset_X) begin
						alpha_X <= (angle_X + half_FOV + 1) - angle_offset_X;
						alpha_Y <= (1000 - angle_Y) + angle_offset_Y;
					end else begin
						alpha_X <= angle_X + half_FOV - angle_offset_X;
						alpha_Y <= angle_Y - angle_offset_Y;
					end
				end
				
			end
			
			if (find_alpha_beta_1) begin
			
				// perform fixed point subtraction: beta = angle_offset - half_FOV
				
					if (angle_offset_X < half_FOV) begin
						beta_X <= (angle_offset_X + 1) - half_FOV;
						beta_Y <= 1000 - angle_offset_Y;
					end else begin
						beta_X <= angle_offset_X - half_FOV;
						beta_Y <= angle_offset_Y;
					end
				
			end
			
			if (find_alpha_beta_2) begin
				// need only calculate absolute value of beta_X since negative values are only negative in fixed_X
				if (beta_X < 0)
					abs_beta_X <= -beta_X;
				else
					abs_beta_X <= beta_X;
					
				abs_beta_Y <= beta_Y;
				
			end
			
		end
			
	end
										  
endmodule
