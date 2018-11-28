vlib work
vlog ../fixed_point_arithmetic.v
vlog ../trig_LUTs/LUTcos.v
vlog ../trig_LUTs/LUTtan.v
vlog ../find_intersection_horiz.v
vlog ../find_intersection_vert.v
vlog ../level_data.v
vlog ../find_slice_size.v

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

#column #5
force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#5

run 1000ns

#column #10
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#10

run 1000ns

#column #15
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#15

run 1000ns

#column #20
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#20

run 1000ns

#column #25
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#25

run 1000ns

#column #30
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#30

run 1000ns

#column #35
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#35

run 1000ns

#column #40
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#40

run 1000ns

#column #90
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#45

run 1000ns

#column #50
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#50

run 1000ns

#column #55
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#55

run 1000ns

#column #60
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#60

run 1000ns

#column #65
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#65

run 1000ns

#column #70
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#70

run 1000ns

#column #75
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#75

run 1000ns

#column #80
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#80

run 1000ns

#column #85
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#85

run 1000ns

#column #90
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#90

run 1000ns

#column #95
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#95

run 1000ns

#column #100
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#100

run 1000ns

#column #105
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#105

run 1000ns

#column #110
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#110

run 1000ns

#column #115
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#115

run 1000ns

#column #120
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#120

run 1000ns

#column #125
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#125

run 1000ns

#column #130
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#130

run 1000ns


#column #135
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#135

run 1000ns

#column #140
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#140

run 1000ns

#column #190
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#145

run 1000ns

#column #150
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#150

run 1000ns

#column #155
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#155

run 1000ns

#column #160
force {begin_calc} 1
run 20ns

force {begin_calc} 0
force {playerX} 10#100
force {playerY} 10#100
force {angle_X} 10#90
force {angle_Y} 10#375
force {column_count} 10#160

run 1000ns