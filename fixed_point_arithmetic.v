`timescale 1ns/1ns

module int_fixed_point_mult_int
	(
		input signed [20:0] int_in, 
		input signed [9:0] fixed_X, 
		input signed [16:0] fixed_Y, 
		output reg signed [20:0] int_out
	);

	assign int_out = int_in * fixed_X + (

endmodule

module int_fixed_point_div_int
	(
		input signed [20:0] int_in, 
		input signed [9:0] fixed_X, 
		input signed [16:0] fixed_Y, 
		output reg signed [20:0] int_out
	);

	

endmodule

// this module only to count through slices for a single frame
// int_in can be a max of 160 (8 bits), and both the int and fixed_point are positive, so no signed values required
// fixed point value is 0.375 at 160x120 resolution
// fixed_X_out can take a max value of 60 (field of view)
module int_fixed_point_mult_fixed_point
	(
		input [7:0] int_in,
		input fixed_X,
		input [2:0] fixed_Y,
		output reg [5:0] fixed_X_out,
		output reg [2:0] fixed_Y_out
	);
	
	
	
endmodule
