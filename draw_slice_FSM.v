
module draw_slice_FSM_main
	(
		input signed [12:0] playerX, playerY,
		//input signed [9:0] beta_X, // will be provided by counter
		input clock,
		input resetn,
		input begin_calc,
		output end_plot //calculation ends
	);

	wire reset_datapath;		//tells datapath to reset values 
	wire find_beta;			//get beta value from counter
	wire find_alpha;		//calculate alpha using beta
	wire find_wall_intersection;    //use raycast modules 
	wire find_position_diff;	//find difference in position coordinates
	wire find_dist;			//divide by cos alpha
	wire find_ABS;			//take abs of sifference ABS(Px-Ex)/cos alpha
	wire lower_dist;		//choose the smaller value
	wire rev_fishbowl;		//multiply by cos beta
	wire proj_height;		//divide by 8896 and find proj height 
	wire draw_slice;   		//draw the slice 

///////outputs 

//call datapath and control here 

//
//
//

endmodule


module control_draw_slice_FSM ( input clock, resetn, begin_calc, end_calc
				output reg reset_datapath, find_beta, find_alpha, find_wall_intersection, find_position_diff,  find_dist,
				find_ABS, lower_dist, rev_fishbowl, proj_height, draw_slice);

		reg[3:0] current_state, next_state;
		
		localparam S_WAIT = 4'd0,
					S_FIND_BETA = 4'd1;
					S_FIND_ALPHA = 4'd2;
					S_FIND_WALL_INTERSECTION = 4'd3
					S_FIND_POSITION_DIFF = 4'd4;
					S_FIND_DIST = 4'd5;
					S_FIND_ABS = 4'd6;			
					S_LOWER_DIST = 4'd7;
					S_REV_FISHBOWL = 4'd8;
					S_PROJ_HEIGHT = 4'd9;
					S_DRAW_SLICE = 4'd10;
///state table /////

	always @(*)
	begin: state_table 

		case(current state)
			S_WAIT: begin_calc ? S_FIND_BETA : S_WAIT;
			S_FIND_BETA: next_state = S_FIND_ALPHA;
			S_FIND_ALPHA: next_state = S_FIND_WALL_INTERSECTION;
			S_FIND_WALL_INTERSECTION: next_state = S_FIND_POSITION_DIFF;
			S_FIND_POSITION_DIFF: next_state = S_FIND_DIST;		
			S_FIND_DIST: next_state = S_FIND_ABS;
			S_FIND_ABS: next_state = S_LOWER_DIST;
			S_LOWER_DIST: next_state = S_REV_FISHBOWL;
			S_REV_FISHBOWL: next_state = S_PROJ_HEIGHT;
			S_PROJ_HEIGHT: next_state = S_DRAW_SLICE;
			S_DRAW_SLICE: next_state = end_calc ? S_WAIT: S_WAIT; //??
			default: next_state = S_WAIT;
		endcase

	end
//output logic 

	always @(*)
	begin:  control_signals 
		
		reset_datapath = 1'b0;
		find_beta = 1'b0;
		find_alpha = 1'b0;
		find_wall_intersection = 1'b0;
		find_position_diff = 1'b0;
		find_dist= 1'b0;
		find_ABS= 1'b0;	 	
 		lower_dist = 1'b0;
 		rev_fishbowl = 1'b0;
 		proj_height = 1'b0;
 		draw_slice = 1'b0;

		case(current_state)
			S_WAIT: reset_datapath = 1'b1;
			S_FIND_BETA: find_beta = 1'b1;
			S_FIND_ALPHA: find_alpha = 1'b1;
			S_FIND_WALL_INTERSECTION: find_wall_intersection = 1'b1;
			S_FIND_POSITION_DIFF: find_position_diff = 1'b1;
			S_FIND_DIST: find_dist= 1'b1;
			S_FIND_ABS: find_ABS= 1'b1;		
			S_LOWER_DIST: lower_dist = 1'b1;
			S_REV_FISHBOWL: rev_fishbowl = 1'b1;
			S_PROJ_HEIGHT: proj_height = 1'b1;
			S_DRAW_SLICE: draw_slice = 1'b1;
		endcase
	end

//state registers////

	always @(posedge clock)
	begin: state_FFs
		if(!resetn)
			current_state <=S_WAIT;
		else 
			current_state <= next_state;
	end
endmodule 

///////datapath //////

module datapath_draw_slice_fsm( input clock, resetn, begin_calc, reset_datapath, find_beta, find_alpha, find_wall_intersection, find_position_diff, find_dist,
				find_ABS, lower_dist, rev_fishbowl, proj_height, draw_slice,
				input signed [12:0] playerX, playerY
				output end_plot);
	
		reg signed [20:0] betaX, betaY, alphaX, alphaY, wall_int_horiz, wall_int_vert, positionDiff_X, positionDiff_Y, distX, distY, 
					abs_distX, abs_distY, lowerDist, rev_fish, height, draw;
		
