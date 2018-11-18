`timescale 1ns/1ns


module int_fixed_point_mult_int
	(
		input signed [20:0] int_in, 
		input signed [9:0] fixed_X, 
		input signed [17:0] fixed_Y, 
		output reg signed [20:0] int_out
	);

	// here fixed_Y must be the binary representation of the integer to the right of the decimal point
	// accuracy of fixed point value is assumed to be 5 d.p. so divide by 10^5

	always @(*)
	begin
		if (fixed_X > 0)
			int_out <= int_in * fixed_X + ((int_in * fixed_Y) / 100000);
		else 
			int_out <= int_in * fixed_X - ((int_in * fixed_Y) / 100000);
	end

endmodule

module int_fixed_point_div_int
	(
		input signed [20:0] int_in, 
		input signed [9:0] fixed_X, 
		input signed [17:0] fixed_Y, 
		output reg signed [20:0] int_out
	);

	always @(*)
	begin
	
		if (fixed_X == 10'b0 && fixed_Y != 18'b0)
			int_out <= ((int_in* 100000) / fixed_Y );
		else if (fixed_X != 10'b0 && fixed_Y == 18'b0)
			int_out <= int_in / fixed_X;
		else if (fixed_X == 10'b0 && fixed_Y == 18'b0)
			int_out <= 21'b011111111111111111111; // incredibly high positive value
		else
			int_out <= int_in / fixed_X + (int_in* 100000) / fixed_Y;
	
	end 

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
		output [5:0] fixed_X_out,
		output [9:0] fixed_Y_out
	);
	
	// assuming here a 3 d.p. accuracy since all multiples of 0.375 can be represnted perfectly by 3 digit integers
	// on the right
	assign fixed_X_out = (int_in * fixed_X) + $floor((int_in * fixed_Y) / 1000);
	assign fixed_Y_out = ((int_in * fixed_Y) / 1000 - $floor((int_in * fixed_Y) / 1000)) * 1000;
	
endmodule
