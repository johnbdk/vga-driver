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
	wire [2:0] rgb;

	// Instantiate the Unit Under Test (UUT)
	vram uut (
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
        /* RED ON */
        ADDRA = 14'd1;
        #100
		/* RED OFF */
        ADDRA = 14'd128;
        #100
		/* GREEN ON */
        ADDRA = 14'd4097;
    	#100
		/* GREEN OFF */
        ADDRA = 14'd4224;
        #100
		/* BLUE ON */
        ADDRA = 14'd8192;
        #100
		/* BLUE OFF */
        ADDRA = 14'd8320;
        #100
		/* BLUE ON */
        ADDRA = 14'd9216;
        #100
		/* GREEN ON */
        ADDRA = 14'd9217;
        #100
		/* RED ON */
        ADDRA = 14'd9218;
        #100
		/* BLACK ON */
        ADDRA = 14'd9219;
        #100
		/* RED ON */
        ADDRA = 14'd9470;
	end

	assign rgb = {DOA_R,DOA_G,DOA_B};

	always #10
		clk = ~clk;

      
endmodule

