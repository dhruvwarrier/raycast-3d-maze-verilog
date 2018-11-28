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
		output skip_this_slice,							// high if no wall is hit for this slice
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
	
	// tells the datapath to wrap-around a negative value of alpha i.e. correct -5 degrees to 355 degrees
	wire find_alpha_beta_3;
	
	// tells the datapath to find the grid intersections of the casted ray
	wire find_ray_grid_intersections;
	
	// tells the datapath to take the absolute values of the differences between playerX and wallXs
	wire find_distances_0;
	
	// tells the datapath to find the distances corresponding to each of the horizontal and vertical intersections
	wire find_distances_1;
	
	// tells the datapath to calulate the absolute value of each of the distances
	wire find_distances_2;
	
	// tells the datapath to find the closer distance
	wire find_closer_distance;
	
	// tells the datapath to reverse the fishbowl effect on the closer distance, to find the un-distorted distance
	wire perform_reverse_fishbowl;
	
	// tells the datapath to use the un-distorted distance to project the walls on the screen/viewport
	wire perform_project_to_screen_0;
	
	// tells the datapath to limit the projected slice size to a maximum of 120
	wire perform_project_to_screen_1;
	
	// ------------------------------------------ Datapath to control --------------------------------------------------
	
	// tells the control that that raycast calculations are complete and to continue if a wall was found, or to return
	// from this module if wall was not found i.e. slice_size = 0
	wire end_calc_raycast;
	
	// tells the control that a wall has been hit by this ray after calculations are complete
	wire wall_found;
	
	// ------------------------------------------ Higher-level module --------------------------------------------------
	
	// skip this slice is no wall was found after casting a ray
	assign skip_this_slice = !wall_found;
	// calculation has ended if either wall was not found after casting a ray or in the last state
	assign end_calc = !wall_found || perform_project_to_screen_1;
	
	control_find_slice_size FSM (
	
		.clock(clock),
		.resetn(resetn),
		
		// -------------------------------- inputs that affect FSM state -------------------------------------
		
		.begin_calc(begin_calc),
		
		// from the datapath
		.end_calc_raycast(end_calc_raycast),
		.wall_found(wall_found),
		
		// ------------------------------------ outputs to the datapath --------------------------------------
		
		.find_angle_offset_0(find_angle_offset_0),
		.find_angle_offset_1(find_angle_offset_1),
		.find_alpha_beta_0(find_alpha_beta_0),
		.find_alpha_beta_1(find_alpha_beta_1),
		.find_alpha_beta_2(find_alpha_beta_2),
		.find_alpha_beta_3(find_alpha_beta_3),
		.find_ray_grid_intersections(find_ray_grid_intersections),
		.find_distances_0(find_distances_0),
		.find_distances_1(find_distances_1),
		.find_distances_2(find_distances_2),
		.find_closer_distance(find_closer_distance),
		.perform_reverse_fishbowl(perform_reverse_fishbowl),
		.perform_project_to_screen_0(perform_project_to_screen_0),
		.perform_project_to_screen_1(perform_project_to_screen_1)
	
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
		.find_alpha_beta_3(find_alpha_beta_3),
		.find_ray_grid_intersections(find_ray_grid_intersections),
		.find_distances_0(find_distances_0),
		.find_distances_1(find_distances_1),
		.find_distances_2(find_distances_2),
		.find_closer_distance(find_closer_distance),
		.perform_reverse_fishbowl(perform_reverse_fishbowl),
		.perform_project_to_screen_0(perform_project_to_screen_0),
		.perform_project_to_screen_1(perform_project_to_screen_1),
		
		// ------------------------------------ data input and output --------------------------------------
		
		.playerX(playerX),
		.playerY(playerY),
		.angle_X(angle_X),
		.angle_Y(angle_Y),
		.column_count(column_count),
		
		.slice_size(slice_size),
		
		// ----------------------------------------- outputs to FSM -----------------------------------------
		// ------------------------- tell the FSM that ray-casting is complete ------------------------------
		
		.end_calc_raycast(end_calc_raycast),
		.wall_found(wall_found)
	
	);
	
