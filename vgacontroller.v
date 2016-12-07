`include "debounceButton.v"
`include "vsync.v"
`include "hsync.v"
`include "vram.v"

module vgacontroller(reset, clk, VGA_RED, VGA_GREEN, VGA_BLUE, VGA_HSYNC, VGA_VSYNC);

/* input/ouput of vgacontroller */
input  reset, clk;
output VGA_HSYNC, VGA_VSYNC;
output VGA_RED, VGA_GREEN, VGA_BLUE;

/* debounceButton wiring */
wire reset_debounced;
/* vram wiring */
wire [13:0] vga_addr;
wire vga_red_r, vga_green_r, vga_blue_r;
/* hsync & vsync wiring */
wire [6:0] HPIXEL, VPIXEL;
wire RGB_HSYNC, RGB_VSYNC;

/* Assignment */
assign vga_addr = {VPIXEL, HPIXEL};

/* Always block to handle the colors properly 
always @(*) 
begin
	if(RGB_HSYNC && RGB_VSYNC)
	begin
		VGA_RED = vga_red_r;
		VGA_GREEN = vga_green_r;
		VGA_BLUE = vga_blue_r;
	end
	else
	begin
		VGA_RED = 1'b0;
		VGA_GREEN = 1'b0;
		VGA_BLUE = 1'b0;
	end
end*/
//assign {VGA_RED, VGA_GREEN, VGA_BLUE} = (RGB_HSYNC && RGB_VSYNC) ? {vga_red_r, vga_green_r, vga_blue_r} : {1'b0,1'b0,1'b0};
/* Instantiations */
vram  vramINST(clk, 1'b0, 1'b0, 1'b0, vga_addr, 1'b1, 1'b0, 1'b0, VGA_RED, VGA_GREEN, VGA_BLUE);
hsync hsyncINST(clk, reset_debounced, HPIXEL, VGA_HSYNC, RGB_HSYNC);
vsync vsyncINST(clk, reset_debounced, RGB_HSYNC, VPIXEL, VGA_VSYNC);
debounceButton debounceButtonINST(clk, reset, reset_debounced);

endmodule