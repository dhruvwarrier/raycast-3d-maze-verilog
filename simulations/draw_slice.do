vlib work
vlog ../fixed_point_arithmetic.v
vlog ../trig_LUTs/LUTcos.v
vlog ../find_intersection_horiz.v
vlog ../find_intersection_vert.v
vlog ../level_data.v
vlog ../draw_slice_FSM.v

vsim datapath_draw_slice_fsm
log {/*}
add wave {/*}

# 50 MHz clock, 20ns clock cycle
force {clock} 0 0ns, 1 10ns -r 20ns

force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#3
force {angle_Y} 10#375
force {column_count} 10#4

force {resetn} 0
run 20ns
force {resetn} 1

force {reset_datapath} 1
run 20ns
force {reset_datapath} 0

force {find_beta} 1
run 20ns
force {find_beta} 0

force {abs_beta} 1
run 20ns
force {abs_beta} 0

force {find_alpha} 1
run 20ns
force {find_alpha} 0

force {find_wall_intersection} 1
run 20ns
force {find_wall_intersection} 0

run 100ns

force {find_position_diff} 1
run 20ns
force {find_position_diff} 0

force {find_dist} 1
run 20ns
force {find_dist} 0

force {find_ABS} 1
run 20ns
force {find_ABS} 0

force {lower_dist} 1
run 20ns
force {lower_dist} 0

force {rev_fishbowl} 1
run 20ns
force {rev_fishbowl} 0

force {proj_height} 1
run 20ns
force {proj_height} 0

run 40ns
