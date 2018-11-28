`timescale 1ns/1ns

module draw_frame
	(
		input signed [12:0] playerX,		// player X position, loaded into memory at the beginning of a frame calculation
		input signed [12:0] playerY, 		// player Y position, loaded into memory at the beginning of a frame calculation
		input signed [9:0] angle_X, 		// player angle, fixed point format, loaded into memory in S_WAIT
		input signed [9:0] angle_Y,		// angle_X is the left of the decimal point, angle_Y is the right
		input [2:0] slice_color,			// color of each drawn slice (160 slices in one frame)
		input clock50MHz,						// 50 MHz clock from DE1-SoC
		input clock60Hz,						// rate-divided clock, used to drive draw_frame at 60 frames per second
		input resetn,							// active-low resetn, clears the datapath registers and resets FSM
		output [2:0] color_out,				// slice_color flows to color_out when a frame is being drawn, else is set to 000 
													// when the frame is being cleared
		output [7:0] X,						// generated X position to draw a mega-pixel at
		output [6:0] Y,						// generated Y position to draw a mega-pixel at
		output draw_enable					// write enable to the frame buffer in vga_adapter
	);
	
	// ------------------------------------------ Control to datapath --------------------------------------------------
	
	// tells the datapath to load player attributes (playerX, playerY, alpha_X, alpha_Y)
	wire load_player_attr;
	
	// tells the datapath to start counting through positions to clear the screen
	wire clear_counter_enable;
	
	// tells the datapath to compute the size of the slice (integer, 1 to 120)
	wire compute_slice_size;
	
	// tells the datapath to compute the y location of the slice (integer, 0 to 119)
	wire compute_slice_loc;
	
	// tells the datapath to draw a slice of the screen (1 column, 160 of these at 160x120 resolution)
	wire draw_slice;
	
	// ------------------------------------------ Datapath to control --------------------------------------------------
	
	// tells the FSM that clearing is complete and to start drawing the frame
	wire clear_complete;
	
	// tells the FSM that slice size computations are complete for this slice
	wire compute_size_complete;
	
	// tells the FSM to skip attempting to draw this slice
	wire skip_this_slice;
	
	// tells the FSM that drawing of this slice is complete and to compute the next slice
	wire draw_slice_complete;
	
	// tells the FSM that all the slices have been drawn and to go back to S_WAIT
	wire draw_frame_complete;
	
	// ------------------------------------------ Higher-level module --------------------------------------------------
	
	// draw_enables from the FSM and datapath respectively
	wire draw_enable_clearscr, draw_enable_slice;
	
	// draw_enable can be driven by FSM to clear the screen or by the datapath's VGA_draw_rectangle to draw a slice
	assign draw_enable = draw_enable_clearscr || draw_enable_slice;

	control_draw_frame FSM (
	
		.clock(clock50MHz),
		.resetn(resetn),
		
		// -------------------------------- inputs that affect FSM state -------------------------------------
		
		.begin_frame_draw(clock60Hz),
		
		.clear_complete(clear_complete),
		.compute_size_complete(compute_size_complete),
		.skip_this_slice(skip_this_slice),
		.draw_slice_complete(draw_slice_complete),
		.draw_frame_complete(draw_frame_complete),
		
		// ------------------------------------ outputs to the datapath --------------------------------------
		
		.load_player_attr(load_player_attr),
		.clear_counter_enable(clear_counter_enable),
		.compute_slice_size(compute_slice_size),
		.compute_slice_loc(compute_slice_loc),
		.draw_slice(draw_slice),
		
		// ------------------------------------ outputs to higher-level module --------------------------------------
		.draw_enable(draw_enable_clearscr)
	
	);
	
	datapath_draw_frame draw_slices(
	
		.clock(clock50MHz),
		.resetn(resetn),
		
		// ------------------------------------ control signals from FSM --------------------------------------
		
		.load_player_attr(load_player_attr),
		.clear_counter_enable(clear_counter_enable),
		.compute_slice_size(compute_slice_size),
		.compute_slice_loc(compute_slice_loc),
		.draw_slice(draw_slice),
		
		// -------------------------------------- data input and output ---------------------------------------
		
		.playerX(playerX),
		.playerY(playerY),
		.angle_X(angle_X),
		.angle_Y(angle_Y),
		.color_in(slice_color),
		
		.X_draw_pos(X),
		.Y_draw_pos(Y),
		.color_out(color_out),
		
		// ----------------------------------------- outputs to FSM -----------------------------------------
		// ------------------- inform the FSM that computations, clearing, or drawing is complete ---------------------
		
		.clear_complete(clear_complete),
		.compute_size_complete(compute_size_complete),
		.skip_this_slice(skip_this_slice),
		.draw_slice_complete(draw_slice_complete),
		.draw_frame_complete(draw_frame_complete),
		
		// ------------------------------------ outputs to higher-level module --------------------------------------
		.draw_enable(draw_enable_slice)
	
	);
	
endmodule

module control_draw_frame(input clock, resetn, begin_frame_draw, clear_complete, compute_size_complete,
								  draw_slice_complete, draw_frame_complete, skip_this_slice,
								  output reg load_player_attr, clear_counter_enable, compute_slice_size,
								  compute_slice_loc, draw_slice, draw_enable);
								  
	reg [2:0] current_state, next_state;

	localparam S_WAIT = 3'd0,
				  S_CLEAR_SCR = 3'd1,
				  S_COMPUTE_SLICE_SIZE = 3'd2,
				  S_COMPUTE_SLICE_LOC = 3'd3,
				  S_DRAW_SLICE = 3'd4;
	
	// ----------------------------------------- state table  ------------------------------------------------
	
	always @(*)
	begin: state_table
	
		case(current_state)
			S_WAIT: next_state = begin_frame_draw ? S_CLEAR_SCR : S_WAIT; //next_state = S_CLEAR_SCR;
			S_CLEAR_SCR: next_state = clear_complete ? S_COMPUTE_SLICE_SIZE : S_CLEAR_SCR;
			S_COMPUTE_SLICE_SIZE: next_state = compute_size_complete ? S_COMPUTE_SLICE_LOC : S_COMPUTE_SLICE_SIZE;
			S_COMPUTE_SLICE_LOC: // provide 1 cycle to compute location
			begin
				if (skip_this_slice) next_state = S_COMPUTE_SLICE_SIZE; // start again at the next slice if true
				else next_state = S_DRAW_SLICE;
			end
			S_DRAW_SLICE:
			begin
				// tackle possibilities in order of priority
				if (draw_frame_complete) next_state = S_WAIT;
				else if (draw_slice_complete) next_state = S_COMPUTE_SLICE_SIZE;
				else next_state = S_DRAW_SLICE; // otherwise stay in this state
			end
			default: next_state = S_WAIT;
		endcase
		
	end // state_table
	
	// ------------------------------- output logic i.e. control signal logic  -------------------------------------
	
	always @(*)
	begin: control_signals
	
		// prevent latching by assuming all control signals to be 0 at the beginning
		// i.e. 0 in all other states except where explicitly set to 1
		load_player_attr = 1'b0;
		clear_counter_enable = 1'b0;
		compute_slice_size = 1'b0;
		compute_slice_loc = 1'b0;
		draw_slice = 1'b0;
		draw_enable = 1'b0;
		
		case(current_state)
			S_WAIT: load_player_attr = 1'b1;
			S_CLEAR_SCR: 
			begin
				clear_counter_enable = 1'b1;
				draw_enable = 1'b1; // so we can draw black pixels over the entire screen
			end
			S_COMPUTE_SLICE_SIZE: compute_slice_size = 1'b1;
			S_COMPUTE_SLICE_LOC: compute_slice_loc = 1'b1;
			S_DRAW_SLICE: draw_slice = 1'b1; // draw_enable for this is controlled by the datapath's VGA_draw_rectangle
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

module datapath_draw_frame(input clock, resetn, load_player_attr, clear_counter_enable, compute_slice_size,
									compute_slice_loc, draw_slice,
									input signed [12:0] playerX, playerY, input signed [9:0] angle_X, angle_Y,
									input [2:0] color_in,
									output reg [7:0] X_draw_pos, output reg [6:0] Y_draw_pos, output [2:0] color_out,
									output reg skip_this_slice, output compute_size_complete, clear_complete, 
									draw_slice_complete, draw_enable, draw_frame_complete);
	
	// screen size in X
	localparam screen_size_columns = 160;
	
	// player attributes
	// Px and Py are playerX and playerY respectively, and a_X and a_Y are angle_X and angle_Y respectively
	// Stored in regs to keep them constant throughout drawing of the frame, use only these in calculations
	reg signed [12:0] Px, Py;
	reg signed [9:0] a_X, a_Y;
	
	// holds the generated X and Y positions to clear the screen
	reg [7:0] clear_counter_out_X;
	reg [6:0] clear_counter_out_Y;
	
	// computed by draw_slice module
	wire [6:0] slice_size;
	
	// computed in datapath after compute_slice_loc
	reg [6:0] slice_loc_Y;
	
	// holds the generated X and Y positions from the VGA_draw_rectangle module (draw_slice)
	wire [7:0] draw_slice_out_X;
	wire [6:0] draw_slice_out_Y;
	
	// iterates over the columns to draw different slices by casting one ray for each column 
	reg [7:0] column_count;
	
	// color_out is black when clearing the screen, else color_in simply flows out to color_out
	assign color_out = (clear_counter_enable) ? 3'b000 : color_in;
	
	// ------------------------------------- draw_slice module instance  ----------------------------------------------
	
	// this is registered and checked in the next state (S_COMPUTE_SLICE_LOC)
	wire skip_this_slice_wire;
	
	find_slice_size find_slice_size (
	
		.clock(clock),
		.resetn(resetn),
	
		// begin this calculation when reached S_COMPUTE_SLICE_SIZE
		.begin_calc(compute_slice_size),
	
		// ------------------------------ data inputs ---------------------------------
		.playerX(playerX),
		.playerY(playerY),
		.angle_X(angle_X),
		.angle_Y(angle_Y),
		.column_count(column_count),
		
		// ---------------------- data outputs + end signal ---------------------------
		// computed output
		.slice_size(slice_size),
		.skip_this_slice(skip_this_slice_wire), // tells the FSM to skip attempting to draw this slice
		// high when the calculation has ended
		.end_calc(compute_size_complete)
	
	);
	
	// ---------------------------------- VGA_draw_rectangle module instance  -----------------------------------------
	
	VGA_draw_rectangle VGA_draw_slice(
	
		.clock(clock),
		.resetn(resetn),
		
		// begin plotting of slice when reached S_DRAW_SLICE
		.start_plot(draw_slice),
		
		// ---------------------------- data inputs -----------------------------------
		// column_count is the X_pos at which this slice needs to be drawn
		.X_pos_in(column_count),
		.Y_pos_in(slice_loc_Y),
		.rect_size(slice_size),
		.color_in(color_in),
		
		// ---------------------- data outputs + end signal ---------------------------
		.plot_enable(draw_enable),
		.X(draw_slice_out_X),
		.Y(draw_slice_out_Y),
		// high when the slice has been drawn
		.end_plot(draw_slice_complete)
		
		// forget color_out for now, since we don't have to change the color

	);
	
	// ---------------------------------------- datapath output table  ------------------------------------------------
	
	always @(*)
	begin
		if (skip_this_slice_wire) skip_this_slice <= 1'b1; 
	end
	
	// when we've finished drawing all slices, update the FSM
	assign draw_frame_complete = (column_count == screen_size_columns) ? 1'b1 : 1'b0;
	
	always @(posedge clock)
	begin
	
		if (!resetn) begin
			Px <= 12'b0;
			Py <= 12'b0;
			a_X <= 10'b0;
			a_Y <= 10'b0;
			column_count <= 0;
		end
		else begin
		
			if (load_player_attr) begin
				// store player attributes to keep them constant for this frame
				Px <= playerX;
				Py <= playerY;
				a_X <= angle_X;
				a_Y <= angle_Y;
				// prepare the column count, which must count from 1 to 160
				column_count <= 1;
				skip_this_slice <= 1'b0; // reset this bool
			end
			
			// clear_counter_enable is handled by counter underneath
			
			// compute_slice_size handled by find_slice_size module above
			
			if (compute_slice_loc) begin
				 // if this overflows we'll get a max height slice, slice_size must be 120 or smaller
				 // this automatically floors the value, so for odd slice_size, the slice will be drawn 0.5 mega-pixel higher
				slice_loc_Y <= (120 - slice_size) / 2;
				// we're done with this column, prepare column count for next slice
				column_count <= column_count + 1;
			end
			
			// draw_frame handled by VGA_draw_rectangle module above
			
		end
	end
	
	// ----------------------------------------- screen clear counter  -----------------------------------------------
	
	wire [14:0] clear_position_count;
	
	counter_to_19200 count_pos(
	
		.clock(clock),
		.resetn(clear_counter_enable),
		
		.Q(clear_position_count),
		.count_complete(clear_complete)
	
	);
	
	// ------------------------------------- screen clear position calculation ----------------------------------------

	always @(posedge clock)
	begin
		if (clear_counter_enable) begin
			// if counter is enabled and not completed yet, increment over all pixels on the screen
			clear_counter_out_X <= (clear_position_count % screen_size_columns);
			clear_counter_out_Y <= (clear_position_count / screen_size_columns);
		end
	end

	// -------------------------------------- output position registers  -----------------------------------------------
	
	// registered to keep outputs stable for 1 clock cycle
	
	always @(posedge clock)
	begin
		if (!resetn)
			X_draw_pos <= 0;
		else if (clear_counter_enable)
			X_draw_pos <= clear_counter_out_X;
		else
			X_draw_pos <= draw_slice_out_X;
	end
	
	always @(posedge clock)
	begin
		if (!resetn)
			Y_draw_pos <= 0;
		else if (clear_counter_enable)
			Y_draw_pos <= clear_counter_out_Y;
		else
			Y_draw_pos <= draw_slice_out_Y;
	end
	
	
endmodule

module counter_to_19200(input clock, resetn, output reg [14:0] Q, output reg count_complete);

	// counter counts from 0 to 19200 and then resets

	always @(posedge clock)
	begin
	
		count_complete = 1'b0;
	
		if (resetn == 1'b0)
			Q <= 0;
		else if (Q == 15'b100101100000001) begin
			count_complete = 1'b1;
			Q <= 0;
		end else
			Q <= Q + 1;
		
	end

endmodule
