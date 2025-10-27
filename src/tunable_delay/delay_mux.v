`timescale 1ns/1ps

module delay_mux (
    input  wire cand0,  // clk_in (shortest)
    input  wire cand1,  // t_tap[4]   (mid transistor)
    input  wire cand2,  // t_tap[12]  (long transistor)
    input  wire cand3,  // w_tap_b    (medium wire)
    input  wire cand4,  // w_tap_c    (long wire)
    input  wire [4:0] sel, // one-hot or pseudo-one-hot tuning bits
    output wire clk_out
);


    wire pick0 = sel[0] ? cand0 : 1'b0;
    wire pick1 = sel[1] ? cand1 : 1'b0;
    wire pick2 = sel[2] ? cand2 : 1'b0;
    wire pick3 = sel[3] ? cand3 : 1'b0;
    wire pick4 = sel[4] ? cand4 : 1'b0;


    assign clk_out = pick4 | pick3 | pick2 | pick1 | pick0;

endmodule
