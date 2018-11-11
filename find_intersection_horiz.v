`timescale 1ns/1ns

module find_wall_intersection_horiz
	(
		input [11:0] playerX, playerY, 				// player's current X and Y position
		input [11:0] alpha, 								// angle of ray currently being cast
		input clock, 										// On board clock, 50 MHz for the DE1_SoC
		input resetn, 										// active-low, resets the FSM and clears the datapath registers
		input begin_calc,									// begins calculation of wall intersection
		output [11:0] wallX, wallY,					// calculated wall X and Y for this ray
		output wall_found,								// high if wall is found, low if not
		output end_calc									// calculation has ended, whether wall found or not
	);
	
	// tells the datapath to calculate the first intersection of the ray with the grid
	wire find_first_intersection;
	
	// tells the datapath to calculate the X and Y offset to find new intersections of the ray with the grid
	wire find_offset;
	
	// tells the datapath to find the next intersection of the ray with the grid
	wire find_next_intersection;
	
	// tells the control that the first intersection was found
	wire found_first_intersection;
	
	// tells the control the X and Y offsets were found
	wire found_XY_offset;
	
	// if either reached_wall or reached_maze_bounds, start at the beginning and wait for begin_calc again
	wire reached_wall, reached_maze_bounds;
	
	// ------------------------------------ outputs to higher-level module --------------------------------------
	
	// wall_found is always reached_wall, if no wall is reached then end_calc is high but wall_found is 0
	assign wall_found = reached_wall;
	
	// high for one cycle when either wall is reached or bounds are reached
	assign end_calc = reached_wall || reached_maze_bounds;

	control FSM(
	
		.clock(clock),
		.resetn(resetn),
		
		// -------------------------------- inputs that affect FSM state -------------------------------------
		
		.begin_calc(begin_calc),
		
		.found_first_intersection(found_first_intersection),
		.found_XY_offset(found_XY_offset),
		// if either reached_wall or reached_maze_bounds, go back to beginning
		.reached_wall(reached_wall),
		.reached_maze_bounds(reached_maze_bounds),
		
		// ------------------------------------ outputs to the datapath --------------------------------------
		
		.find_first_intersection(find_first_intersection),
		.find_offset(find_offset),
		.find_next_intersection(find_next_intersection)
	
	);
	
	datapath position_manip(
	
		.clock(clock),
		.resetn(resetn),
		
		// ------------------------------------ control signals from FSM --------------------------------------
		
		.find_first_intersection(find_first_intersection),
		.find_offset(find_offset),
		.find_next_intersection(find_next_intersection),
		
		// ------------------------------------ data input and output --------------------------------------
		
		.playerX(playerX),
		.playerY(playerY),
		.alpha(alpha),
		
		// when reached_wall is high, currentX = wallX, currentY = wallY
		.currentX(wallX),
		.currentY(wallY),
		
		// ----------------------------------------- outputs to FSM -----------------------------------------
		// ----------------------- inform the FSM when calculations are complete --------------------------------
		
		.found_first_intersection(found_first_intersection),
		.found_XY_offset(found_XY_offset),
		.reached_wall(reached_wall),
		.reached_maze_bounds(reached_maze_bounds)
	
	);

endmodule

module control(input clock, resetn, begin_calc,
					found_first_intersection, found_XY_offset, reached_wall, reached_maze_bounds,
					output find_first_intersection, find_offset, find_next_intersection);
		
		reg [1:0] current_state, next_state;
		
		localparam S_WAIT = 2'd0,
					  S_FIND_FIRST = 2'd1,
					  S_FIND_OFFSET = 2'd2,
					  S_FIND_NEXT = 2'd3; // the datapath computes the next intersection and checks whether a wall exists there
		
		// ----------------------------------------- state table  ------------------------------------------------
		
		always @(*)
		begin: state_table
		
			case(current_state)
				S_WAIT: next_state = begin_calc ? S_FIND_FIRST : S_WAIT;
				S_FIND_FIRST: next_state = found_first_intersection ? S_FIND_OFFSET : S_FIND_FIRST;
				S_FIND_OFFSET: next_state = found_XY_offset ? S_FIND_NEXT : S_FIND_OFFSET;
				S_FIND_NEXT: next_state = (reached_wall || reached_maze_bounds) ? S_WAIT : S_FIND_NEXT;
				default: next_state = S_WAIT;
				
		end // state_table
		
		// ------------------------------------- current state registers  -------------------------------------------
		
		always @(posedge clock)
		begin: state_FFs
			if (!resetn)
				current_state <= S_WAIT;
			else
				current_state <= next_state; // at each clock cycle, move to the next computed state
		end // state_FFs
			
endmodule
					