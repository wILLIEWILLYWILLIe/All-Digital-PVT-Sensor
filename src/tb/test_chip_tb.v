`timescale 1ns/1ps
`define STEP 10

module test_chip_tb();

reg clk,rst_n;

initial begin
    clk =0;
    rst_n =0;           //reset the LFSR when the 'rst_n' = 0
    #20 rst_n = 1;
end
always #0.5 clk = ~clk;   //T=10ns

initial begin
    $dumpfile("./waves/test_chip_tb.vcd");
    $dumpvars(0, test_chip_tb);
end

// output declaration of module test_chip
wire error_root;
wire error_leaf;
wire gated_clk;
wire [32-1:0] out_buff;

test_chip u_test_chip(
    .clk             	(clk              ),
    .rst_n           	(rst_n            ),
    .tuning_bits_trc 	(8'd12  ),
    .tuning_bits     	(5'b00100      ),
    .error_root      	(error_root       ),
    .error_leaf      	(error_leaf       ),
    .gated_clk       	(gated_clk        ),
    .out_buff        	(out_buff         )
);



initial begin
    $monitor($time,"\tout_data=%0x\n",out_buff);
    doEXE(100);
    $finish;
end

task automatic doEXE(
    input integer exe_cycles
);
begin
    # (1*exe_cycles);
end
endtask //automatic
endmodule

