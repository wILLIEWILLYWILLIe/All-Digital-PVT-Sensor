`timescale 1ns/1ps

module transistor_segment (
    input  wire din,
    output wire dout
);
    wire mid;

    INV_X1 u_inv0 (.A(din), .ZN(mid));
    INV_X1 u_inv1 (.A(mid), .ZN(dout));
endmodule
