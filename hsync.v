module hsync(clk, reset, HPIXEL, VGA_HSYNC);
input clk, reset;
output [6:0]HPIXEL;
output VGA_HSYNC;

reg [6:0]HPIXEL;
reg [10:0]HSYNC_cnt;
reg [2:0] cnt;
//reg [10:0]HPIXEL_next;

always@(posedge clk or posedge resetbutton)
begin
	if(resetbutton)
		HPIXEL = 7'd0;
		HSYNC_cnt = 11'd0;
		cnt = 3'd0;
	else
	begin
		if(HPIXEL == 7'd127)
			HPIXEL = 7'd0;
		else
		begin
			if(cnt == 3'd5)
				HPIXEL = HPIXEL + 1'b1;
			else
				cnt = cnt + 1'b1;
		end

		if(HSYNC_cnt == 11'd1599)
			HSYNC_cnt = 11'd0;
		else
			HSYNC_cnt = HPIXEL+1;
	end
end

assign VGA_HSYNC = ((HSYNC_cnt >= 11'd0) || (HSYNC_cnt <= 11'd191)) ? 1'd0 : 1'd1;
assign 
/*
A = 1600 cycles (scanline)
B = 192 cycles (pulse width)
C = 96 cycles (back porch)
D = 1280 cycles (display)
E = 32 cycles (front porch)
*/

endmodule