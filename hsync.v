module hsync(clk, reset, HPIXEL, VGA_HSYNC, RGB);
/**
  * A = 1600 cycles (scanline)
  * B = 192 cycles (pulse width)
  * C = 96 cycles (back porch)
  * D = 1280 cycles (display)
  * E = 32 cycles (front porch)
  **/
input  clk, reset;
output [6:0] HPIXEL;
output VGA_HSYNC;
output RGB;

reg [6:0] HPIXEL;
reg [10:0] HSYNC_cnt;
reg [2:0] cnt;

always@(posedge clk or posedge reset)
begin
	if(reset)
	begin
		HPIXEL = 7'd0;
		HSYNC_cnt = 11'd0;
		cnt = 3'd0;
	end
	else
	begin
		if(HSYNC_cnt >= 288 && HSYNC_cnt <= 1567)
		begin
			if(HPIXEL == 7'd127)
				if(cnt == 3'd4) begin
					HPIXEL = 7'd0;
					cnt = 3'd0;
				end
				else
					cnt = cnt + 1;
			else
			begin
				if(cnt == 3'd4)
				begin
					HPIXEL = HPIXEL + 1'b1;
					cnt = 3'd0;
				end
				else
					cnt = cnt + 1'b1;
			end
		end

		if(HSYNC_cnt == 11'd1599)
			HSYNC_cnt = 11'd0;
		else
			HSYNC_cnt = HSYNC_cnt+1;
	end
end

assign RGB = (HSYNC_cnt >= 288 && HSYNC_cnt <= 1567) ? 1'd1 : 1'd0;
assign VGA_HSYNC = ((HSYNC_cnt >= 11'd0) && (HSYNC_cnt <= 11'd191)) ? 1'd0 : 1'd1;

endmodule