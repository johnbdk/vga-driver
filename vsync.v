module vsync(clk, reset, RGB_HSYNC, VPIXEL, VGA_VSYNC);
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

reg [6:0] VPIXEL;
reg [19:0] VSYNC_cnt;
reg [2:0] cnt;

always@(posedge clk or posedge reset)
begin
	if(reset)
	begin
		VPIXEL = 7'd0;
		VSYNC_cnt = 20'd0;
		cnt = 3'd0;
	end
	else if (RGB_HSYNC)
	begin
		if(VSYNC_cnt > 33 && VSYNC_cnt < 514)
		begin
			if(VPIXEL == 7'd95)
			begin
				if(cnt == 3'd4)
				begin
					VPIXEL = 7'd0;
					cnt = 3'd0;
				end
				else
					cnt = cnt + 1'b1;
			end
			else if(cnt == 3'd4)
				begin
					VPIXEL = VPIXEL + 1'b1;
					cnt = 3'd0;
				end
			else
				cnt = cnt + 1'b1;
		end

		if(VSYNC_cnt == 524)
			VSYNC_cnt = 20'd0;
		else 
			VSYNC_cnt = VSYNC_cnt+1;
	end
end

assign VGA_VSYNC = !((VSYNC_cnt == 0) || (VSYNC_cnt == 1));

endmodule