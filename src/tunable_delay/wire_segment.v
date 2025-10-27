`timescale 1ns/1ps

module wire_segment (
    input  wire din,
    output wire dout
);
    wire w_mid;

    // repeater in
    BUF_X1 u_buf_in  (.A(din),   .Z(w_mid));
    // repeater out
    BUF_X1 u_buf_out (.A(w_mid), .Z(dout));
endmodule
