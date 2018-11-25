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
	
	// tells the datapath to find the angle offset from the left of the player's field of view
	wire find_angle_offset;
	
	// tells the datapath to find alpha and beta. alpha is the current raycast angle, and beta is the angle relative
	// to player angle, used to reverse the fishbowl effect
	wire find_alpha_beta_0;
	
	// tells the datapath to find the absolute value of beta, since cos(beta) = cos(-beta)
	wire find_alpha_beta_1;
	
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
		
		.find_angle_offset(find_angle_offset),
		.find_alpha_beta_0(find_alpha_beta_0),
		.find_alpha_beta_1(find_alpha_beta_1),
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
		
		.find_angle_offset(find_angle_offset),
		.find_alpha_beta_0(find_alpha_beta_0),
		.find_alpha_beta_1(find_alpha_beta_1),
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
