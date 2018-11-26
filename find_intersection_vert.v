`timescale 1ns/1ns

module find_wall_intersection_vert
	(
		input signed [12:0] playerX, playerY, 		// player's current X and Y position
		input [9:0] alpha_X, 							// angle of ray currently being cast in fixed point format 
		input [9:0] alpha_Y,								// alpha_X is the left of the decimal point, alpha_Y is the right
		input clock, 										// On board clock, 50 MHz for the DE1_SoC
		input resetn, 										// active-low, resets the FSM and clears the datapath registers
		input begin_calc,									// begins calculation of wall intersection
		output signed [12:0] wallX, wallY,			// calculated wall X and Y for this ray
		output wall_found,								// high if wall is found, low if not
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
	wire check_for_wall;
	
	// if either reached_wall or reached_maze_bounds, start at the beginning and wait for begin_calc again
	wire reached_wall, reached_maze_bounds;
	
	// ------------------------------------ outputs to higher-level module --------------------------------------
	
	// wall_found is always reached_wall, if no wall is reached then end_calc is high but wall_found is 0
	assign wall_found = reached_wall;
	
	// high for one cycle when either wall is reached or bounds are reached
	assign end_calc = reached_wall || reached_maze_bounds;

	// this is the same control module in find_intersection_horiz.v
	control_find_intersection FSM(
	
		.clock(clock),
		.resetn(resetn),
		
		// -------------------------------- inputs that affect FSM state -------------------------------------
		
		.begin_calc(begin_calc),
		
		// if either reached_wall or reached_maze_bounds, go back to beginning
		.reached_wall(reached_wall),
		.reached_maze_bounds(reached_maze_bounds),
		
		// ------------------------------------ outputs to the datapath --------------------------------------
		
		.reset_datapath(reset_datapath),
		.find_first_intersection_0(find_first_intersection_0),
		.find_first_intersection_1(find_first_intersection_1),
		.find_offset_0(find_offset_0),
		.find_offset_1(find_offset_1),
		.find_next_intersection(find_next_intersection),
		.convert_to_grid_coords(convert_to_grid_coords),
		.check_for_wall(check_for_wall)
	
	);
	
	datapath_find_intersection_vert position_manip(
	
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
		.check_for_wall(check_for_wall),
		
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
		.reached_maze_bounds(reached_maze_bounds)
	
	);

endmodule

module datapath_find_intersection_vert (input clock, resetn,
					 reset_datapath, find_first_intersection_0, find_first_intersection_1,
					 find_offset_0, find_offset_1, find_next_intersection, 
					 convert_to_grid_coords, check_for_wall,
					 input signed [12:0] playerX, playerY,
					 input signed [9:0] alpha_X, input signed [9:0] alpha_Y,
					 output reg signed [12:0] currentX, currentY,
					 output reg reached_wall, reached_maze_bounds);
	
	// B_x, B_y are the coordinates of the first intersection
	// X_a, Y_a are the offsets used to calculate the next intersection
	// C_x, C_y is the current X and Y of the ray
	reg signed [20:0] B_x, B_y, X_a, Y_a, C_x, C_y;
	
	// S_FIND_NEXT sets currentX and currentY to the first intersection for the first iteration, and checks offset
	// intersections after
	reg checked_first_intersection;
	
	// ---------------------------------------- sin, cos, tan LUTs  --------------------------------------------------
	
	// sin, cos, tan LUTs take fixed points as inputs and give fixed points as outputs
	
	wire signed [9:0] tan_alpha_X;
	wire signed [17:0] tan_alpha_Y;
	
	tan_LUT lookup_TAN_value(.angleX(alpha_X),.angleY(alpha_Y),.ratioX(tan_alpha_X),.ratioY(tan_alpha_Y));
	
	// ------------------------------------ Fixed point multiplications  -----------------------------------------------
	
	wire signed [20:0] ray_proj_Y;
	
	int_fixed_point_mult_int multiplier_line_eq (
	
		// performs fixed point multiplication: ray_proj_Y = (playerX - B_x) * tan(alpha)
	
		.int_in(playerX - B_x),
		.fixed_X(tan_alpha_X),
		.fixed_Y(tan_alpha_Y),
		
		.int_out(ray_proj_Y)
	);
	
	wire signed [20:0] offset_proj_Y;
	
	int_fixed_point_mult_int multiplier_offset (
	
		// performs fixed point multiplication: offset_proj_Y = X_a * tan(alpha)
	
		.int_in(X_a),
		.fixed_X(tan_alpha_X),
		.fixed_Y(tan_alpha_Y),
		
		.int_out(offset_proj_Y)
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
			B_x <= 12'b0;
			B_y <= 12'b0;
			X_a <= 12'b0;
			Y_a <= 12'b0;
			C_x <= 12'b0;
			C_y <= 12'b0;
		end
		else begin
		
			if (reset_datapath) begin
				checked_first_intersection <= 1'b0;
				reached_maze_bounds <= 1'b0;
			end
		
			if (find_first_intersection_0) begin
				if (alpha_X >= 90 && alpha_X < 270) // ray facing left
					B_x <= $floor(playerX / 64) * 64 - 1; // subtract 1 to make B part of the grid block to the left of the grid line
				else if ((alpha_X >= 270 && alpha_X < 360) || (alpha_X >= 0 && alpha_X < 90)) // ray facing right
					B_x <= $floor(playerX / 64) * 64 + 64; // add 64 to make B_x the X position of the next grid block
			end
			
			if (find_first_intersection_1) begin
				// find B_y by line equation, look above for calculation of ray_proj_Y
				// must check if these generated B_x and B_y are out of bounds
				B_y <= playerY + ray_proj_Y;
			end
			
			if (find_offset_0) begin
				if (alpha_X >= 90 && alpha_X < 270) // ray facing left
					X_a <= -64;
				else if ((alpha_X >= 270 && alpha_X < 360) || (alpha_X >= 0 && alpha_X < 90)) // ray facing right
					X_a <= 64;
			end
			
			if (find_offset_1)
				Y_a <= offset_proj_Y; // slope equation, look above for calculation of offset_proj_Y
			
			if (find_next_intersection) begin
			
				// set next intersection to first intersection in the first iteration so that it is also checked for a wall
				if (!checked_first_intersection) begin
					C_x <= B_x;
					C_y <= B_y;
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
					grid_address <= 64 * $floor(C_y / 64) + $floor(C_x / 64); // flatten a 2D grid address into a 1D address
			end
			
			if (check_for_wall) begin
				// by this state, the RAM should have responded with the data at the grid_address
				reached_wall <= grid_out;
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
