
module VGA_out
	(
		CLOCK_50,						//	On Board 50 MHz
		SW,                        // On Board switches
		KEY,
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

	input			CLOCK_50;				//	50 MHz
	
	// SW[1] is active high reset
	// SW[9] resets the player position and angle
	input [9:0] SW;
	
	// KEY[3] goes left, KEY[2] goes right
	input [3:0] KEY;
	
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	// ----------------------------------- Input set for VGA_draw_square module ---------------------------------------
	
	wire resetn;
	assign resetn = ~SW[1];
	
	// ----------------------------------- Output set from VGA_draw_square module --------------------------------------
	// ----------------------------------- These are inputs to the VGA controller --------------------------------------

	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	// --------------------------------------- Instance of VGA controller  ---------------------------------------------
	
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
		
	// ----------------------------------- Instance of draw_frame module ---------------------------------------
	
	// Signals produced below: x, y, colour and writeEn for the VGA controller
	
	wire clock_30hz;
	
	wire signed [12:0] playerX, playerY;
	wire signed [9:0] angle_X, angle_Y;
	
	draw_frame draw_frame(
		
		.clock50MHz(CLOCK_50),
		.clock60Hz(clock_30hz),
		.resetn(resetn),
		
		.playerX(playerX),
		.playerY(playerY),
		.angle_X(angle_X),
		.angle_Y(angle_Y),
		.slice_color(3'b100),
		
		.color_out(colour),
		.X(x),
		.Y(y),
		.draw_enable(writeEn)
	
	);
	
	input_control input_control(
		.clock(CLOCK_50),
		.resetn(SW[9]),
		
		.rotate_left(~KEY[3]),
		.rotate_right(~KEY[2]),
		
		.playerX(playerX),
		.playerY(playerY),
		.angle_X(angle_X),
		.angle_Y(angle_Y)
	);
	
	rate_divider prod_30Hz (.clkin(CLOCK_50),.clkout(clock_30hz));
	
endmodule
