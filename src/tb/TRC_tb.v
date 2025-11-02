`timescale 1ns/1ps
`define STEP 10
`define WIDTH 32

module TRC_tb();

reg clk,rst_n;
wire data_out;

initial begin
    clk =0;
    rst_n =0;           //reset the LFSR when the 'rst_n' = 0
    #30 rst_n = 1;
end
always #5 clk = ~clk;   //T=10ns

initial begin
    $dumpfile("./waves/TRC_tb.vcd");
    $dumpvars();
end

TRC #(.TUNING_WIDTH(8), .TUNING_WIDTH_LOW(3)) u_trc(
    .data_in(1'b1),
    .tuning_bits(8'd13),
    .data_out(data_out)
);


initial begin
    $monitor($time,"\tis_error=%0d\n",data_out);
    doEXE(10);
end

task automatic doEXE(
    input exe_cycles
);
begin
    #35;
    # 10000;
    $finish;
end
endtask //automatic
endmodule

