
module find_slice_height
	(
		input signed [12:0] playerX, playerY,
		input signed [9:0] angle_X,
		input signed [9:0] angle_Y, 
		input [7:0] column_count, // will be provided by counter
		input clock,
		input resetn,
		input begin_calc,
		output [6:0] slice_size,
		output end_calc//calculation ends
	);

	wire reset_datapath;		//tells datapath to reset values 
	wire find_beta;			//get beta value from counter
	wire abs_beta;			//take abs of beta
	wire find_alpha;		//calculate alpha using beta
	wire find_wall_intersection;    //use raycast modules 
	wire find_position_diff;	//find difference in position coordinates
	wire find_dist;			//divide by cos alpha
	wire find_ABS;			//take abs of sifference ABS(Px-Ex)/cos alpha
	wire lower_dist;		//choose the smaller value
	wire rev_fishbowl;		//multiply by cos beta
	wire proj_height;		//divide by 8896 and find proj height  
	wire end_calc;    		//indicates that the calculation has ended 
	wire wall_found_horiz; 		//indicates wall is found at ray 
	wire wall_found_vert;		//indicates wall is found at vertical ray 
	wire wall_found;  		//high if wall is found at angle 
	wire end_horiz_int_calc;   	//indicates horizontal intersection calculations are complete 
	wire end_vert_int_calc;		//indicates vertical intersection calculations are complete 
	wire end_int_calc;		//indicates intersection calculation has ended
	


//-------outputs 
assign height = proj_height; 
assign end_calc = end_calc;

//call datapath and control here 
control_draw_slice_FSM u1( 	.clock(clock),
				.resetn(resetn),
				.begin_calc(begin_calc),
				.end_calc(end_calc),
				.end_horiz_int_calc(end_horiz_int_calc),
				.end_vert_int_calc(end_vert_int_calc),
				.end_int_calc(end_int_calc),
				.wall_found_horiz(wall_found_horiz),
				.wall_found_vert(wall_found_vert),
				.wall_found(wall_found),
				.reset_datapath(reset_datapath),
				.find_beta(find_beta), 
				.find_abs_beta(abs_beta),
				.find_alpha(find_alpha), 
				.find_wall_intersection(find_wall_intersection),
				.find_position_diff(find_position_diff), 
				.find_dist(find_dist),
				.find_ABS(find_ABS), 
				.lower_dist(lower_dist), 
				.rev_fishbowl(rev_fishbowl), 
				.proj_height(proj_height), 
				.end_calc(end_calc)
				);




datapath_draw_slice_fsm u2( .clock(clock),
				.resetn(resetn), 
				.begin_calc(begin_calc),
				.reset_datapath(reset_datapath),
				.find_beta(find_beta),
				.find_abs_beta(abs_beta), 
				.find_alpha(find_alpha), 
				.find_wall_intersection(find_wall_intersection),
				.find_position_diff(find_position_diff), 
				.find_dist(find_dist),
				.find_ABS(find_ABS), 
				.lower_dist(lower_dist), 
				.rev_fishbowl(rev_fishbowl), 
				.proj_height(proj_height), 
				.playerX(playerX), 
				.playerY(playerY),
				.angleX(angleX), 
				.angleY(angleY),
				.counter_value(counter_value),
				.end_horiz_int_calc(end_horiz_calc),
				.end_vert_int_calc(end_vert_calc),
				.end_int_calc(end_int_calc),
				.wall_found_horiz(wall_found_horiz),
				.wall_found_vert(wall_found_vert),
				.end_calc(end_calc),
				.height(proj_height)
);


endmodule


module control_draw_slice_FSM(input clock, resetn, begin_calc, end_calc, end_horiz_int_calc, end_vert_int_calc, end_int_calc, wall_found_horiz, wall_found_vert, wall_found,
				output reg reset_datapath, find_beta, find_alpha, find_wall_intersection, find_position_diff,  find_dist,
				find_ABS, lower_dist, rev_fishbowl, proj_height);

		reg [3:0] current_state, next_state;
		
		
		localparam S_WAIT = 4'd0,
					S_FIND_BETA = 4'd1,
					S_FIND_ABS_BETA = 4'd2,
					S_FIND_ALPHA = 4'd3,
					S_FIND_WALL_INTERSECTION = 4'd4,
					S_FIND_POSITION_DIFF = 4'd5,
					S_FIND_DIST = 4'd6,
					S_FIND_ABS = 4'd7,		
					S_LOWER_DIST = 4'd8,
					S_REV_FISHBOWL = 4'd9,
					S_PROJ_HEIGHT = 4'd10;
					
