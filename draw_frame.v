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
		input resetn							// active-low resetn, clears the datapath registers and resets FSM
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
	
	// tells the FSM that drawing of this slice is complete and to compute the next slice
	wire draw_slice_complete;
	
	// tells the FSM that all the slices have been drawn and to go back to S_WAIT
	wire draw_frame_complete;

	control_draw_frame FSM (
	
		.clock(clock50MHz),
		.resetn(resetn),
		
		// -------------------------------- inputs that affect FSM state -------------------------------------
		
		.begin_frame_draw(clock60Hz),
		
		.clear_complete(clear_complete),
		.compute_size_complete(compute_size_complete),
		.draw_slice_complete(draw_slice_complete),
		.draw_frame_complete(draw_frame_complete),
		
		// ------------------------------------ outputs to the datapath --------------------------------------
		
		.load_player_attr(load_player_attr),
		.clear_counter_enable(clear_counter_enable),
		.compute_slice_size(compute_slice_size),
		.compute_slice_loc(compute_slice_loc),
		.draw_slice(draw_slice),
		
		// ------------------------------------ outputs to higher-level module --------------------------------------
		.draw_enable(draw_enable)
	
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
		.compute_size_complete(compute_slice_complete),
		.draw_slice_complete(draw_slice_complete),
		.draw_frame_complete(draw_frame_complete)
	
	);
	
endmodule

module control_draw_frame(input clock, resetn, begin_frame_draw, clear_complete, compute_size_complete,
								  draw_slice_complete, draw_frame_complete,
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
			S_WAIT: next_state = begin_frame_draw ? S_CLEAR_SCR : S_WAIT;
			S_CLEAR_SCR: next_state = clear_complete ? S_COMPUTE_SLICE_SIZE : S_CLEAR_SCR;
			S_COMPUTE_SLICE_SIZE: next_state = compute_size_complete ? S_COMPUTE_SLICE_LOC : S_COMPUTE_SLICE_SIZE;
			S_COMPUTE_SLICE_LOC : next_state = S_DRAW_SLICE; // provide 1 cycle to compute location
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
			S_DRAW_SLICE:
			begin
				draw_slice = 1'b1;
				draw_enable = 1'b1;
			end
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
									output clear_complete, compute_size_complete, draw_slice_complete, draw_frame_complete);
	// player attributes
	// Px and Py are playerX and playerY respectively, and a_X and a_Y are angle_X and angle_Y respectively
	// Stored in regs to keep them constant throughout drawing of the frame, use only these in calculations
	reg signed [12:0] Px, Py;
	reg signed [9:0] a_X, a_Y;
	
	// holds the generated X and Y positions to clear the screen
	reg [7:0] clear_counter_out_X;
	reg [6:0] clear_counter_out_Y;
	
	// computed by draw_slice module
	reg [6:0] slice_size;
	
	// computed in datapath after compute_slice_loc
	reg [6:0] slice_loc_Y;
	
	// iterates over the columns to draw different slices by casting one ray for each column 
	reg [7:0] column_count;
	
	// ------------------------------------- draw slice module instance  ----------------------------------------------
	
	// controlled by datapath 
	reg begin_slice_size_computation;
	// controlled by this module
	reg end_slice_size_computation;
	
	draw_slice draw_slice(
	
		.clock(clock),
		.resetn(resetn),
	
		// data inputs
		.playerX(Px),
		.playerY(Py),
		.angle_X(a_X),
		.angle_Y(a_Y),
		.column_count(column_count),
		
		// begin this calculation
		.begin_calc(begin_slice_size_computation),
		
		// computed output
		.slice_size(slice_size),
		// high when the calculation has ended
		.end_calc(end_slice_size_computation)
	
	);
	
	// ---------------------------------- VGA_draw_rectangle module instance  -----------------------------------------
	
	VGA_draw_rectangle(
	
	
	);
	
	// ---------------------------------------- datapath output table  ------------------------------------------------
	
	always @(posedge clock)
	begin
	
		if (!resetn) begin
			Px <= 12'b0;
			Py <= 12'b0;
			a_X <= 10'b0;
			a_Y <= 10'b0;
		end
		else begin
		
			if (load_player_attr) begin
				// store player attributes to keep them constant for this frame
				Px <= playerX;
				Py <= playerY;
				a_X <= alpha_X;
				a_Y <= alpha_Y;
				// prepare this 
				column_count <= 1;
			end
			
			// clear_counter_enable is handled by counter underneath
			
			if (compute_slice_size) begin
				// start the computation
				begin_slice_size_computation <= 1'b1;
				// when compute_size_complete turns high, it moves to the next state
				compute_size_complete <= end_slice_size_computation;
			end
			
			if (compute_slice_loc) begin
				 // if this overflows we'll get a max height slice, slice_size must be 120 or smaller
				 // this automatically floors the value, so for odd slice_size, the slice will be drawn 0.5 mega-pixel higher
				slice_loc_Y <= (120 - slice_size) / 2;
			end
			
			if (draw_slice) begin
				
			end
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
			clear_counter_out_X <= (clear_position_count % 160);
			clear_counter_out_Y <= (clear_position_count / 160);
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
			X_draw_pos <= 
	end
	
	always @(posedge clock)
	begin
		if (!resetn)
			Y_draw_pos <= 0;
		else if (clear_counter_enable)
			Y_draw_pos <= clear_counter_out_Y;
		else
			Y_draw_pos <= 
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
