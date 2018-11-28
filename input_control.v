`timescale 1ns/1ns

module input_control
	(
		input clock,
		input resetn,
		
		input rotate_left,					
		input rotate_right,
		
		output signed [12:0] playerX,
		output signed [12:0] playerY,
		output signed [9:0] angle_X,
		output signed [9:0] angle_Y
	
	);
	
	wire increment_angle, decrement_angle, wrap_around;
	
	control_input_control FSM(
		
		.clock(clock),
		.resetn(resetn),
		
		// -------------------------------- inputs that affect FSM state -------------------------------------
		
		.rotate_left(rotate_left),
		.rotate_right(rotate_right),
		
		// ------------------------------------ outputs to the datapath --------------------------------------
		
		.increment_angle(increment_angle),
		.decrement_angle(decrement_angle),
		.wrap_around(wrap_around)
	
	);
	
	datapath_input_control player_manip(
	
		.clock(clock),
		.resetn(resetn),
		
		// ------------------------------------ control signals from FSM --------------------------------------
		
		.increment_angle(increment_angle),
		.decrement_angle(decrement_angle),
		.wrap_around(wrap_around),
		
		// -------------------------------------- data input and output ---------------------------------------
		
		.playerX(playerX),
		.playerY(playerY),
		.angle_X(angle_X),
		.angle_Y(angle_Y)
	
	);
	
endmodule

module control_input_control(input clock, resetn, rotate_left, rotate_right, 
									  output reg increment_angle, decrement_angle, wrap_around);

	reg [2:0] current_state, next_state;

	localparam S_WAIT_INPUT = 3'd0,
				  S_INC_ANGLE_WAIT = 3'd1,
				  S_DEC_ANGLE_WAIT = 3'd2,
				  S_INC_ANGLE = 3'd3,
				  S_DEC_ANGLE = 3'd4,
				  S_WRAP_AROUND = 3'd5;
				  
	// ----------------------------------------- state table  ------------------------------------------------
	
	always @(*)
	begin: state_table
	
		case(current_state)
			S_WAIT_INPUT:
			begin
				if (rotate_left) next_state = S_INC_ANGLE_WAIT;
				else if (rotate_right) next_state = S_DEC_ANGLE_WAIT;
				else next_state = S_WAIT_INPUT;
			end
			S_INC_ANGLE_WAIT: next_state = rotate_left ? S_INC_ANGLE_WAIT : S_INC_ANGLE;
			S_DEC_ANGLE_WAIT: next_state = rotate_right ? S_DEC_ANGLE_WAIT : S_DEC_ANGLE;
			S_INC_ANGLE: next_state = S_WRAP_AROUND;
			S_DEC_ANGLE: next_state = S_WRAP_AROUND;
			S_WRAP_AROUND: next_state = S_WAIT_INPUT;
			default: next_state = S_WAIT_INPUT;
		endcase
	
	end // state_table
	
	// ------------------------------- output logic i.e. control signal logic  -------------------------------------
	
	always @(*)
	begin: control_signals
	
		increment_angle = 1'b0;
		decrement_angle = 1'b0;
		wrap_around = 1'b0;
		
		case(current_state)
			S_INC_ANGLE: increment_angle = 1'b1;
			S_DEC_ANGLE: decrement_angle = 1'b1;
			S_WRAP_AROUND: wrap_around = 1'b1;
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

module datapath_input_control(input clock, resetn, increment_angle, decrement_angle, wrap_around,
										output reg signed [12:0] playerX, playerY, output reg signed [9:0] angle_X, angle_Y);
										
	
	reg signed [9:0] angle_X_computed, angle_Y_computed;
	
	wire signed [9:0] angle_X_wire_incr, angle_Y_wire_incr;
	wire signed [9:0] angle_X_wire_decr, angle_Y_wire_decr;
	
	// -------------------------------------- fixed point angle addition ---------------------------------------------	
	
	fixed_point_subtract_fixed_point incr_angle_calc(
	
		// perform angle = angle + 1.125
	
		.fixed_X_in_1(angle_X_computed),
		.fixed_Y_in_1(angle_Y_computed),
		.fixed_X_in_2(-1),
		.fixed_Y_in_2(125),
		
		.fixed_X_out(angle_X_wire_incr),
		.fixed_Y_out(angle_Y_wire_incr)
	);
	
	// ----------------------------------- fixed point angle subtraction ---------------------------------------------
	
	fixed_point_subtract_fixed_point decr_angle_calc(
	
		// perform angle = angle - 1.125
	
		.fixed_X_in_1(angle_X_computed),
		.fixed_Y_in_1(angle_Y_computed),
		.fixed_X_in_2(1),
		.fixed_Y_in_2(125),
		
		.fixed_X_out(angle_X_wire_decr),
		.fixed_Y_out(angle_Y_wire_decr)
	);
	
	// ---------------------------------------- datapath output table  ------------------------------------------------
	
	always @(posedge clock)
	begin
	
		if (!resetn) begin
			playerX <= 96;
			playerY <= 96;
			angle_X_computed <= 90;
			angle_Y_computed <= 0;
		end
		else begin
			
				if (increment_angle) begin
					angle_X_computed <= angle_X_wire_incr;
					angle_Y_computed <= angle_Y_wire_incr;
				end	
				
				if (decrement_angle) begin
					angle_X_computed <= angle_X_wire_decr;
					angle_Y_computed <= angle_Y_wire_decr;
				end
			
			end
			
			if (wrap_around) begin
				// angle can take values from 0 to 359.625
				if (angle_X_computed < 0) begin
				
					// if alpha is lesser than 0 bring it up
					if (angle_Y_computed > 0) begin
						// if alpha_Y is not 0, remember that .125 is actually -0.125, adjust alpha_X and alpha_Y accordingly
						angle_X_computed <= angle_X_computed - 1 + 360;
						angle_Y_computed <= 1000 - angle_Y_computed;
					end else if (angle_Y_computed == 0) begin
						angle_X_computed <= angle_X_computed + 360;
					end
					
				end else if (angle_X_computed >= 360) begin
					// if alpha is greater than 360 bring it down
					angle_X_computed <= angle_X_computed - 360;
				end
		
		end
		
	end
	
	// ------------------------------------------- output registers --------------------------------------------------
	
	always @(posedge clock)
	begin
		if (!resetn)
			angle_X <= 90;
		else
			angle_X <= angle_X_computed;
	end
	
	always @(posedge clock)
	begin
		if (!resetn)
			angle_Y <= 0;
		else
			angle_Y <= angle_Y_computed;
	end

endmodule
