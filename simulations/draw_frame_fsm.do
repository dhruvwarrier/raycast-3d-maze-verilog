vlib work
vlog ../fixed_point_arithmetic.v
vlog ../trig_LUTs/LUTcos.v
vlog ../trig_LUTs/LUTtan.v
vlog ../find_intersection_horiz.v
vlog ../find_intersection_vert.v
vlog ../level_data.v
vlog ../find_slice_size.v
vlog ../draw_frame.v

vsim draw_frame
log {/*}
add wave {/*}

# 50 MHz clock, 20ns clock cycle
force {clock50MHz} 0 0ns, 1 10ns -r 20ns

force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#30
force {angle_Y} 10#375
force {slice_color} 001

force {resetn} 1

force {clock60Hz} 1
run 30ns
force {clock60Hz} 0

run 9000ns