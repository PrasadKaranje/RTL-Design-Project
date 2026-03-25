`timescale 1ns/1ps
module BSG (output reg y=0, input rst, clk);
reg [3:0] temp ;
always@ (posedge clk) begin
if (rst) begin temp <= 4'b1111 ; end
else begin
temp <= {(temp[0]^temp[1]),temp[3], temp[2], temp[1]};
y <= temp[3] ; end
end
endmodule


`timescale 1ns/1ps
module tb;
// Inputs
reg rst, clk;
// Outputs
wire y;
// Instantiate the Unit Under Test (UUT)
BSG uut (.y(y), .rst(rst), .clk(clk)
);
always #20 clk = ~ clk ;
initial begin
// Initialize Inputs
rst = 1; clk = 0;
#50 rst = 0 ;
#900 $finish ;
// Add stimulus here
end
endmodule