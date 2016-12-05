`timescale 1ns / 1ps

module vgacontroller_tb;

	// Inputs
	reg reset;
	reg clk;

	// Outputs
	wire VGA_RED;
	wire VGA_GREEN;
	wire VGA_BLUE;
	wire VGA_HSYNC;
	wire VGA_VSYNC;

	// Instantiate the Unit Under Test (UUT)
	vgacontroller uut (
		.reset(reset), 
		.clk(clk), 
		.VGA_RED(VGA_RED), 
		.VGA_GREEN(VGA_GREEN), 
		.VGA_BLUE(VGA_BLUE), 
		.VGA_HSYNC(VGA_HSYNC), 
		.VGA_VSYNC(VGA_VSYNC)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        reset = 1;
		// Add stimulus here
		#100;
		reset = 0;

	end

	always #10
	clk = ~clk;
      
endmodule

