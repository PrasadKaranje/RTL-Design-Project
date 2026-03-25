`timescale 1ns/1ps
module VM (output reg delivered, L,K,C,M,I, output reg [8:0] total = 0,
output reg [8:0] coin_out = 0, input rst, clk, proceed, input a,b,c,d,e,
input [8:0] coin_in
);
parameter idle = 3'd0, select_item = 3'd1, review = 3'd2,
payment_status = 3'd3, refund = 3'd4;
reg [2:0] state;
always @ (posedge clk) begin
if (rst) begin
state <= idle; L <= 1'b0; K <= 1'b0; C <= 1'b0; M <= 1'b0; I <= 1'b0;
delivered <= 1'b0; coin_out <= 9'd0; total <= 9'd0;
end
else begin
case (state)
idle : begin
L <= 1'b0; K <= 1'b0; C <= 1'b0; M <= 1'b0; I <= 1'b0;
coin_out <= 9'd0; total <= 9'd0; delivered <= 1'b0;
state <= select_item; end
select_item : begin
total <= (10 * a + 10 * b + 20 * c + 20 * d + 25 * e );
state <= review; end
review: begin
if (proceed)
state <= payment_status;
else
state <= select_item;
end
payment_status: begin
if (total<=coin_in) begin
delivered <= 1'b1;
{L,K,C,M,I} <= {a,b,c,d,e};
state <= refund; end
else if (total> coin_in) begin
delivered <= 1'b0;
{L,K,C,M,I} <= 5'b0;
coin_out <= coin_in;
state <= payment_status; end
end
refund: begin
coin_out <= coin_in - total;
state <= idle;
endendcase
end
end
endmodule







//test bench
`timescale 1ns/1ps
module tb;
// Inputs
reg rst, clk, proceed, a, b, c, d, e ;
reg [7:0] coin_in;
// Outputs
wire delivered, L, K, C, M, I ;
wire [7:0] total, coin_out;
// Instantiate the Unit Under Test (UUT)
VM uut (.delivered(delivered), .L(L), .K(K), .C(C), .M(M), .I(I),
.total(total), .coin_out(coin_out), .rst(rst), .clk(clk),
.proceed(proceed), .a(a), .b(b), .c(c), .d(d), .e(e),
.coin_in(coin_in)
);
always #10 clk = ~clk;
initial begin
clk = 1; rst = 1; a = 0; b = 0; c = 0; d = 0; e = 0;
proceed = 0; coin_in = 9'd0;
#10 rst = 0; a = 1; b = 1; c = 0; d = 1; e = 0;
#10 proceed = 1;
#20 coin_in = 9'd100;
#60 a = 1; b = 0; c = 0; d = 1; e = 1;
#20 proceed = 1; #20 coin_in = 9'd100;
#100 $finish;
end
endmodule