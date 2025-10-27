`timescale 1ns/1ps

module transistor_delay_block (
    input  wire        clk_in,
    output wire [15:1]  tap
);

    wire tap0;
    wire tap1;
    wire tap2;
    wire tap3;
    wire tap4;
    wire tap5;
    wire tap6;
    wire tap7;
    wire tap8;
    wire tap9;
    wire tap10;
    wire tap11;
    wire tap12;
    wire tap13;
    wire tap14;
    wire tap15;

    assign tap0 = clk_in;

    transistor_segment s0  (.din(tap0),  .dout(tap1));
    transistor_segment s1  (.din(tap1),  .dout(tap2));
    transistor_segment s2  (.din(tap2),  .dout(tap3));
    transistor_segment s3  (.din(tap3),  .dout(tap4));
    transistor_segment s4  (.din(tap4),  .dout(tap5));
    transistor_segment s5  (.din(tap5),  .dout(tap6));
    transistor_segment s6  (.din(tap6),  .dout(tap7));
    transistor_segment s7  (.din(tap7),  .dout(tap8));
    transistor_segment s8  (.din(tap8),  .dout(tap9));
    transistor_segment s9  (.din(tap9),  .dout(tap10));
    transistor_segment s10 (.din(tap10), .dout(tap11));
    transistor_segment s11 (.din(tap11), .dout(tap12));
    transistor_segment s12 (.din(tap12), .dout(tap13));
    transistor_segment s13 (.din(tap13), .dout(tap14));
    transistor_segment s14 (.din(tap14), .dout(tap15));

    assign tap[1]  = tap1;
    assign tap[2]  = tap2;
    assign tap[3]  = tap3;
    assign tap[4]  = tap4;
    assign tap[5]  = tap5;
    assign tap[6]  = tap6;
    assign tap[7]  = tap7;
    assign tap[8]  = tap8;
    assign tap[9]  = tap9;
    assign tap[10] = tap10;
    assign tap[11] = tap11;
    assign tap[12] = tap12;
    assign tap[13] = tap13;
    assign tap[14] = tap14;
    assign tap[15] = tap15;
endmodule
