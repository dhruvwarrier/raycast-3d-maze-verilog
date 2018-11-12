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
	
	// tells the datapath to check whether a wall exists at this grid coordinate by communicating with the grid register
	wire check_for_wall;
	
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
		
		// if either reached_wall or reached_maze_bounds, go back to beginning
		.reached_wall(reached_wall),
		.reached_maze_bounds(reached_maze_bounds),
		
		// ------------------------------------ outputs to the datapath --------------------------------------
		
		.find_first_intersection(find_first_intersection),
		.find_offset(find_offset),
		.find_next_intersection(find_next_intersection),
		.check_for_wall(check_for_wall)
	
	);
	
	datapath position_manip(
	
		.clock(clock),
		.resetn(resetn),
		
		// ------------------------------------ control signals from FSM --------------------------------------
		
		.find_first_intersection(find_first_intersection),
		.find_offset(find_offset),
		.find_next_intersection(find_next_intersection),
		.check_for_wall(check_for_wall),
		
		// ------------------------------------ data input and output --------------------------------------
		
		.playerX(playerX),
		.playerY(playerY),
		.alpha(alpha),
		
		// when reached_wall is high, currentX = wallX, currentY = wallY
		.currentX(wallX),
		.currentY(wallY),
		
		// ----------------------------------------- outputs to FSM -----------------------------------------
		// ------------------- inform the FSM if a wall or maze bounds have been reached ----------------------------
		
		.reached_wall(reached_wall),
		.reached_maze_bounds(reached_maze_bounds)
	
	);

endmodule

module control(input clock, resetn, begin_calc,
					reached_wall, reached_maze_bounds,
					output reg find_first_intersection, find_offset, find_next_intersection, check_for_wall);
		
	reg [2:0] current_state, next_state;
	
	localparam S_WAIT = 3'd0,
				  S_FIND_FIRST = 3'd1,
				  S_FIND_OFFSET = 3'd2,
				  S_FIND_NEXT = 3'd3,
				  S_CHECK_WALL = 3'd4;
				  
	// ----------------------------------------- state table  ------------------------------------------------
	
	always @(*)
	begin: state_table
	
		case(current_state)
			S_WAIT: next_state = begin_calc ? S_FIND_FIRST : S_WAIT;
			S_FIND_FIRST: next_state = S_FIND_OFFSET; // provide a state to find the first intersection
			S_FIND_OFFSET: next_state = S_FIND_NEXT; // provide a state to find the X and Y offsets
			S_FIND_NEXT: next_state = S_CHECK_WALL; // provide a state to find the next intersection
			// check with the grid register for a wall or maze bounds, else go back to S_FIND_NEXT
			S_CHECK_WALL: next_state = (reached_wall || reached_maze_bounds) ? S_WAIT : S_FIND_NEXT;
			default: next_state = S_WAIT;
		endcase
				
	end // state_table
		
	// ------------------------------- output logic i.e. control signal logic  -------------------------------------
	
	always @(*)
	begin: control_signals

		// prevent latching by assuming all control signals to be 0 at the beginning
		find_first_intersection = 1'b0;
		find_offset = 1'b0;
		find_next_intersection = 1'b0;
		check_for_wall = 1'b0;
		
		case(current_state)
			S_FIND_FIRST: find_first_intersection = 1'b1;
			S_FIND_OFFSET: find_offset = 1'b1;
			S_FIND_NEXT: find_next_intersection = 1'b1;
			S_CHECK_WALL: check_for_wall = 1'b1;
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

module datapath(input clock, resetn,
					 find_first_intersection, find_offset, find_next_intersection, check_for_wall,
					 input [11:0] playerX, playerY, alpha,
					 output reg [11:0] currentX, currentY,
					 output reg reached_wall, reached_maze_bounds);

	
					 
endmodule
