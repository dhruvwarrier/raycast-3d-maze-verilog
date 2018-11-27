vlib work

vlog ../find_intersection_horiz.v
vlog ../trig_LUTs/LUTtan.v
vlog ../level_data.v
vlog ../fixed_point_arithmetic.v

vsim find_wall_intersection_horiz
log {/*}
add wave {/*}

# 50 MHz clock, 20ns clock cycle
force {clock} 0 0ns, 1 10ns -r 20ns
force {resetn} 0
run 20 ns

force {resetn} 1
force {begin_calc} 1

run 20ns
force {begin_calc} 0
force {playerX} 000001100100
force {playerY} 000001100100
force {alpha_X} 10#355
force {alpha_Y} 10#875

run 10000ns
