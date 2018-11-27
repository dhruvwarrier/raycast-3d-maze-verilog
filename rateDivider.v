//assuming clkin will be 50MHz clock
module rate_divider(input clkin, output reg clkout);

	reg [19:0] counter;


	initial begin
  	  counter = 0;
   	  clkout = 0;
	end
	
//count down from 833333 (50M / 60 = 833333)
	always @(posedge clkin) begin
   		 if (counter == 0) begin
       			counter <= 833333;
       	 		clkout <= ~clkout;
   		 end else begin
       			 counter <= counter -1;
  		end
	end

endmodule
