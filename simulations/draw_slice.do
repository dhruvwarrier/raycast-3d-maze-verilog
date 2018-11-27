vlib work
vlog ../fixed_point_arithmetic.v
vlog ../trig_LUTs/LUTcos.v
vlog ../trig_LUTs/LUTtan.v
vlog ../find_intersection_horiz.v
vlog ../find_intersection_vert.v
vlog ../level_data.v
vlog ../find_slice_size.v

vsim datapath_find_slice_size
log {/*}
add wave {/*}

# 50 MHz clock, 20ns clock cycle
force {clock} 0 0ns, 1 10ns -r 20ns

force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#45
force {angle_Y} 10#375
force {column_count} 10#100

force {resetn} 0
run 20ns
force {resetn} 1

force {find_angle_offset_0} 1
run 20ns
force {find_angle_offset_0} 0

force {find_angle_offset_1} 1
run 20ns
force {find_angle_offset_1} 0

force {find_alpha_beta_0} 1
run 20ns
force {find_alpha_beta_0} 0

force {find_alpha_beta_1} 1
run 20ns
force {find_alpha_beta_1} 0

force {find_alpha_beta_2} 1
run 20ns
force {find_alpha_beta_2} 0

force {find_alpha_beta_3} 1
run 20ns
force {find_alpha_beta_3} 0

force {find_ray_grid_intersections} 1
run 20ns
force {find_ray_grid_intersections} 0

run 1000ns

force {find_distances_0} 1
run 20ns
force {find_distances_0} 0

force {find_distances_1} 1
run 20ns
force {find_distances_1} 0

force {find_distances_2} 1
run 20ns
force {find_distances_2} 0

force {find_closer_distance} 1
run 20ns
force {find_closer_distance} 0

force {perform_reverse_fishbowl} 1
run 20ns
force {perform_reverse_fishbowl} 0

force {perform_project_to_screen_0} 1
run 20ns
force {perform_project_to_screen_0} 0

force {perform_project_to_screen_1} 1
run 20ns
force {perform_project_to_screen_1} 0

run 60ns