endmodule

module control_find_slice_size (input clock, resetn, begin_calc, end_calc_raycast, wall_found,
										  output reg find_angle_offset_0, find_angle_offset_1, find_alpha_beta_0, 
										  find_alpha_beta_1, find_alpha_beta_2, find_alpha_beta_3,
										  find_ray_grid_intersections, find_distances_0, 
										  find_distances_1, find_distances_2, find_closer_distance,
										  perform_reverse_fishbowl, perform_project_to_screen_0, perform_project_to_screen_1);
	
	reg [3:0] current_state, next_state;
	
	localparam S_WAIT = 4'd0,
				  S_FIND_ANGLE_OFFSET_0 = 4'd1,
				  S_FIND_ANGLE_OFFSET_1 = 4'd2,
				  S_FIND_ALPHA_BETA_0 = 4'd3,
				  S_FIND_ALPHA_BETA_1 = 4'd4,
				  S_FIND_ALPHA_BETA_2 = 4'd5,
				  S_FIND_ALPHA_BETA_3 = 4'd6,
				  S_RAYCAST = 4'd7,
				  S_FIND_DISTANCES_0 = 4'd8,
				  S_FIND_DISTANCES_1 = 4'd9,
				  S_FIND_DISTANCES_2 = 4'd10,
				  S_FIND_CLOSER_DIST = 4'd11,
				  S_REVERSE_FISHBOWL = 4'd12,
				  S_PROJECT_TO_SCREEN_0 = 4'd13,
				  S_PROJECT_TO_SCREEN_1 = 4'd14;
				  
	// ----------------------------------------- state table  ------------------------------------------------
	
	always @(*)
	begin: state_table
	
		case(current_state)
			S_WAIT: next_state = begin_calc ? S_FIND_ANGLE_OFFSET_0 : S_WAIT;
			S_FIND_ANGLE_OFFSET_0: next_state = S_FIND_ANGLE_OFFSET_1; // provide 2 states to compute angle offset
			S_FIND_ANGLE_OFFSET_1: next_state = S_FIND_ALPHA_BETA_0;
			S_FIND_ALPHA_BETA_0: next_state = S_FIND_ALPHA_BETA_1; // provide 4 states to compute alpha and beta
			S_FIND_ALPHA_BETA_1: next_state = S_FIND_ALPHA_BETA_2;
			S_FIND_ALPHA_BETA_2: next_state = S_FIND_ALPHA_BETA_3;
			S_FIND_ALPHA_BETA_3: next_state = S_RAYCAST;
			S_RAYCAST:
			begin
				// tackle in order of priority
				if (wall_found)
					next_state = S_FIND_DISTANCES_0; // only if we've found a wall, continue
				else if (end_calc_raycast)
					next_state = S_WAIT; // wall was not found but calculations complete
				else
					next_state = S_RAYCAST; // remain in this state until ray casts complete
			end
			S_FIND_DISTANCES_0: next_state = S_FIND_DISTANCES_1; // provide 3 states to compute distances from horizontal and vertical raycasts
			S_FIND_DISTANCES_1: next_state = S_FIND_DISTANCES_2;
			S_FIND_DISTANCES_2: next_state = S_FIND_CLOSER_DIST;
			S_FIND_CLOSER_DIST: next_state = S_REVERSE_FISHBOWL; // provide 1 state to find lesser of 2 distances
			S_REVERSE_FISHBOWL: next_state = S_PROJECT_TO_SCREEN_0; // provide 1 state to reverse fishbowl effect
			S_PROJECT_TO_SCREEN_0: next_state = S_PROJECT_TO_SCREEN_1;
			S_PROJECT_TO_SCREEN_1: next_state = S_WAIT;
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
		find_alpha_beta_2 = 1'b0;
		find_alpha_beta_3 = 1'b0;
		find_ray_grid_intersections = 1'b0;
		find_distances_0 = 1'b0;
		find_distances_1 = 1'b0;
		find_distances_2 = 1'b0;
		find_closer_distance = 1'b0;
		perform_reverse_fishbowl = 1'b0;
		perform_project_to_screen_0 = 1'b0;
		perform_project_to_screen_1 = 1'b0;
		
		case(current_state)
			S_FIND_ANGLE_OFFSET_0: find_angle_offset_0 = 1'b1;
			S_FIND_ANGLE_OFFSET_1: find_angle_offset_1 = 1'b1;
			S_FIND_ALPHA_BETA_0: find_alpha_beta_0 = 1'b1;
			S_FIND_ALPHA_BETA_1: find_alpha_beta_1 = 1'b1;
			S_FIND_ALPHA_BETA_2: find_alpha_beta_2 = 1'b1;
			S_FIND_ALPHA_BETA_3: find_alpha_beta_3 = 1'b1;
			S_RAYCAST: find_ray_grid_intersections = 1'b1;
			S_FIND_DISTANCES_0: find_distances_0 = 1'b1;
			S_FIND_DISTANCES_1: find_distances_1 = 1'b1;
			S_FIND_DISTANCES_2: find_distances_2 = 1'b1;
			S_FIND_CLOSER_DIST: find_closer_distance = 1'b1;
			S_REVERSE_FISHBOWL: perform_reverse_fishbowl = 1'b1;
			S_PROJECT_TO_SCREEN_0: perform_project_to_screen_0 = 1'b1;
			S_PROJECT_TO_SCREEN_1: perform_project_to_screen_1 = 1'b1;
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
										  find_alpha_beta_1, find_alpha_beta_2, find_alpha_beta_3, find_ray_grid_intersections, 
										  find_distances_0, find_distances_1, find_distances_2,
										  find_closer_distance, perform_reverse_fishbowl, perform_project_to_screen_0,
										  perform_project_to_screen_1,
										  input signed [12:0] playerX, playerY, input signed [9:0] angle_X, angle_Y,
										  input [7:0] column_count,
										  output reg [6:0] slice_size, output end_calc_raycast, wall_found);
	
	// FOV is 60 degrees, half_FOV = 30
	localparam half_FOV = 30;
	
	localparam projection_scaling_factor = 2000;
	
	// Cast a ray at every 0.375 degrees
	localparam angle_between_rays_X = 0,
				  angle_between_rays_Y = 375;
	
	/* alpha is the current angle at which a ray is being cast. To get it, we
	shift to the left of the FOV from the player angle (angle + 30) and then
	subtract in increments of 0.375 degrees till we span the entire FOV. */
	reg signed [9:0] alpha_X, alpha_Y;
	
	/* beta is the angle of the ray relative to player angle, used to reverse
	the fishbowl effect. absolute value taken since cos(beta) = cos(-beta)
	and the lookup table does not contain negative values */
	reg signed [9:0] beta_X, beta_Y;
	
	// the offset to subtract from angle + 30 to get the raycast angle (alpha) and to subtract 30 from to get 
	// the angle relative to player angle (beta)
	reg [5:0] angle_offset_X;
	reg [9:0] angle_offset_Y;
	
	// if beta is negative, compute abs(beta)
	reg [9:0] abs_beta_X, abs_beta_Y;
	
	// generated by raycast modules
	wire wall_found_horiz;
	wire wall_found_vert;
	
	// these are registered because they all come through at different times for a single clock pulse, but they can
	// only be checked at the end of ray cast calculations
	reg end_raycast_horiz, end_raycast_vert;
	reg bounds_reached_horiz, bounds_reached_vert;
	
	// the distances to the horizontal and vertical wall intersections respectively
	reg signed [20:0] distance_horiz, distance_vert;
	
	// this is the closer distance of distance_horiz and distance_vert. If only one was found, that is closer_dist
	reg signed [20:0] closer_dist;
	
	// this is the projected slice size. It should be limited to max slice size (120)
	reg signed [20:0] projected_slice_size;
	
	// if we've found a wall, we can go ahead to find distances and project it to the screen, else we must quit
	assign wall_found = (!bounds_reached_horiz && end_raycast_horiz) || (!bounds_reached_vert && end_raycast_vert);
	
	assign end_calc_raycast = end_raycast_horiz && end_raycast_vert;
	
	// ------------------------------------------- raycast modules ----------------------------------------------------
	
	wire signed [12:0] wallX_horiz;
	wire end_raycast_horiz_wire;
	wire bounds_reached_horiz_wire;
	
	find_wall_intersection_horiz raycast_horiz(
	
		.clock(clock),
		.resetn(resetn),
		
		.playerX(playerX),
		.playerY(playerY),
		.alpha_X(alpha_X),
		.alpha_Y(alpha_Y),
		.begin_calc(find_ray_grid_intersections),
		
		.wallX(wallX_horiz),
		.wall_found(wall_found_horiz),
		.maze_bounds_reached(bounds_reached_horiz_wire),
		.end_calc(end_raycast_horiz_wire)
	
	);
	
	wire signed [12:0] wallX_vert;
	wire end_raycast_vert_wire;
	wire bounds_reached_vert_wire;
	
	find_wall_intersection_vert raycast_vert(
	
		.clock(clock),
		.resetn(resetn),
		
		.playerX(playerX),
		.playerY(playerY),
		.alpha_X(alpha_X),
		.alpha_Y(alpha_Y),
		.begin_calc(find_ray_grid_intersections),
		
		.wallX(wallX_vert),
		.wall_found(wall_found_vert),
		.maze_bounds_reached(bounds_reached_vert_wire),
		.end_calc(end_raycast_vert_wire)
	
	);
	
	// --------------------------------------- cos alpha and cos beta--------------------------------------------------
	
	wire signed [1:0] cos_alpha_X;
	wire signed [17:0] cos_alpha_Y;
	
	cos_LUT lookup_cos_alpha(.angleX(alpha_X),.angleY(alpha_Y),.ratioX(cos_alpha_X),.ratioY(cos_alpha_Y));
	
	wire signed [1:0] cos_beta_X;
	wire signed [17:0] cos_beta_Y;
	
	cos_LUT lookup_cos_beta(.angleX(abs_beta_X),.angleY(abs_beta_Y),.ratioX(cos_beta_X),.ratioY(cos_beta_Y));
	
	// ------------------------------------------ compute distances ---------------------------------------------------
	
	wire signed [20:0] distance_horiz_computed;
	wire signed [12:0] playerX_horiz_diff;
	assign playerX_horiz_diff = playerX - wallX_horiz;
	reg signed [12:0] abs_playerX_horiz_diff;
	
	int_fixed_point_div_int distance_horiz_calc (
		
		// performs division: distance_horiz = (playerX - wallX_horiz) / cos(alpha)
		
		.int_in({8'b0, abs_playerX_horiz_diff}),
		.fixed_X({8'b0, cos_alpha_X}),
		.fixed_Y(cos_alpha_Y),
		
		.int_out(distance_horiz_computed)
	);
	
	wire signed [20:0] distance_vert_computed;
	wire signed [12:0] playerX_vert_diff;
	assign playerX_vert_diff = playerX - wallX_vert;
	reg signed [12:0] abs_playerX_vert_diff;
	
	int_fixed_point_div_int distance_vert_calc (
		
		// performs division: distance_vert = (playerX - wallX_vert) / cos(alpha)
		
		.int_in({8'b0, abs_playerX_vert_diff}),
		.fixed_X({8'b0, cos_alpha_X}),
		.fixed_Y(cos_alpha_Y),
		
		.int_out(distance_vert_computed)
	);
	
	// -------------------------------------- perform reverse fishbowl ------------------------------------------------
	
	// this is the final distance value, undistorted by reversing the fishbowl effect
	wire signed [20:0] final_dist;
	
	int_fixed_point_mult_int reverse_fishbowl_calc (
	
		// performs calculation: final_dist = closer_dist * cos(beta)
	
		.int_in(closer_dist),
		.fixed_X({8'b0, cos_beta_X}),
		.fixed_Y(cos_beta_Y),
		
		.int_out(final_dist)
	
	);
	
	// ---------------------------------------- datapath output table  ------------------------------------------------
	
	always @(*)
	begin
		// these are registered since they all come through at different times for only a single clock pulse, but 
		// conditions involving these bools are checked at the end of the ray cast calculations
		if (end_raycast_horiz_wire) end_raycast_horiz <= 1'b1; 
		if (end_raycast_vert_wire) end_raycast_vert <= 1'b1;
		if (bounds_reached_horiz_wire) bounds_reached_horiz <= 1'b1;
		if (bounds_reached_vert_wire) bounds_reached_vert <= 1'b1;
	end
	
	always @(posedge clock)
	begin
	
		if (!resetn) begin
			abs_beta_X <= 0;
			abs_beta_Y <= 0;
			angle_offset_X <= 0;
			angle_offset_Y <= 0;
			distance_horiz <= 0;
			distance_vert <= 0;
			closer_dist <= 0;
			abs_playerX_horiz_diff <= 0;
			abs_playerX_vert_diff <= 0;
			projected_slice_size <= 0;
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
				
				if (angle_offset_Y > 0) begin
					if (angle_offset_X < half_FOV) begin
						beta_X <= (angle_offset_X +1) - half_FOV;
						beta_Y <= 1000 - angle_offset_Y;
						end
						else begin
						beta_X <= angle_offset_X - half_FOV;
						beta_Y <= 1000 - angle_offset_Y;
						end 
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
			
			if (find_alpha_beta_3) begin
			
				// alpha can take values from 0 to 359.625
				if (alpha_X < 0) begin
				
					// if alpha is lesser than 0 bring it up
					if (alpha_Y > 0) begin
						// if alpha_Y is not 0, remember that .125 is actually -0.125, adjust alpha_X and alpha_Y accordingly
						alpha_X <= alpha_X - 1 + 360;
						alpha_Y <= 1000 - alpha_Y;
					end else if (alpha_Y == 0) begin
						alpha_X <= alpha_X + 360;
					end
					
				end else if (alpha_X >= 360)
					// if alpha is greater than 360 bring it down
					alpha_X <= alpha_X - 360;
					
				// before the next state these bools must be 0, since they are checked after find_ray_grid_intersections
				end_raycast_horiz <= 1'b0;
				end_raycast_vert <= 1'b0;
				bounds_reached_horiz <= 1'b0;
				bounds_reached_vert <= 1'b0;
			end
			
			// find_ray_grid_intersections output controlled by raycast modules above
			
			if (find_distances_0) begin
				// take the abs of (playerX - wallX_horiz) and (playerX - wallX_vert) respectively
				
				if (playerX_horiz_diff < 0)
					abs_playerX_horiz_diff <= -playerX_horiz_diff;
				else
					abs_playerX_horiz_diff <= playerX_horiz_diff;
					
				if (playerX_vert_diff < 0)
					abs_playerX_vert_diff <= -playerX_vert_diff;
				else
					abs_playerX_vert_diff <= playerX_vert_diff;
			end
			
			if (find_distances_1) begin
				// save computed values into regs
				distance_horiz <= distance_horiz_computed;
				distance_vert <= distance_vert_computed;
			end
			
			if (find_distances_2) begin
				// take abs of distance_horiz and distance_vert
				if (distance_horiz < 0) distance_horiz <= -distance_horiz;
				if (distance_vert < 0) distance_vert <= -distance_vert;
			end
			
			if (find_closer_distance) begin
				if (bounds_reached_horiz) // wall found was at a vert intersection
					closer_dist <= distance_vert;
				else if (bounds_reached_vert) // wall found was at a horiz intersection
					closer_dist <= distance_horiz;
				else
					closer_dist <= (distance_horiz > distance_vert) ? distance_vert : distance_horiz;
			end
			
			if (perform_project_to_screen_0) begin
				// apply scaling factor to project this on ths screen
				projected_slice_size <= projection_scaling_factor / final_dist;
			end
			
			if (perform_project_to_screen_1) begin
			
				// limit this to max value for this resolution
				if (projected_slice_size > 120)
					slice_size <= 120;
				else
					slice_size <= projected_slice_size;
			end
			
		end
			
	end
										  
endmodule
