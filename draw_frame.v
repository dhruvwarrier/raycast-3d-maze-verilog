`timescale 1ns/1ns

module draw_frame
	(
		input signed [12:0] playerX,		// player X position, loaded into memory at the beginning of a frame calculation
		input signed [12:0] playerY, 		// player Y position, loaded into memory at the beginning of a frame calculation
		input signed [9:0] angle_X, 		// player angle, fixed point format, loaded into memory in S_WAIT
		input signed [9:0] angle_Y,		// angle_X is the left of the decimal point, angle_Y is the right
		input [2:0] slice_color,			// color of each drawn slice (160 slices in one frame)
		input clock50Mhz,						// 50 MHz clock from DE1-SoC
		input clock60hz,						// rate-divided clock, used to drive draw_frame at 60 frames per second
		input resetn							// active-low resetn, clears the datapath registers and resets FSM
		output [2:0] color_out,				// slice_color flows to color_out when a frame is being drawn, else is set to 000 
													// when the frame is being cleared
		output [7:0] X,						// generated X position to draw a mega-pixel at
		output [6:0] Y,						// generated Y position to draw a mega-pixel at
		output draw_enable					// write enable to the frame buffer in vga_adapter
	);
	
	// tells the datapath to load player attributes (playerX, playerY, alpha_X, alpha_Y)
	wire load_player_attr;
	
	// tells the datapath to start counting through positions to clear the screen
	wire clear_counter_enable;
	
	// tells the datapath to start drawing a slice of the screen (1 column, 160 of these at 160x120 resolution)
	wire draw_slice;
	
	// tells the FSM that clearing is complete and to start drawing the frame
	wire clear_complete;
	
	// tells the FSM that drawing is complete and to go back to the S_WAIT state and record player inputs again
	wire draw_complete;

	control_draw_frame FSM (
	
		.clock(clock50Mhz),
		.resetn(resetn),
		
		// -------------------------------- inputs that affect FSM state -------------------------------------
		
		.begin_frame_draw(clock60hz),
		
		.clear_complete(clear_complete),
		.draw_complete(draw_complete),
		
		// ------------------------------------ outputs to the datapath --------------------------------------
		
		.load_player_attr(load_player_attr),
		.clear_counter_enable(clear_counter_enable),
		.draw_slice(draw_slice),
		
		// ------------------------------------ outputs to higher-level module --------------------------------------
		.draw_enable(draw_enable)
	
	);
	
	datapath_draw_frame draw_slices(
	
		.clock(clock50Mhz),
		.resetn(resetn),
		
		// ------------------------------------ control signals from FSM --------------------------------------
		
		.load_player_attr(load_player_attr),
		.clear_counter_enable(clear_counter_enable),
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
		// ------------------- inform the FSM that drawing or clearing is complete ----------------------------
		
		.clear_complete(clear_complete),
		.draw_complete(draw_complete)
	
	);
	
endmodule

module control_draw_frame(input clock, resetn, begin_frame_draw, clear_complete, draw_complete,
								  output reg load_player_attr, clear_counter_enable, draw_slice, draw_enable);
								  
	reg [1:0] current_state, next_state;

	localparam S_WAIT = 2'd0,
				  S_CLEAR_SCR = 2'd1,
				  S_DRAW = 2'd2;
	
	// ----------------------------------------- state table  ------------------------------------------------
	
	always @(*)
	begin: state_table
	
		case(current_state)
			S_WAIT: next_state = begin_frame_draw ? S_CLEAR_SCR : S_WAIT;
			S_CLEAR_SCR: next_state = clear_complete ? S_DRAW : S_CLEAR_SCR;
			S_DRAW: next_state = draw_complete ? S_WAIT : S_DRAW;
			default: next_state = S_WAIT;
		endcase
		
	end // state_table
	
	// ------------------------------- output logic i.e. control signal logic  -------------------------------------
	
	always @(*)
	begin: control_signals
	
		// prevent latching by assuming all control signals to be 0 at the beginning
		load_player_attr = 1'b0;
		clear_counter_enable = 1'b0;
		draw_slice = 1'b0;
		draw_enable = 1'b0;
		
		case(current_state)
			S_WAIT: load_player_attr = 1'b1;
			S_CLEAR_SCR: 
			begin
				clear_counter_enable = 1'b1;
				draw_enable = 1'b1; // so we can draw black pixels over the entire screen
			end
			S_DRAW:
			begin
				// start drawing 160 slices across the screen by activating a counter
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
