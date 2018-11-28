module input_control_top(CLOCK_50, KEY, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
  
    input [1:0] KEY;
    input [1:0] SW;
    input CLOCK_50;
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;


        wire resetn, rotate_left, rotate_right;
  	

	wire [9:0] angle_X, angle_Y;
	
	 
    assign rotate_left = ~KEY[1];
    assign rotate_right = ~KEY[0];
    assign resetn = SW[0];

	input_control u0(
		.clock(CLOCK_50),
		.resetn(resetn),
		
		.rotate_left(rotate_left),					
		.rotate_right(rotate_right),
		
		
		.angle_X(angle_X),
		.angle_Y(angle_Y)
		
	);

   


    hex_decoder H0(
        .hex_digit(angle_X[3:0]), 
        .segments(HEX0)
        );
        
    hex_decoder H1(
        .hex_digit(angle_X[7:4]), 
        .segments(HEX1)
        );

     hex_decoder H2(
        .hex_digit(angle_X[9:8]), 
        .segments(HEX2)
        );

      hex_decoder H3(
        .hex_digit(angle_Y[3:0]), 
        .segments(HEX3)
        );

       hex_decoder H4(
        .hex_digit(angle_Y[7:4]), 
        .segments(HEX4)
        );

        hex_decoder H5(
        .hex_digit(angle_Y[9:8]), 
        .segments(HEX5)
        );


endmodule

module hex_decoder(hex_digit, segments);
    input [3:0]hex_digit;
    output reg [6:0]segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule