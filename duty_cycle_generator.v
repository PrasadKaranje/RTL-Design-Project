`timescale 1ns/1ps
module DCG (output reg dclk , input rst , clk ,
input [7:0] duty , input [7:0] tp
);
reg [7:0] count ;
always@ ( posedge clk ) begin
if (rst) begin
count <= 8'd0 ; dclk <= 1'b0 ; end
else begin
count <= count + 8'd1 ;
if(count < tp)
dclk <= (count < ((duty * tp)/8'd100)) ? 1'b1 : 1'b0 ;
else
count <= 8'd0 ;
end
end
endmodule




module tb;
// Inputs
reg rst;
reg clk;
reg [7:0] duty , tp ;
// Outputs
wire dclk;
// Instantiate the Unit Under Test (UUT)
DCG uut (.dclk(dclk) , .rst(rst) , .clk(clk) , .duty(duty) , .tp(tp)
);
always #0.5 clk = ~ clk ;
initial begin
// Initialize Inputs
rst = 1 ; clk = 1 ; duty = 8'd0 ; tp = 8'd0 ;
#10 rst = 0 ; duty = 8'd25 ; tp = 8'd100 ;
#200 duty = 8'd50 ; tp = 8'd100 ;
#200 duty = 8'd60 ; tp = 8'd100 ;
#200 $finish ;
end
endmodule