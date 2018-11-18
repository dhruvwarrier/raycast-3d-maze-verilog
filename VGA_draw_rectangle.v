`timescale 1ns/1ns

module VGA_draw_rectangle
	(
		input [7:0] X_pos_in,// Initial X position to draw rectangle at
		input [6:0] Y_pos_in,// Initial Y position to draw rectangle at
		input [7:0] rect_size,// size of rectangle to draw in Y. X size is 1 mega-pixel (4 pixels at normal resolution)
		input [2:0] color_in,// color_in simply flows to color_out, however this can be changed in the future if required
		input start_plot, 	// starts the plotting process
		input clock,			// On board clock, 50 MHz for the DE1
		input resetn, 			// active low, resets the FSM and clears the datapath registers
		output plot_enable, 	// generated rect_size times to draw a rectangle with size rect_size, this is wren to frame buffer
		output end_plot,		// generated when plotting process has ended
		output [7:0] X, 		// X is position from left, 160 columns
		output [6:0] Y,		// Y is position from top, 120 rows
		output [2:0] color_out
	);
	
	// wires that connect FSM to datapath
	
	// tells the datapath to load rect_size into the size counter
	wire load_rect_size;
	
	// tells the datapath to start computing new positions to draw the rectangle
	wire plot_counter_enable;
	
	// tells the FSM that plotting is complete and to go back to S_WAIT
	wire plot_complete;
	
	// color_in flows to color_out. Can be changed later if required
	assign color_out = color_in;
	
	// high for one cycle when plot is complete. Note that it is emitted before S_WAIT is reached, this could be a problem
	// in the future since the next begin_calc pulse can complete before we reach S_WAIT, in which case we could be
	// stuck in S_WAIT forever
	assign end_plot = plot_complete;

	control FSM(
	
		.clock(clock),
		.resetn(resetn),
		
		// -------------------------------- inputs that affect FSM state -------------------------------------
		.start_plot(start_plot),
		
		.plot_complete(plot_complete),
		
		// ------------------------------------ outputs to the datapath --------------------------------------		
		.load_rect_size(load_rect_size),
		.plot_counter_enable(plot_counter_enable),
		
		// --------------------------------- plot_enable to the VGA adapter ----------------------------------
		.plot_enable(plot_enable)
	
	);
	
	datapath position_manip(
	
		.clock(clock),
		.resetn(resetn),
		
		// ------------------------------------ control signals from FSM --------------------------------------
		.load_rect_size(load_rect_size),
		.plot_counter_enable(plot_counter_enable),
		
		// ------------------------------------ data input and output --------------------------------------
		.X_pos_in(X_pos_in),
		.Y_pos_in(Y_pos_in),
		.rect_size(rect_size),
		
		.X_pos_out(X),
		.X_pos_out(Y),
		
		// ----------------------------------------- outputs to FSM -----------------------------------------
		
		.plot_complete(plot_complete),
	
	);

endmodule

module control(input clock, resetn, start_plot, plot_complete,
					output reg load_rect_size, plot_counter_enable, plot_enable);

	
	reg [1:0] current_state, next_state;
	
	// FSM stays in S_PLOT_CYCLE until rect_size pixels have been drawn
	
	localparam S_WAIT = 2'd0,
				  S_LOAD_SIZE = 2'd1;
				  S_PLOT = 2'd1;
	
	// ----------------------------------------- state table  ------------------------------------------------
	
	always @(*)
	begin: state_table
		
		case (current_state)
			S_WAIT: next_state = start_plot ? S_LOAD_SIZE : S_WAIT;
			S_LOAD_SIZE: next_state = S_PLOT; // provide a state to load rect size into size counter
			S_PLOT: next_state = plot_complete ? S_WAIT : S_PLOT;
			default: next_state = S_WAIT;
		endcase
		
	end // state_table
	
	// ------------------------------- output logic i.e. control signal logic  ----------------------------------------
	
	always @(*)
	begin: control_signals
	
		// prevent latching by assuming all control signals to be 0 at the beginning
		load_rect_size = 1'b0;
		plot_counter_enable = 1'b0;
		plot_enable = 1'b0;
		
		case (current_state)
			S_LOAD_SIZE: load_rect_size = 1'b1;
			S_PLOT:
			begin
				// start counting positions
				plot_counter_enable = 1'b1;
				plot_enable = 1'b1;
			end
			// no default required since no latches and we already assigned default values
		endcase
	
	end // control_signals
	
	// -------------------------------------- current state registers  ------------------------------------------------
	always @(posedge clock)
	begin: state_FFs
		if (!resetn)
			current_state <= S_WAIT;
		else
			current_state <= next_state; // at each clock cycle, move to the next computed state
	end // state_FFs

endmodule

module datapath(input clock, resetn, ld_X, ld_Y, plot_counter_enable, clear_counter_enable,
					 input [6:0] data_in,
					 output reg [7:0] data_out_X, output reg [6:0] data_out_Y, 
					 output plot_complete, output clear_complete);
	
	// input registers, initial X and Y pos
	reg [7:0] X_pos;
	reg [6:0] Y_pos;
	
	// computed X and Y pos
	reg [7:0] counter_out_X;
	reg [6:0] counter_out_Y;
	
	// ---------------------------------------- datapath output table  ------------------------------------------------
	
	always @(posedge clock)
	begin
	
		if (!resetn) begin
			X_pos <= 8'b0;
			Y_pos <= 7'b0;
		end
		else begin
			if (ld_X)
				X_pos <= {1'b0, data_in}; // pad with one bit to adjust for size difference
			if (ld_Y)
				Y_pos <= data_in;
		end
	end
	
	// -------------------------------------- output position registers  -----------------------------------------------
	
	always @(posedge clock)
	begin
		if (!resetn)
			data_out_X <= 0;
		else
			data_out_X <= counter_out_X; // counter_out_X is registered to keep it stable for 1 clock cycle
	end
	
	always @(posedge clock)
	begin
		if (!resetn)
			data_out_Y <= 0;
		else
			data_out_Y <= counter_out_Y; // counter_out_X is registered to keep it stable for 1 clock cycle
	end
	
	// -------------------------------------- position counting logic  -----------------------------------------------
	wire [3:0] position_count;
	
	wire [13:0] clear_position_count;
	
	counter4 count_pos(
	
		.clock(clock),
		.resetn(plot_counter_enable),
		
		.Q(position_count),
		.count_complete(plot_complete)
	
	);
	
	counter13 count_clear_pos(
	
		.clock(clock),
		.resetn(clear_counter_enable),
		
		.Q(clear_position_count),
		.count_complete(clear_complete)
	
	);
	
	// ---------------------------------- new position calculation logic  --------------------------------------------
	
	always @(posedge clock)
	begin
		if (clear_counter_enable == 1'b1) begin
			// if counter is enabled and not completed yet, increment over all pixels on the screen
			counter_out_X <= (clear_position_count / 128);
			counter_out_Y <= (clear_position_count % 128);
		end else begin
			// else in a non-clearing state, prepare to draw a square
			counter_out_X <= X_pos + (position_count % 4);
			counter_out_Y <= Y_pos + (position_count / 4);
		end
	end
	
endmodule

module counter4(input clock, resetn, output reg [3:0] Q, output reg count_complete);

	// counter counts from 00000 to 10000 and then resets (0 to 16)
	
	reg [4:0] Q_buffer;  

	always @(posedge clock)
	begin
	
		count_complete = 1'b0;
	
		if (resetn == 1'b0)
			Q_buffer <= 0;
		else if (Q_buffer == 5'b10001) begin
			count_complete = 1'b1;
			Q_buffer <= 0;
		end else
			Q_buffer <= Q_buffer + 1;
			
		Q <= Q_buffer[3:0];
		
	end

endmodule

module counter13(input clock, resetn, output reg [13:0] Q, output reg count_complete);

	// counter counts from 0 to 16384 (128^2) and then resets
	
	reg [14:0] Q_buffer;  

	always @(posedge clock)
	begin
	
		count_complete = 1'b0;
	
		if (resetn == 1'b0)
			Q_buffer <= 0;
		else if (Q_buffer == 15'b100000000000001) begin
			count_complete = 1'b1;
			Q_buffer <= 0;
		end else
			Q_buffer <= Q_buffer + 1;
			
		Q <= Q_buffer[13:0];
		
	end

endmodule