///state table /////

	always @(*)
	begin: state_table 

		case(current state)
			S_WAIT: begin_calc ? S_FIND_BETA : S_WAIT;
			S_FIND_BETA: next_state = S_FIND_ABS_BETA;
			S_FIND_ABS_BETA: next_state = S_FIND_ALPHA;
			S_FIND_ALPHA: next_state = S_FIND_WALL_INTERSECTION;
			S_FIND_WALL_INTERSECTION: end_horiz_int_calc ? S_FIND_POSITION_DIFF : S_WAIT;
			S_FIND_POSITION_DIFF: next_state = S_FIND_DIST;		
			S_FIND_DIST: next_state = S_FIND_ABS;
			S_FIND_ABS: next_state = S_LOWER_DIST;
			S_LOWER_DIST: next_state = S_REV_FISHBOWL;
			S_REV_FISHBOWL: next_state = S_PROJ_HEIGHT;
			S_PROJ_HEIGHT: next_state =  end_calc ? S_WAIT : S_PROJ_HEIGHT;
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
				input signed [12:0] playerX, playerY,
			        input [9:0] angle_X, angle_Y,
			        input [7:0] coulumn_count,
				output reg end_horiz_int_calc, end_vert_int_calc, end_int_calc, wall_found_horiz, wall_found_vert, wall_found, end_calc,
				output [6:0] height
					);
	
		reg signed [9:0] betaX, betaY, alphaX, alphaY, 
		reg signed [12:0] wall_int_horiz, wall_int_vert, positionDiff_X, positionDiff_Y, distX, distY, abs_distX, abs_distY, lowerDist, rev_fish;
		
		
//--------------finding wall intersection using raycast modules -----------

wire signed [12:0] wallX_horiz;
wire signed [12:0] wallX_vert;

find_wall_intersection_horiz h1(.playerX(playerX), .playerY(playerY), .alphaX(alphaX), .alphaY(alpha_Y), .clock(clock), .resetn(resetn), .begin_calc(begin_calc), .wallfound(wall_found_horiz), .end_calc(end_horiz_int_calc));
find_wall_intersection_vert v1(.playerX(playerX), .playerY(playerY), .alphaX(alphaX), .alphaY(alpha_Y), .clock(clock), .resetn(resetn), .begin_calc(begin_calc), .wallfound(wall_found_vert), .end_calc(end_vert_int_calc));
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

/// ----------int multiplied by fixed point module  -------------
wire signed [5:0] beta_x;
wire signed [9:0] beta_y;

wire signed [5:0] alpha_x;
wire signed [9:0] alpha_y;

int_fixed_point_mult_fixed_point m1(
	.int_in(column_count)
		.fixed_X(1'b0),
		.fixed_Y(3'd375),
 		.fixed_X_out(beta_x),
		.fixed_Y_out(beta_y)
);

int_fixed_point_mult_fixed_point m2(
	.int_in(column_count)
		.fixed_X(1'b0),
		.fixed_Y(9'b101110111),
 		.fixed_X_out(alpha_x),
		.fixed_Y_out(alpha_y)
);

//------fixed point subtracted by fixed point------------

wire signed [9:0] Beta_X;
wire signed [9:0] Beta_Y;
wire signed [9:0] Alpha_X;
wire signed [9:0] Alpha_Y;


int_fixed_point_subtract_fixed_point s1(
	.fixed_X_in_1(beta_x),
	.fixed_Y_in_1(beta_y),
	.fixed_X_in_2(10'b0000011110),
	.fixed_Y_in_2(10'b0000000000),
	.fixed_X_out(Beta_x), 
	.fixed_Y_out(Beta_Y)
	);

int_fixed_point_subtract_fixed_point s2(
	.fixed_X_in_1(angle_X + 30),
	.fixed_Y_in_1(angle_Y),
	.fixed_X_in_2(alpha_x),
	.fixed_Y_in_2(alpha_y),
	.fixed_X_out(Alpha_X), 
	.fixed_Y_out(Alpha_Y)
	);


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
			
	end
	else begin
		
		if (reset_datapath) begin
			end_calc <= 1'b0;
		end
	
		if (find_beta) begin
			betaX <= Beta_Y;
			betaY <= Beta_Y;
		end
		
		if (find_alpha) begin
			if (Alpha_X > 6'b111100) begin
				alphaX <= Alpha_X - 9'b101101000;
				alphaY <= Alpha_Y;
			end
			
			else if (Alpha_X < 1'b0) begin
				alphaX <= Alpha_X + 9'b101101000;
				alphaY <= Alpha_Y;
			end 
			else begin
				alphaX <= Alpha_X;
				alphaY <= Alpha_Y;
			end 
			
		end
		
		if (find_wall_intersection) begin
			wall_int_horiz <= wallX_horiz;
			wall_int_vert <= wallX_vert;
			
			
		end 
		
		if (find_position_diff) begin 
			positionDiff_X <= playerX - wall_int_horiz;
			positionDiff_Y <= playerX - wall_int_vert;
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
			end_calc <= 1'b1;
		end


	end 
end 

	













