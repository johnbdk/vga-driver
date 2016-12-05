/* Debounce Button
 *
 * This is a module that implements an anti-bounce
 * filter for mechanical buttons. There are 2 FFs 
 * in series used for 1 cycle delay. Also there is
 * a counter for any remaining bounces. When the 
 * counter reaches max value we are sure if the button
 * was pressed or not.
**/

module debounceButton(clk, buttin, buttout);

input clk, buttin;
output reg buttout;

reg [2:0] counter;		// artificial delay to reach the safe state
reg ff1, ff2; 		 	// output from flipflop 1,2 correspondingly
reg flag;				// Flag is used to prevent output 1 for more than one cycles
wire async_button; 		// compare the output of 2 flipflops

always @(posedge clk)	// 2 flip flops in series for 1 cycle delay on buttin
begin
	ff1 = buttin;
end

always @(posedge clk)	// reg(ff2) is the async output of second FF
begin
	ff2 = ff1;
end

assign async_button = ff2;
wire counter_max = 3'b111;	

always @(posedge clk)			
begin
	if(async_button)
	begin
		if (counter_max && flag)
		begin
			buttout = 1'b1;
			flag = 1'b0;
		end
		else
		begin
			counter = counter + 1'b1;
			buttout = 1'b0;
		end
	end
	else
	begin
		counter = 1'b0;
		flag = 1'b1;
		buttout = 1'b0;
	end
end

endmodule