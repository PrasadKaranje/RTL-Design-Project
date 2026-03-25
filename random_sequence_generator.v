`timescale 1ns/1ps
module RSG (output reg [3:0] out, input rst, clk);
always@ (posedge clk) begin
if (rst)
out <= 4'b1111;
else
out <= {out[0], (out[1]^out[0]), out[2], out[1]} ;
end
endmodule


///tb
`timescale 1ns/1ps
module tb;
// Inputs
reg rst; reg clk;
// Outputs
wire [3:0] out;
// Instantiate the Unit Under Test (UUT)
RSG uut (.out(out), .rst(rst), .clk(clk));
always #20 clk = ~ clk ;
initial begin
// Initialize Inputs
rst = 1; clk = 1;
#20 rst =0;
#400 $finish;
end
endmodule