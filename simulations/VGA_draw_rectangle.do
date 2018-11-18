vlib work
vlog ../VGA_draw_rectangle.v

vsim datapath
log {/*}
add wave {/*}

# 50 MHz clock, 20ns clock cycle
force {clock} 0 0ns, 1 10ns -r 20ns
force {resetn} 1

force {X_pos_in} 10#142
force {Y_pos_in} 10#90
force {rect_size} 10#6

force {load_rect_size} 1
run 20ns
force {load_rect_size} 0

force {plot_counter_enable} 1

run 140ns
