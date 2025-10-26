`timescale 1ns/1ps
`define STEP 10
`define WIDTH 32

module lfsr_tb();

reg clk,rst_n;
wire [`WIDTH-1:0] out_data;

initial begin
    clk =0;
    rst_n =0;           //reset the LFSR when the 'rst_n' = 0
    #30 rst_n = 1;
end
always #5 clk = ~clk;   //T=10ns

initial begin
    $dumpfile("tb_wave.vcd");
    $dumpvars(0, lfsr_tb);
end


LFSR #(
    .WIDTH     	(`WIDTH  ),
    .INIT_LFSR 	(1   ))
u_LFSR(
    .clk      	(clk       ),
    .rst_n    	(rst_n     ),
    .out_data 	(out_data  )
);

initial begin
    $monitor($time,"\tout_data=%0x\n",out_data);
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

