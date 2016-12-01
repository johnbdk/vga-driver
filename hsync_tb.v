`timescale 1ns / 1ps

module hsync_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [6:0] HPIXEL;
	wire VGA_HSYNC;
	wire RGB;

	// Instantiate the Unit Under Test (UUT)
	hsync uut (
		.clk(clk), 
		.reset(reset), 
		.HPIXEL(HPIXEL), 
		.VGA_HSYNC(VGA_HSYNC),
		.RGB(RGB)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 1;
		#20
		reset = 0;
		// Add stimulus here

	end
   always#10
		clk = ~clk;
endmodule

