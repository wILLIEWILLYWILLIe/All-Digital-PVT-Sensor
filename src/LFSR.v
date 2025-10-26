module LFSR #(
    parameter WIDTH = 32,
    parameter INIT_LFSR = 32'b1
) (
    input clk,
    input rst_n,
    output [WIDTH-1:0] out_data
);
    //a common primitive polynomia: x^32 + x^22 + x^2 + x + 1
    reg [WIDTH-1:0] shift_regs;
    wire new_n;

    always @(posedge clk) begin
        if (~rst_n) begin
            shift_regs <= INIT_LFSR;
        end else begin
            shift_regs <= {new_n, shift_regs[WIDTH-1:1]};
        end
    end
    assign new_n = shift_regs[31]^shift_regs[21]^shift_regs[1]^shift_regs[0]; //map to: x^32 + x^22 + x^2 + x + 1
    assign out_data = shift_regs;
endmodule