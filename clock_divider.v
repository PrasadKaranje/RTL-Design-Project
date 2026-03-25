`timescale 1ns/1ps
module CD (output reg out = 0, input rst, clk, input [3:0] n
);
reg [3:0] count;
always@ (posedge clk or negedge clk) begin
if (rst) begin
count <= 4'd0; out <= 0; end
else if (count >= (n-1)) begin
count <= 4'd0; out <= ~out; end
else count <= count + 4'd1;
end
endmodule


`timescale 1ns/1ps
module tb;
// Inputs
reg rst, clk;
reg [3:0] n;
// Outputs
wire out;
// Instantiate the Unit Under Test (UUT)
CD uut (.out(out), .rst(rst), .clk(clk), .n(n)
);
always #5 clk = ~clk;
initial begin
// Initialize Inputs
clk = 0; rst = 1; n=4'd1;
#5 rst = 0; #5 n = 4'd3;
#30 n = 4'd4;
#40 n = 4'd5;
#50 $finish;
end
endmodule