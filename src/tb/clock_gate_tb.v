`timescale 1ns/1ps
`define STEP 10
`define WIDTH 32

module clock_gate_tb();

reg clk,rst_n;
reg is_error;
wire gated_clk;
//clock and rst_n initialization
initial begin
    clk =0;
    rst_n =0;           
    #50 rst_n = 1;
end
always #5 clk = ~clk;   //T=10ns

initial begin
    $dumpfile("./waves/clock_gate_tb.vcd");
    $dumpvars();
end

// output declaration of module clock_gate
clock_gate #(
    .CYCLE_TIME 	(8  ))
u_clock_gate(
    .clk       	(clk        ),
    .is_error     	(is_error      ),
    .rst_n     	(rst_n      ),
    .gated_clk 	(gated_clk  )
);

initial begin
    is_error = 0;
    #55;
    doEXE(10);
    //is_error = 1 keeps for 2 cycles
    is_error <= 1;
    doEXE(2);
    //
    is_error <= 0;
    doEXE(1);
    is_error <= 1;
    doEXE(1);
    is_error <= 0;   
    doEXE(3);
    is_error <= 1;
    doEXE(1);
    is_error <= 0; 
    doEXE(8);
    //8cycles
    is_error <= 1;
    doEXE(1);
    is_error <= 0;
end

initial begin
    $monitor($time,"\tis_error=%0d, \n",is_error);
    doEXE(1000);
    $finish;
end

task automatic doEXE(
    input integer exe_cycles
);
begin
    # (10*exe_cycles);
end
endtask //automatic
endmodule

