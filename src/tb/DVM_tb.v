`timescale 1ns/1ps
`define STEP 10
`define WIDTH 32

module DVM_tb();

reg clk,rst_n;
wire is_error;

initial begin
    clk =0;
    rst_n =0;           
    #50 rst_n = 1;
end
always #5 clk = ~clk;   //T=10ns

initial begin
    $dumpfile("./waves/DVM_tb.vcd");
    $dumpvars();
end

DVM u_DVM(
    .clk   	(clk    ),
    .rst_n 	(rst_n  ),
    .tuning_bits (8'd12),
    .is_error 	(is_error  )
);



initial begin
    $monitor($time,"\tis_error=%0d\n",is_error);
    doEXE(10);
end

task automatic doEXE(
    input exe_cycles
);
begin
    #55;
    # 10000;
    $finish;
end
endtask //automatic
endmodule

