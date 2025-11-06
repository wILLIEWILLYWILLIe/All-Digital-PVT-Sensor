`timescale 1ns/1ps

module wire_segment (
    input  wire din,
    output wire dout
);
    wire w_mid_1;
    wire w_mid_2;
    wire w_mid_3;
    wire w_mid_4;
    wire w_mid_before_out;

    // repeater in
    BUF_X1 u_buf_in  (.A(din),   .Z(w_mid_1));
    // repeater out - 1 stage
    // BUF_X1 u_buf_out (.A(w_mid_1), .Z(dout));

    // repeater out - 2 stages
    // BUF_X1 u_buf_out_1 (.A(w_mid_1), .Z(w_mid_before_out));
    // BUF_X1 u_buf_out_2 (.A(w_mid_before_out), .Z(dout));

    // repeater out - 3 stages
    BUF_X1 u_buf_out_1 (.A(w_mid_1), .Z(w_mid_2));
    BUF_X1 u_buf_out_2 (.A(w_mid_2), .Z(w_mid_before_out));
    BUF_X1 u_buf_out_3 (.A(w_mid_before_out), .Z(dout));

endmodule
