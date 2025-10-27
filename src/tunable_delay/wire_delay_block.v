`timescale 1ns/1ps

module wire_delay_block (
    input  wire clk_in,
    output wire tap_short,
    output wire tap_med,
    output wire tap_long
);
    // short path: just one segment
    wire short_out;
    wire_segment seg_short (
        .din  (clk_in),
        .dout (short_out)
    );
    assign tap_short = short_out;

    // medium path: two segments back-to-back
    wire med_mid;
    wire_segment seg_med0 (
        .din  (clk_in),
        .dout (med_mid)
    );
    wire med_out;
    wire_segment seg_med1 (
        .din  (med_mid),
        .dout (med_out)
    );
    assign tap_med = med_out;

    // long path: three segments back-to-back
    wire long_mid0;
    wire_segment seg_long0 (
        .din  (clk_in),
        .dout (long_mid0)
    );
    wire long_mid1;
    wire_segment seg_long1 (
        .din  (long_mid0),
        .dout (long_mid1)
    );
    wire long_out;
    wire_segment seg_long2 (
        .din  (long_mid1),
        .dout (long_out)
    );
    assign tap_long = long_out;
endmodule
