`timescale 1ns/1ns

module grid2D(input [11:0] grid_address, output grid_out);

	always @(*)
	begin
	
		// this should be a hallway, place player character at (64<playerX<128, 0<playerY<310)
		case (grid_address)
			12'b000000000000: grid_out = 1'b1;
			12'b000000000010: grid_out = 1'b1;
			12'b000001000000: grid_out = 1'b1;
			12'b000001000010: grid_out = 1'b1;
			12'b000010000000: grid_out = 1'b1;
			12'b000010000010: grid_out = 1'b1;
			12'b000011000000: grid_out = 1'b1;
			12'b000011000010: grid_out = 1'b1;
			12'b000100000000: grid_out = 1'b1;
			12'b000100000010: grid_out = 1'b1;
			default: grid_out = 1'b0;
		endcase
	
	end

endmodule
