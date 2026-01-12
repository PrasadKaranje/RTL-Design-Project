// Module: clock_div_5
// Function: Divides input clock by 5 with a 50% duty cycle
module clock_div_5 (
    input  clk_in,    // Input Clock
    input  reset,     // Active High Reset
    output clk_out    // Divided Output Clock (50% Duty Cycle)
);

    reg [2:0] pos_count;
    reg [2:0] neg_count;

    // 1. Rising Edge Counter (0 to 4)
    always @(posedge clk_in or posedge reset) begin
        if (reset)
            pos_count <= 3'b000;
        else if (pos_count == 4)
            pos_count <= 3'b000;
        else
            pos_count <= pos_count + 1;
    end

    // 2. Falling Edge Counter (0 to 4)
    always @(negedge clk_in or posedge reset) begin
        if (reset)
            neg_count <= 3'b000;
        else if (neg_count == 4)
            neg_count <= 3'b000;
        else
            neg_count <= neg_count + 1;
    end

    // 3. Generate 50% Duty Cycle by ORing the two offset signals
    // Each internal signal is HIGH for 2 cycles and LOW for 3 cycles (40% duty cycle)
    // The half-cycle shift between them creates the 2.5 cycle HIGH pulse.
    assign clk_out = (pos_count < 2) | (neg_count < 2);

endmodule
