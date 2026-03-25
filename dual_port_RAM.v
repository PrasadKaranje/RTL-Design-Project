`timescale 1ns/1ps
module DPRAM ( output reg [7:0] dout1 , dout2 , output reg invalid , input rst , clk , wr1,
wr2, input [7:0] din1, din2, add1 , add2
);
integer k = 0 ;
reg [7:0] ram [0:7] ;
always@ (posedge clk) begin
if (rst) begin
for (k=0 ; k<=7 ; k=k+1)
ram[k] <= 8'd0 ; end
else if ((add1==add2) && ({wr2,wr1}==2'b11 || {wr2,wr1}==2'b10 || {wr2,wr1}==2'b01))
begin invalid <= 1'b1 ; end
else begin
invalid <= 1'b0 ;
case ({wr2, wr1})2'b11 : begin ram[add2] <= din2 ; ram[add1] <= din1 ; end
2'b10 : begin ram[add2] <= din2 ; dout1 <= ram[add1] ; end
2'b01 : begin dout2 <= ram[add2] ; ram[add1] <= din1 ; end
2'b00 : begin dout2 <= ram[add2] ; dout1 <= ram[add1] ; end
default: begin dout2 <= 8'd0 ; dout1 <= 8'd0 ; end
endcase
end
end
endmodule