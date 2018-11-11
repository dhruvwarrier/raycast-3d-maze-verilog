`timescale 1ns/1ns

module find_wall_intersection_horiz
	(
		input [11:0] playerX, playerY, 				// player's current X and Y position
		input [11:0] alpha, 								// angle of ray currently being cast
		input clock, 										// On board clock, 50 MHz for the DE1_SoC
		input resetn, 										// active-low, resets the FSM and clears the datapath registers
		input begin_calc,									// begins calculation of wall intersection
		output [11:0] wall_X, wall_Y,					// calculated wall X and Y for this ray
		output wall_found									// high if wall is found, low if not
	);

	control FSM(
	
		.clock(clock),
		.resetn(resetn),
		
		// -------------------------------- inputs that affect FSM state -------------------------------------
		
		.begin_calc(begin_calc),
		
		.found_first_intersection(found_first_intersection),
		.found_XY_offset(found_XY_offset),
		.reached_wall(reached_wall),
		.reached_maze_bounds(reached_maze_bounds),
		
		// ------------------------------------ outputs to the datapath --------------------------------------
		
		.find_first_intersection(find_first_intersection),
		.find_offset(find_offset),
		.find_next_intersection(find_next_intersection),
		
		// --------------------------------- outputs to the higher-level module --------------------------------------
		
		.wall_found(wall_found)
	
	);
	
	datapath position_manip(
	
	);

endmodule