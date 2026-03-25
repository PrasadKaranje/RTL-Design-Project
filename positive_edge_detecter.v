`timescale 1ns/1ps
module PED (output y, input clk, i);
	reg inv = 1'b0;
	always@ (posedge clk) begin
		if (i) inv <= 1'b1;
		else inv <= 1'b0;
	end
	assign y = i & (~inv);
endmodule

module tb;
// Inputs
reg clk; reg i;
// Outputs
wire y;
// Instantiate the Unit Under Test (UUT)
PED uut (.y(y), .clk(clk), .i(i)
);
always #5 clk = ~clk ;
initial begin
// Initialize Inputs
clk = 1;
i = 0; #9 i = 1;
#5 i=0; #8 i=1; #10 i = 0;
#12 i=1; #9 i=0; #10 i=1;
#15 $finish;
end
endmodule


