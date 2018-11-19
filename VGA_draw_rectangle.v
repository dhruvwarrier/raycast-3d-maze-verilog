`timescale 1ns/1ns

module VGA_draw_rectangle
	(
		input [7:0] X_pos_in,// Initial X position to draw rectangle at
		input [6:0] Y_pos_in,// Initial Y position to draw rectangle at
		input [6:0] rect_size,// size of rectangle to draw in Y. X size is 1 mega-pixel (4 pixels at normal resolution)
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
		.Y_pos_out(Y),
		
		// ----------------------------------------- outputs to FSM -----------------------------------------
		
		.plot_complete(plot_complete)
	
	);

endmodule

module control(input clock, resetn, start_plot, plot_complete,
					output reg load_rect_size, plot_counter_enable, plot_enable);

	
	reg [1:0] current_state, next_state;
	
	// FSM stays in S_PLOT until rect_size mega-pixels have been drawn
	
	localparam S_WAIT = 2'd0,
				  S_LOAD_SIZE = 2'd1,
				  S_PLOT = 2'd2;
	
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
				plot_enable = 1'b1; // set plot_enable high so we write to the frame buffer each time
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

module datapath(input clock, resetn, load_rect_size, plot_counter_enable,
					 input [7:0] X_pos_in, input [6:0] Y_pos_in, rect_size,
					 output [7:0] X_pos_out, output reg [6:0] Y_pos_out, 
					 output plot_complete);
	
	// computed Y position
	reg [6:0] counter_out_Y;
	
	// keep the X position constant, and iterate over Y only
	assign X_pos_out = X_pos_in;
	
	// -------------------------------------- position counting logic  -----------------------------------------------
	wire [6:0] position_count;
	
	counter7 count_pos(
	
		.clock(clock),
		
		// parallel load rect_size at high load_rect_size
		.parallel_load(load_rect_size),
		
		// enable the counter in the next state
		.enable(plot_counter_enable),
		
		// data to be loaded into counter at high load_rect_size
		.Q_max(rect_size),
		
		.Q(position_count),
		.count_complete(plot_complete)
	
	);
	
	// ---------------------------------- new position calculation logic  --------------------------------------------
	
	always @(posedge clock)
	begin
		if (plot_counter_enable == 1'b1) begin
			// iterate over all the positions
			// counts from Y_pos to Y_pos + rect_size - 1
			counter_out_Y <= Y_pos_in + position_count; 
		end
	end
	
	// -------------------------------------- output position registers  -----------------------------------------------
	
	// only require an output position register for Y_pos_out
	
	always @(posedge clock)
	begin
		if (!resetn)
			Y_pos_out <= 0;
		else
			Y_pos_out <= counter_out_Y; // counter_out_Y is registered to keep it stable for 1 clock cycle
	end
	
endmodule

module counter7(input clock, enable, parallel_load, input [6:0] Q_max, output reg [6:0] Q, output reg count_complete);

	// counter counts from 0 to Q_max-1 and then resets
	
	reg [6:0] max_Q;

	always @(posedge clock)
	begin
	
		count_complete = 1'b0;
	
		if (parallel_load == 1'b1) begin
			max_Q <= Q_max; // load this value and count up to it when the counter is enabled
			Q <= 0;
		end else if (Q == Q_max) begin
			count_complete = 1'b1;
			Q <= 0;
		end else if (enable == 1'b1)
			Q <= Q + 1;	
		
	end

endmodule