//--------------finding wall intersection using raycast modules -----------

wire signed [12:0] wallX_horiz;
wire signed [12:0] wallX_vert;

find_wall_intersection_horiz h1(.playerX(playerX), .playerY(playerY), .alphaX(alphaX), .alphaY(alpha_Y), .clock(clock), .resetn(resetn), .begin_calc(begin_calc)//outputs);
find_wall_intersection_vert v1(.playerX(playerX), .playerY(playerY), .alphaX(alphaX), .alphaY(alpha_Y), .clock(clock), .resetn(resetn), .begin_calc(begin_calc)//outputs );
//-----------cos of alpha -------------------------
wire signed [9:0] cos_alpha_X;
wire signed [9:0] cos_alpha_Y;

cos_LUT lookup_cos_value_alpha(.angleX(alphaX), .angleY(alphaY), .ratioX(cos_alpha_X), .ratioY(cos_alpha_Y));

//------------cos of beta -------------------------

wire signed [9:0] cos_beta_X;
wire signed [9:0] cos_beta_Y;

cos_LUT lookup_cos_value_beta(.angleX(betaX), .angleY(betaY), .ratioX(cos_beta_X), .ratioY(cos_beta_Y));

//--------------------------------------fixed point division -------

wire signed [20:0] distanceX;
wire signed [20:0] distanceY;
wire signed [20:0] reverse_fish;

int_fixed_point_div_int divider_dist_x (
		
		// performs fixed point division: dist = abs(px-dx) / cos(alpha)
		
		.int_in(positionDiff_X),
		.fixed_X(cos_alpha_X),
		.fixed_Y(cos_alpha_Y),
		
		.int_out(distanceX)
	);

int_fixed_point_div_int divider_dist_y (
		
		// performs fixed point division: dist = abs(px-ex) / cos(alpha)
		
		.int_in(positionDiff_Y),
		.fixed_X(cos_beta_X),
		.fixed_Y(cos_beta_Y),		
		.int_out(distanceY)
	);

//---------------fixed point multiplication 

int_fixed_point_mult_int u1(
		
		.int_in(lowerDist), 
		.fixed_X(cos_beta_X), 
		.fixed_Y(cos_beta_Y), 
		.int_out(reverse_fish)
	);

/// ----------draw module -------------


//datapath output 

	always @(posedge clock)
	begin 
		
		if (!resetn) begin 
			betaX <= 12'b0;
			betaY <= 12'b0;
			alphaX <= 12'b0;
			positionDiff_X <= 12'b0;
			positionDiff_Y <= 12'b0;
			abs_diffX <= 12'b0;
			abs_diffY <= 12'b0;
			distX <= 12'b0;
			distY <= 12'b0;
			lowerDist <= 12'b0;
			rev_fish <= 12'b0;
			height <= 12'b0;
			draw <= 12'b0;
	end
	else begin
		
		if (reset_datapath) begin
			end_plot <= 1'b0;
		end
	
		if (find_beta) begin
			//counter 
		end
		
		if (find_alpha) begin
			// calculate alpha 
		end
		
		if (find_wall-intersection) begin
			wall_int_horiz <= wallX_horiz;
			wall_int_vert <= wallX_vert;
		end 
		
		if (find_position_diff) begin 
			positionDiff_X <= playerX - wall_int_horiz;
			positionDiff_Y <= playerX- wall_int_vert;
		end
		
		if (find_dist) begin 
			distX <= distanceX;
			distY <= distanceY;
		end 
		
		if (find_ABS) begin 
			abs_diffX <= distX ? -(distX): distX;
			abs_diffY <= distY ? -(distY): distY;
		end
		
		if (lower_dist) begin 
			if(distX <= distY)
				lowerDist <= distX;
			else 
				lowerDist <= distY;
		end 
		
		if (rev_fishbowl) begin
			rev_fish <= reverse_fish;
		end 
		
		if (proj_height) begin
			proj_height <= 14'b10001011000000 / rev_fish; //8896/ rev fish 
		end

		if(draw_slice) begin 
			//draw 
		end 

	end 
end 

	
module counter8(input clock, reset, enable, output reg [7:0] Q);


	always @(posedge clock)
		begin
		
		if (~reset)
			Q<=8'b00000000;
		else if (Q==8'b10100000)
			Q=0;
		else if(En==1'b1)
			Q<=Q+1;
		
	end 
endmodule

	


//----output registers 













