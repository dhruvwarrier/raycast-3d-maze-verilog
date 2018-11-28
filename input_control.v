`timescale 1ns/1ns

module input_control
	(
		input clock,
		input resetn,
		
		input rotate_left,					
		input rotate_right,
		
		output reg signed [12:0] playerX,
		output reg signed [12:0] playerY,
		output reg signed [9:0] angle_X,
		output reg signed [9:0] angle_Y
	
	);
	
	control_input_control FSM(
		
		.clock(clock),
		.resetn(resetn),
		
		// -------------------------------- inputs that affect FSM state -------------------------------------
		
		.rotate_left(rotate_left),
		.rotate_right(rotate_right),
		
		// ------------------------------------ outputs to the datapath --------------------------------------
		
		.increment_angle(increment_angle),
		.decrement_angle(decrement_angle)
	
	);
	
	datapath_input_control player_manip(
	
		.clock(clock),
		.resetn(resetn),
		
		// ------------------------------------ control signals from FSM --------------------------------------
		
		.increment_angle(increment_angle),
		.decrement_angle(decrement_angle),
		
		// -------------------------------------- data input and output ---------------------------------------
		
		.playerX(playerX),
		.playerY(playerY),
		.angle_X(angle_X),
		.angle_Y(angle_Y)
	
	);
	
endmodule

module control_input_control(input clock, resetn, rotate_left, rotate_right, 
									  output reg increment_angle, decrement_angle);

	reg [2:0] current_state, next_state;

	localparam S_WAIT_INPUT = 3'd0,
				  S_INC_ANGLE = 3'd1,
				  S_DEC_ANGLE = 3'd2;
				  
	// ----------------------------------------- state table  ------------------------------------------------
	
	always @(*)
	begin: state_table
	
		case(current_state)
			S_WAIT_INPUT:
			begin
				if (rotate_left) next_state = S_INC_ANGLE;
				else if (rotate_right) next_state = S_DEC_ANGLE;
				else next_state = S_WAIT_INPUT;
			end
			S_INC_ANGLE: next_state = rotate_left ? S_INC_ANGLE : S_WAIT_INPUT;
			S_DEC_ANGLE: next_state = rotate_right ? S_DEC_ANGLE : S_WAIT_INPUT;
			default: next_state = S_WAIT_INPUT;
		endcase
	
	end // state_table
	
	// ------------------------------- output logic i.e. control signal logic  -------------------------------------
	
	always @(*)
	begin: control_signals
	
		increment_angle = 1'b0;
		decrement_angle = 1'b0;
		
		case(current_state)
			S_INC_ANGLE: increment_angle = 1'b1;
			S_DEC_ANGLE: decrement_angle = 1'b1;
		endcase
	
	end // control_signals
	
	// ------------------------------------- current state register  -------------------------------------------
	
	always @(posedge clock)
	begin: state_FFs
		if (!resetn)
			current_state <= S_WAIT_INPUT;
		else
			current_state <= next_state; // at each clock cycle, move to the next computed state
	end // state_FFs

endmodule

module datapath_input_control(input clock, resetn, increment_angle, decrement_angle, 
										output reg signed [12:0] playerX, playerY, output reg signed [9:0] angle_X, angle_Y);
										
	
	wire signed [9:0] angle_X_wire_incr, angle_Y_wire_incr;
	wire signed [9:0] angle_X_wire_decr, angle_Y_wire_decr;
	
	// -------------------------------------- fixed point angle addition ---------------------------------------------	
	
	fixed_point_subtract_fixed_point incr_angle_calc(
	
		// perform angle = angle + 1.125
	
		.fixed_X_in_1(angle_X),
		.fixed_Y_in_1(angle_Y),
		.fixed_X_in_2(-1),
		.fixed_Y_in_2(125),
		
		.fixed_X_out(angle_X_wire_incr),
		.fixed_Y_out(angle_Y_wire_incr)
	);
	
	fixed_point_subtract_fixed_point decr_angle_calc(
	
		// perform angle = angle - 1.125
	
		.fixed_X_in_1(angle_X),
		.fixed_Y_in_1(angle_Y),
		.fixed_X_in_2(1),
		.fixed_Y_in_2(125),
		
		.fixed_X_out(angle_X_wire_decr),
		.fixed_Y_out(angle_Y_wire_decr)
	);
	
	// ------------------------------------------ 10 Hz rate divider  ------------------------------------------------
	
	wire clock_10hz;
	
	rate_divider_10(.clkin(clock),.clkout(clock_10hz));
	
	// ---------------------------------------- datapath output table  ------------------------------------------------
	
	always @(posedge clock)
	begin
	
		if (!resetn) begin
			playerX <= 96;
			playerY <= 96;
			angle_X <= 90;
			angle_Y <= 0;
		end
		else begin
		
			if (clock_10Hz) begin
			
				if (increment_angle) begin
					angle_X <= angle_X_wire_incr;
					angle_Y <= angle_Y_wire_incr;
				end	
				
				if (decrement_angle) begin
					angle_X <= angle_X_wire_decr;
					angle_Y <= angle_Y_wire_decr;
				end
			
			end
		
		end
		
	end

endmodule
