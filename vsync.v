module vsync(clk, reset, RGB_HSYNC, VPIXEL, VGA_VSYNC, RGB);
/**
  * O = 833500 cycles (scanline)
  * P = 3200 cycles (pulse width)
  * Q = 46400 cycles (back porch)
  * R = 768000 cycles (display)
  * S = 16000 cycles (front porch)
  **/
input  clk, reset, RGB_HSYNC;
output [6:0] VPIXEL;
output VGA_VSYNC;
output RGB;

reg [6:0] VPIXEL;
reg [19:0] VSYNC_cnt;
reg [2:0] cnt;
reg hsync_tick;

always@(RGB_HSYNC)
begin
	if (RGB_HSYNC)
		hsync_tick = 1'b1;
	else
		hsync_tick = 1'b0;
end

always@(posedge clk or posedge reset)
begin
	if(reset)
	begin
		VPIXEL = 7'd0;
		VSYNC_cnt = 20'd0;
		cnt = 3'd0;
	end
	else
	begin
		if(VSYNC_cnt >= 49600 && VSYNC_cnt <= 817599)
		begin
			if((VPIXEL == 7'd95) && (hsync_tick))
			begin
				hsync_tick = 1'b0;
				if(cnt == 3'd4)
				begin
					VPIXEL = 7'd0;
					cnt = 3'd0;
				end
				else
					cnt = cnt + 1'b1;
			end
			else if(hsync_tick)
			begin
				hsync_tick = 1'b0;
				if(cnt == 3'd4)
				begin
					VPIXEL = VPIXEL + 1'b1;
					cnt = 3'd0;
				end
				else
					cnt = cnt + 1'b1;
			end
		end

		if(VSYNC_cnt == 20'd833499)
			VSYNC_cnt = 20'd0;
		else
			VSYNC_cnt = VSYNC_cnt+1;
	end
end

assign RGB = (VSYNC_cnt >= 49600 && VSYNC_cnt <= 817599) ? 1'd1 : 1'd0;
assign VGA_VSYNC = ((VSYNC_cnt >= 20'd0) && (VSYNC_cnt <= 20'd3199)) ? 1'd0 : 1'd1;

endmodule