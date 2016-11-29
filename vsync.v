module hsync(clk, reset, VPIXEL, VGA_VSYNC);
input clk, reset;
output [6:0]VPIXEL;
output VGA_VSYNC;

reg [6:0]VPIXEL;
reg [19:0]VSYNC_cnt;
reg [2:0] cnt;
//reg [10:0]HPIXEL_next;

always@(posedge clk or posedge resetbutton)
begin
	if(resetbutton)
		VPIXEL = 7'd0;
		VSYNC_cnt = 19'd0;
		cnt = 3'd0;
	else
	begin
		if(VSYNC_cnt >= 47600 || VSYNC_cnt <= 815599)
		begin
			if(VPIXEL == 7'd96)
				VPIXEL = 7'd0;
			else
			begin
				if(cnt == 3'd4)
				begin
					VPIXEL = VPIXEL + 1'b1;
					cnt = 3'd0;
				end
				else
					cnt = cnt + 1'b1;
			end
		end
		if(VSYNC_cnt == 19'd833499)
			VSYNC_cnt = 19'd0;
		else
			VSYNC_cnt = VSYNC_cnt+1;
		end
	end
end

assign VGA_HSYNC = ((VSYNC_cnt >= 19'd0) || (VSYNC_cnt <= 19'd3199)) ? 1'd0 : 1'd1;
/*
O = 833500 cycles (scanline)
P = 3200 cycles (pulse width)
Q = 46400 cycles (back porch)
R = 768000 cycles (display)
S = 16000 cycles (front porch)
*/

endmodule