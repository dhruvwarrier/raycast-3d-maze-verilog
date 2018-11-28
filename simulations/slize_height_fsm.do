vlib work
vlog fixed_point_arithmetic.v
vlog LUTcos.v
vlog LUTtan.v
vlog find_intersection_horiz.v
vlog find_intersection_vert.v
vlog level_data.v
vlog find_slice_size.v

vsim find_slice_size
log {/*}
add wave {/*}

# 50 MHz clock, 20ns clock cycle
force {clock} 0 0ns, 1 10ns -r 20ns
force {resetn} 0
run 20ns

force {resetn} 1
force {begin_calc} 1

run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#45
force {angle_Y} 10#375
force {column_count} 10#100

run 1000ns

	