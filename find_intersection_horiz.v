`timescale 1ns/1ns

module find_wall_intersection_horiz
	(
		input signed [12:0] playerX, playerY, 		// player's current X and Y position
		input [9:0] alpha_X, 							// angle of ray currently being cast in fixed point format 
		input [9:0] alpha_Y,								// alpha_X is the left of the decimal point, alpha_Y is the right
		input clock, 										// On board clock, 50 MHz for the DE1_SoC
		input resetn, 										// active-low, resets the FSM and clears the datapath registers
		input begin_calc,									// begins calculation of wall intersection
		output signed [12:0] wallX, wallY,			// calculated wall X and Y for this ray
		output wall_found,								// high if wall is found, low if not
		output maze_bounds_reached,					// high if the ray reached maze bounds without intersecting with the grid 
		output end_calc									// calculation has ended, whether wall found or not
	);
	
	// tells the datapath to reset values in preparation for calculation
	wire reset_datapath;
	
	// tells the datapath to calculate the first intersection of the ray with the grid, cycle 0
	wire find_first_intersection_0;
	
	// tells the datapath to calculate the first intersection of the ray with the grid, cycle 1
	wire find_first_intersection_1;
	
	// tells the datapath to calculate the X and Y offset to find new intersections of the ray with the grid, cycle 0
	wire find_offset_0;
	
	// tells the datapath to calculate the X and Y offset to find new intersections of the ray with the grid, cycle 1
	wire find_offset_1;
	
	// tells the datapath to find the next intersection of the ray with the grid
	wire find_next_intersection;
	
	// tells the datapath to convert an X, Y intersection to a grid coordinate
	wire convert_to_grid_coords;
	
	// tells the datapath to check whether a wall exists at this grid coordinate by communicating with the grid register
	wire check_for_wall_0, check_for_wall_1;
	
	// if either reached_wall or reached_maze_bounds, start at the beginning and wait for begin_calc again
	wire reached_wall, reached_maze_bounds;
	
	// tell the FSM that wall checking or bounds checking is complete, and to transition states as required
	wire end_wall_checking, end_bounds_checking;
	
	// ------------------------------------ outputs to higher-level module --------------------------------------
	
	// wall_found is always reached_wall, if no wall is reached then end_calc is high but wall_found is 0
	assign wall_found = reached_wall;
	assign maze_bounds_reached = reached_maze_bounds;
	
	// high for one cycle when either wall is reached or bounds are reached
	assign end_calc = reached_wall || reached_maze_bounds;

	control_find_intersection FSM(
	
		.clock(clock),
		.resetn(resetn),
		
		// -------------------------------- inputs that affect FSM state -------------------------------------
		
		.begin_calc(begin_calc),
		
		// if either reached_wall or reached_maze_bounds, go back to beginning
		.reached_wall(reached_wall),
		.reached_maze_bounds(reached_maze_bounds),
		.end_bounds_checking(end_bounds_checking),
		.end_wall_checking(end_wall_checking),
		
		// ------------------------------------ outputs to the datapath --------------------------------------
		
		.reset_datapath(reset_datapath),
		.find_first_intersection_0(find_first_intersection_0),
		.find_first_intersection_1(find_first_intersection_1),
		.find_offset_0(find_offset_0),
		.find_offset_1(find_offset_1),
		.find_next_intersection(find_next_intersection),
		.convert_to_grid_coords(convert_to_grid_coords),
		.check_for_wall_0(check_for_wall_0),
		.check_for_wall_1(check_for_wall_1)
	
	);
	
	datapath_find_intersection_horiz position_manip(
	
		.clock(clock),
		.resetn(resetn),
		
		// ------------------------------------ control signals from FSM --------------------------------------
		
		.reset_datapath(reset_datapath),
		.find_first_intersection_0(find_first_intersection_0),
		.find_first_intersection_1(find_first_intersection_1),
		.find_offset_0(find_offset_0),
		.find_offset_1(find_offset_1),
		.find_next_intersection(find_next_intersection),
		.convert_to_grid_coords(convert_to_grid_coords),
		.check_for_wall_0(check_for_wall_0),
		.check_for_wall_1(check_for_wall_1),
		
		
		// ------------------------------------ data input and output --------------------------------------
		
		.playerX(playerX),
		.playerY(playerY),
		.alpha_X(alpha_X),
		.alpha_Y(alpha_Y),
		
		// when reached_wall is high, currentX = wallX, currentY = wallY
		.currentX(wallX),
		.currentY(wallY),
		
		// ----------------------------------------- outputs to FSM -----------------------------------------
		// ------------------- inform the FSM if a wall or maze bounds have been reached ----------------------------
		
		.reached_wall(reached_wall),
		.reached_maze_bounds(reached_maze_bounds),
		.end_bounds_checking(end_bounds_checking),
		.end_wall_checking(end_wall_checking)
	
	);

endmodule

module control_find_intersection (input clock, resetn, begin_calc,
					reached_wall, reached_maze_bounds, end_wall_checking, end_bounds_checking,
					output reg reset_datapath, find_first_intersection_0, find_first_intersection_1,
					find_offset_0, find_offset_1, find_next_intersection, 
					convert_to_grid_coords, check_for_wall_0, check_for_wall_1);
		
	reg [3:0] current_state, next_state;
	
	localparam S_WAIT = 4'd0,
				  S_FIND_FIRST_0 = 4'd1,
				  S_FIND_FIRST_1 = 4'd2,
				  S_FIND_OFFSET_0 = 4'd3,
				  S_FIND_OFFSET_1 = 4'd4,
				  S_FIND_NEXT = 4'd5,
				  S_CONVERT_TO_GRID = 4'd6,
				  S_CHECK_WALL_0 = 4'd7,
				  S_CHECK_WALL_1 = 4'd8;
				  
	// ----------------------------------------- state table  ------------------------------------------------
	
	always @(*)
	begin: state_table
	
		case(current_state)
			S_WAIT: next_state = begin_calc ? S_FIND_FIRST_0 : S_WAIT;
			S_FIND_FIRST_0: next_state = S_FIND_FIRST_1; // provide 2 states to find the first intersection
			S_FIND_FIRST_1: next_state = S_FIND_OFFSET_0;
			S_FIND_OFFSET_0: next_state = S_FIND_OFFSET_1; // provide 2 states to find the X and Y offsets
			S_FIND_OFFSET_1: next_state = S_FIND_NEXT; 
			S_FIND_NEXT: next_state = S_CONVERT_TO_GRID; // provide a state to find the next intersection
			S_CONVERT_TO_GRID:
			begin// provide a state to compute grid coordinates of this intersection
				// tackle in order of priority
				if (!end_bounds_checking) next_state = S_CONVERT_TO_GRID;
				else if (reached_maze_bounds) next_state = S_WAIT; // bounds checking ended but did we go out of bounds?
				else next_state = S_CHECK_WALL_0; // we didn't go out of bounds, we can check for a wall at this intersection
			end
			// check with the grid register for a wall, if found go back to S_FIND_NEXT
			S_CHECK_WALL_0: next_state = S_CHECK_WALL_1; // provide 2 states to check for wall
			// retreive wall_found from level_data grid, then check whether reached in the next state
			S_CHECK_WALL_1: next_state = reached_wall ? S_WAIT : S_FIND_NEXT;
			default: next_state = S_WAIT;
		endcase
				
	end // state_table
		
	// ------------------------------- output logic i.e. control signal logic  -------------------------------------
	
	always @(*)
	begin: control_signals

		// prevent latching by assuming all control signals to be 0 at the beginning
		reset_datapath = 1'b0;
		find_first_intersection_0 = 1'b0;
		find_first_intersection_1 = 1'b0;
		find_offset_0 = 1'b0;
		find_offset_1 = 1'b0;
		find_next_intersection = 1'b0;
		convert_to_grid_coords = 1'b0;
		check_for_wall_0 = 1'b0;
		check_for_wall_1 = 1'b0;
		
		case(current_state)
			S_WAIT: reset_datapath = 1'b1;
			S_FIND_FIRST_0: find_first_intersection_0 = 1'b1;
			S_FIND_FIRST_1: find_first_intersection_1 = 1'b1;
			S_FIND_OFFSET_0: find_offset_0 = 1'b1;
			S_FIND_OFFSET_1: find_offset_1 = 1'b1;
			S_FIND_NEXT: find_next_intersection = 1'b1;
			S_CONVERT_TO_GRID: convert_to_grid_coords = 1'b1;
			S_CHECK_WALL_0: check_for_wall_0 = 1'b1;
			S_CHECK_WALL_1: check_for_wall_1 = 1'b1;
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

module datapath_find_intersection_horiz (input clock, resetn,
					 reset_datapath, find_first_intersection_0, find_first_intersection_1,
					 find_offset_0, find_offset_1, find_next_intersection, 
					 convert_to_grid_coords, check_for_wall_0, check_for_wall_1,
					 input signed [12:0] playerX, playerY, 
					 input signed [9:0] alpha_X, input signed [9:0] alpha_Y,
					 output reg signed [12:0] currentX, currentY,
					 output reg reached_wall, reached_maze_bounds, end_wall_checking, end_bounds_checking);
	
	// A_x, A_y are the coordinates of the first intersection
	// X_a, Y_a are the offsets used to calculate the next intersection
	// C_x, C_y is the current X and Y of the ray
	reg signed [20:0] A_x, A_y, X_a, Y_a, C_x, C_y;
	
	// S_FIND_NEXT sets currentX and currentY to the first intersection for the first iteration, and checks offset
	// intersections after
	reg checked_first_intersection;
	
	// ---------------------------------------- sin, cos, tan LUTs  --------------------------------------------------
	
	// sin, cos, tan LUTs take fixed points as inputs and give fixed points as outputs
	
	wire signed [9:0] tan_alpha_X;
	wire signed [17:0] tan_alpha_Y;
	
	tan_LUT lookup_TAN_value(.angleX(alpha_X),.angleY(alpha_Y),.ratioX(tan_alpha_X),.ratioY(tan_alpha_Y));
	
	// ---------------------------------------- Fixed point divisions  ------------------------------------------------
	
	wire signed [20:0] ray_proj_X;
	
	int_fixed_point_div_int divider_line_eq (
		
		// performs fixed point division: ray_proj_X = (playerY - A_y) / tan(alpha)
		
		.int_in(playerY - A_y),
		.fixed_X(tan_alpha_X),
		.fixed_Y(tan_alpha_Y),
		
		.int_out(ray_proj_X)
	);
	
	wire signed [20:0] offset_proj_X;
	
	int_fixed_point_div_int divider_offset (
		
		// performs fixed point division: offset_proj_X = -Y_a / tan(alpha)
	
		.int_in(-Y_a),
		.fixed_X(tan_alpha_X),
		.fixed_Y(tan_alpha_Y),
		
		.int_out(offset_proj_X)
	);
	
	// ----------------------------------- communication with grid RAM block ------------------------------------------
	
	// 12-bit grid address to address 4096 possible grid locations (0-63, 0-63)
	reg [11:0] grid_address;
	
	// high if a wall exists at this grid, else low
	wire grid_out;
	
	// how do we create a .mif file to initialize RAM block with level data?
	
	//ram4096x1 grid();
	
	// temporary solution is a lookup table that returns level data
	grid2D level_data(.grid_address(grid_address),.grid_out(grid_out));
	
	// ---------------------------------------- datapath output table  ------------------------------------------------
	
	always @(posedge clock)
	begin
	
		if (!resetn) begin
			A_x <= 12'b0;
			A_y <= 12'b0;
			X_a <= 12'b0;
			Y_a <= 12'b0;
			C_x <= 12'b0;
			C_y <= 12'b0;
		end
		else begin
		
			if (reset_datapath) begin
				// reset all the bools used in the datapath
				checked_first_intersection <= 1'b0;
				reached_wall <= 1'b0;
				reached_maze_bounds <= 1'b0;
				end_wall_checking <= 1'b0;
				end_bounds_checking <= 1'b0;
			end
		
			if (find_first_intersection_0) begin
				if (alpha_X >= 0 && alpha_X < 180) // ray facing up
					A_y <= (playerY / 64) * 64 - 1; // subtract 1 to make A part of the grid block above the grid line
				else if (alpha_X >= 180 && alpha_X < 360) // ray facing down
					A_y <= (playerY / 64) * 64 + 64; // add 64 to make A_y the Y position of the next grid block
			end
			
			if (find_first_intersection_1) begin
				// find A_x by line equation, look above for calculation of ray_proj_X
				// must check if these generated A_x and A_y are out of bounds
				A_x <= playerX + ray_proj_X;
			end
			
			if (find_offset_0) begin
				if (alpha_X >= 0 && alpha_X < 180)
					Y_a <= -64;
				else if (alpha_X >= 180 && alpha_X < 360)
					Y_a <= 64;
			end
			
			if (find_offset_1)
				X_a <= offset_proj_X; // slope equation, look above for calculation of offset_proj_X
			
			if (find_next_intersection) begin
			
				// reset these in preparation for checking for bounds and then wall
				end_wall_checking <= 1'b0;
				end_bounds_checking <= 1'b0;
				
				// set next intersection to first intersection in the first iteration so that it is also checked for a wall
				if (!checked_first_intersection) begin
					C_x <= A_x;
					C_y <= A_y;
					checked_first_intersection <= 1'b1;
				end else begin
					// add the offset to current coordinate to find next coordinate
					C_x <= C_x + X_a;
					C_y <= C_y + Y_a;
				end
			end
			
			if (convert_to_grid_coords) begin
			
				// first check if C_x and C_y are out of bounds. if out of bounds, quit here and go back to S_WAIT
				if (C_x >= 4096 || C_y >= 4096 || C_x <= 0 || C_y <= 0)
					reached_maze_bounds <= 1'b1;
				else
					grid_address <= 64 * (C_y / 64) + (C_x / 64); // flatten a 2D grid address into a 1D address
				
				// we're done checking bounds, update the FSM
				end_bounds_checking <= 1'b1;
			end
			
			if (check_for_wall_0) begin
				// by this state, the RAM should have responded with the data at the grid_address
				reached_wall <= grid_out;
			end
			
			if (check_for_wall_1) begin
				// we're done checking for a wall, update the FSM
				end_wall_checking <= 1'b1;
			end
			
		end
	
	end
	
	// ------------------------------------------- output registers --------------------------------------------------
	
	always @(posedge clock)
	begin
		if (!resetn)
			currentX <= 0;
		else
			currentX <= C_x; // C_x is registered to keep it stable for 1 clock cycle
	end
	
	always @(posedge clock)
	begin
		if (!resetn)
			currentY <= 0;
		else
			currentY <= C_y; // C_y is registered to keep it stable for 1 clock cycle
	end
					 
endmodule
