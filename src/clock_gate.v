
//version1: only count the first is_error  
`define version1 1
module clock_gate #(
    parameter CYCLE_TIME = 10
)(
    input clk,
    input is_error,
    input rst_n,
    output gated_clk
);
    localparam CNT_WIDTH = $clog2(CYCLE_TIME);
    reg [CNT_WIDTH:0] cnt;
    reg is_gated;

`ifdef version1
    always @(posedge clk) begin
        if (!rst_n) begin
            cnt <= 1'b0;
            is_gated <= 1'b0;
        end else begin
            if (is_error&&(!is_gated)) begin
                is_gated <= 1'b1;
            end else if (is_gated) begin
                if (cnt < CYCLE_TIME -1) begin
                    cnt <= cnt+1;
                end else begin
                    cnt <= 1'b0;
                    is_gated <= 1'b0;
                end
            end else begin
                cnt <= 1'b0;
            end
        end
    end
`else
    always @(posedge clk) begin
        if (!rst_n) begin
            cnt <= 1'b0;
            is_gated <= 1'b0;
        end else begin
            if (is_error) begin
                is_gated <= 1'b1;
                cnt <= 1'b1;                //cnt from 1 since is_gated pulls high
            end else if (is_gated) begin
                if (cnt < CYCLE_TIME) begin
                    cnt <= cnt+1;
                end else begin
                    cnt <= 1'b0;
                    is_gated <= 1'b0;
                end
            end else begin
                cnt <= 1'b0;
            end
        end
    end    
`endif

    assign gated_clk = is_gated? 1'b0: clk;
endmodule //clock_gate
