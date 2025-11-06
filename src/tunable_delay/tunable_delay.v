`timescale 1ns/1ps

module tunable_delay (
    input  wire        clk_in,
    input  wire [4:0]  tuning_bits, // scan/CSR bits, fixed after boot
    output wire        clk_out
);
    // transistor-delay block: many small buffer stages
    wire [15:1] t_tap;
    transistor_delay_block TDB (
        .clk_in(clk_in),
        .tap   (t_tap)
    );

    // interconnect-delay block: long serpentine wire
    wire w_tap_a, w_tap_b, w_tap_c;
    wire_delay_block WDB (
        .clk_in(clk_in),
        .tap_short (w_tap_a),
        .tap_med (w_tap_b),
        .tap_long (w_tap_c)
    );

    // Select representative delay points as candidate taps
  
    wire cand0 = clk_in;        // shortest
    wire cand1 = t_tap[3];      // mid transistor
    wire cand2 = t_tap[13];     // long transistor
    wire cand3 = w_tap_b;       // medium wire
    wire cand4 = w_tap_c;       // long wire

    // multiplexer (use static tuning_bits to select output)
    // >>> Strongly recommend making this mux a leaf module 'delay_mux'
    //     and set_dont_touch it to keep the tap->out structure readable in netlist
    wire clk_sel;

    delay_mux DMUX (
        .cand0 (cand0),
        .cand1 (cand1),
        .cand2 (cand2),
        .cand3 (cand3),
        .cand4 (cand4),
        .sel   (tuning_bits),
        .clk_out (clk_sel)
    );

    assign clk_out = clk_sel; // output to global clock tree root
endmodule