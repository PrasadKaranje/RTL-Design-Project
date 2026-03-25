`timescale 1ns/1ps
module SPRAM (output [7:0] dout , input rst , clk , wr ,
input [7:0] add , din
);
integer k = 0 ;
reg [7:0] ram [0:7] ;
always@ (posedge clk) begin
if (rst) begin
for (k=0 ; k <=7 ; k=k+1)
ram[k] <= 8'd0 ; end
else if ( wr==1) begin
ram[add] <= din ; end
end
assign dout = (wr==0) ? ram[add] : 8'd0 ;
endmodule


module tb;
// Inputs
reg rst , clk , wr ;
reg [7:0] add , din ;
// Outputs
wire [7:0] dout;
// Instantiate the Unit Under Test (UUT)
SPRAM uut (.dout(dout), .rst(rst), .clk(clk),
.wr(wr), .add(add), .din(din) );
always #50 clk = ~ clk ;
initial begin
// Initialize Inputs
rst = 1 ; clk = 0 ; wr = 1 ;
add = 8'd0 ; din = 8'd0 ;
#50 add = 8'd2 ; din = 8'd90 ; rst = 0 ;
#100 add = 8'd3 ; din = 8'd91 ; #100 add = 8'd5 ; din = 8'd92 ;
#100 add = 8'd7 ; din = 8'd93 ;
#100 wr = 0 ; add = 8'd3 ; #100 add = 8'd2 ; #100 add = 8'd7 ;
#100 add = 8'd5 ; rst = 1 ;
// Wait 100 ns for global reset to finish
#100 $finish;
end
endmodule