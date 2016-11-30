`timescale 1ns / 1ps

module vram_tb;

	// Inputs
	reg DIA_R;
	reg DIA_G;
	reg DIA_B;
	reg [13:0] ADDRA;
	reg clk;
	reg ENA;
	reg SSRA;
	reg WEA;

	// Outputs
	wire DOA_R;
	wire DOA_G;
	wire DOA_B;

	// Instantiate the Unit Under Test (UUT)
	VRAM uut (
		.DIA_R(DIA_R), 
		.DIA_G(DIA_G), 
		.DIA_B(DIA_B), 
		.ADDRA(ADDRA), 
		.clk(clk), 
		.ENA(ENA), 
		.SSRA(SSRA), 
		.WEA(WEA), 
		.DOA_R(DOA_R), 
		.DOA_G(DOA_G), 
		.DOA_B(DOA_B)
	);

	initial begin
		// Initialize Inputs
		DIA_R = 0;
		DIA_G = 0;
		DIA_B = 0;
		ADDRA = 0;
		clk = 0;
		ENA = 0;
		SSRA = 0;
		WEA = 0;

		// Wait 100 ns for global reset to finish
		#100
		SSRA= 0;
        ENA = 1;
        //WEA = 1;
        //SSRA = 1;
        ADDRA = 14'd1;
        #100
        ADDRA = 14'd128;
        #100
        ADDRA = 14'd4097;
        #100
        ADDRA = 14'd4353;
	end

	always #10
		clk = ~clk;

      
endmodule

