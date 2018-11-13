vlib work

vlog ../find_intersection_horiz.v
vlog ../trig_LUTs/LUTtan.v
vlog ../level_data.v

vsim datapath_find_intersection_horiz
log {/*}
add wave {/*}

# 50 MHz clock, 20ns clock cycle
force {clock} 0 0ns, 1 10ns -r 20ns
force {resetn} 1

force {playerX} 000001100100
force {playerY} 000001100100
force {alpha} 10#30

force {reset_datapath} 1
run 20ns
force {reset_datapath} 0

force {find_first_intersection_0} 1
run 20ns
force {find_first_intersection_0} 0

force {find_first_intersection_1} 1
run 20ns
force {find_first_intersection_1} 0

force {find_offset_0} 1
run 20ns
force {find_offset_0} 0

force {find_offset_1} 1
run 20ns
force {find_offset_1} 0

force {find_next_intersection} 1
run 20ns
force {find_next_intersection} 0

force {convert_to_grid_coords} 1
run 20ns
force {convert_to_grid_coords} 0

force {check_for_wall} 1
run 20ns
force {check_for_wall} 0
