`timescale 1ns/1ps

module transistor_segment (
    input  wire din,
    output wire dout
);
    wire mid_1;
    wire mid_2;
    wire mid_3;
    wire mid_4;
    wire mid_5;
    wire mid_6;
    wire mid_7;

    INV_X1 u_inv0 (.A(din), .ZN(mid_1));
    INV_X1 u_inv1 (.A(mid_1), .ZN(mid_2));
    INV_X1 u_inv2 (.A(mid_2), .ZN(mid_3));
    INV_X1 u_inv3 (.A(mid_3), .ZN(mid_4));
    INV_X1 u_inv4 (.A(mid_4), .ZN(mid_5));
    // INV_X1 u_inv5 (.A(mid_5), .ZN(mid_6));
    INV_X1 u_inv7 (.A(mid_5), .ZN(dout));

    // INV_X1 u_inv6 (.A(mid_6), .ZN(mid_7));
    // INV_X1 u_inv7 (.A(mid_7), .ZN(dout));
endmodule

