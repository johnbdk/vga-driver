`timescale 1ns / 1ps

module vsync_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [6:0] VPIXEL;
	wire VGA_VSYNC;
	wire RGB;

	// Instantiate the Unit Under Test (UUT)
	vsync uut (
		.clk(clk), 
		.reset(reset), 
		.VPIXEL(VPIXEL), 
		.VGA_VSYNC(VGA_VSYNC),
		.RGB(RGB)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 1;
		#20 reset = 0;
        
		// Add stimulus here

	end
	
	always
	begin
		#10 clk = ~clk;
	end
      
endmodule

