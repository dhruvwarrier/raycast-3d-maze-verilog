module fill
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		SW,
		KEY,							// On Board Keys
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input	CLOCK_50;	//	50 MHz
	input	[3:0]	KEY;
	
	// Declare your inputs and outputs here
	input [9:0]SW;
	
	
	
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
wire [6:0] len;
	wire writeEn;
	
	wire load_x, load_y, load_colour, go, clear, Ecounter;
	wire [3:0]counter;
assign go= ~KEY[3];
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	datapath U1(.clock(CLOCK_50), .resetn(resetn), .data(SW), .black(clear), .Ecounter(Ecounter), .load_x(load_x), .load_y(load_y), .load_colour(load_colour), .xPosition(x), .yPosition(y), .length(len), .colour(colour), .counter(counter));
	FSM control(.clock(CLOCK_50), .resetn(resetn), .plot(~KEY[1]), .black(~KEY[2]), .go(go), .counter(counter), .length(len), .load_x(load_x), .load_y(load_y), .load_colour(load_colour), .display(writeEn), .clear(clear), .Ecounter(Ecounter));

endmodule

module datapath(clock, resetn, data, black, Ecounter, load_x, load_y, load_colour, xPosition, yPosition, length, colour, counter);

	input clock, resetn;
	input [9:0]data;	
	
	
	input load_x, load_y, load_colour, black, Ecounter;
	
	output reg [7:0]xPosition;
	output reg [6:0]yPosition;
	output reg [6:0] length;
	output reg [2:0]colour;
	
	output reg [6:0]counter;
	
	wire [3:0]x_initial;
	wire [3:0]y_initial;
	
	
	assign x_initial = data[7:0];
	assign y_initial = data[6:0];
	assign length = data[6:0];
	
	
	always@(posedge clock) begin
		if (!resetn) begin
			xPosition <= 8'b0;
			yPosition <= 7'b0;
			colour <= 3'b0;
		end
		
		else begin
			if (load_x) //load x location 
				xPosition <= x_initial;
				
			if (load_y) //load y location

				yPosition <= y_initial;
			
			if (Ecounter) begin
				
				counter <= counter + 1;
				
				yPosition <= y_initial +counter[6:0];
				end
				
			if (load_colour) //load colour
				colour <= data[9:7];
				
			if (black) //clear screen to black
				colour <= 3'b0;
		end
	end
endmodule 

module FSM(clock, resetn, plot, black, go, counter, length, load_x, load_y, load_colour, display, clear, Ecounter);

	input clock, resetn, plot, black, go;
	input [6:0] length;
	input [6:0]counter;
	output reg load_x, load_y, load_colour, display, clear, Ecounter;
	
	reg [3:0] current_state, next_state;
	
	localparam LOAD_X = 4'd0, LOAD_Y_COLOUR = 4'd1, PLOT = 4'd2, BLACK = 4'd3;
	
	always@(*)
	begin: state_table
		case(current_state)
			LOAD_X: begin
				if (go)
					next_state = LOAD_Y_COLOUR;
				else if(black)
					next_state = BLACK;
				else
					next_state = LOAD_X;
			end
			LOAD_Y_COLOUR: next_state = plot? PLOT: LOAD_Y_COLOUR;
			PLOT: begin
				if (counter== length)
					next_state = LOAD_X;
				else 
					next_state = PLOT;
				end
			BLACK: next_state = LOAD_X;
			
		default: next_state=LOAD_X;
		
		endcase
	end
	
	always@(*)
	begin: enable_signals
	load_x = 1'b0;
	load_y = 1'b0;
	load_colour = 1'b0;
	display = 1'b0;
	clear = 1'b0;
	Ecounter =1'b0;
	
	case(current_state)
			
		LOAD_X: begin
			load_x= 1'b1;
			end
		
		LOAD_Y_COLOUR: begin
			load_y = 1'b1;
			load_colour= 1'b1;
			end
		
		PLOT: begin
			display = 1'b1;
			Ecounter = 1'b1;
			end
			
		BLACK: begin
			load_colour = 1'b1;
			clear= 1'b1;
			end
		
		endcase
	end
	
	always@(posedge clock)
	begin: state_FFs
		if (!resetn)
			current_state <= LOAD_X;
		else 
			current_state <= next_state;
	end
	
endmodule
