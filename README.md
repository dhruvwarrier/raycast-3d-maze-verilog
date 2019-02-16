# raycast-3d-maze-verilog

A 3D renderer designed in Verilog for Altera Cyclone FPGAs. Video output to VGA monitors. Tested on a Terasic DE1_SoC prototype board (Cyclone V).

Uses the ray-casting method (https://en.wikipedia.org/wiki/Ray_casting) in the style of early 3D video games like Wolfenstein 3D. The renderer draws 160 "slices" to the screen every frame to render the walls of a maze. 

- The player camera has a field of view of **60°** and a slice is drawn at every **0.375°**. 
- Level data is present in *level_data.v* in the form of a lookup table. Each level is made up of **64 x 64** grid blocks, and at each block a wall may/may not exist.
  * The 4096 possible grid locations can be addressed by grid_address, which is a flattened (X , Y) address: *grid_address = Y * 64 + X*.
  * Each grid block is 64 positions in size, so the player can move in a space of **4096 x 4096** positions.
  * *level_data.v* currently represents a hallway **5 grid blocks long and 3 grid blocks wide** at the top left of the grid. This can be replaced with any source of memory, but it must respond in the next cycle **(20 ns)**.
- Renders frames at 30 fps, but can be pushed to a maximum of **~600 fps**. In rateDivider.v, change line 15 to *counter <= 50 million / (required fps)* to change the frame-rate.

### Credit: 
VGA adapter under vga_adapter/ (http://www.eecg.toronto.edu/~jayar/ece241_08F/vga/)
- vga_adapter/ provides a frame buffer and encodes analog output to drive the VGA monitor
