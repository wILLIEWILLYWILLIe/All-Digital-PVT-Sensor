`define STEP 10

module xor_tb();

reg  in_data, in_ctrl;
wire out_data;

xorChain #(
    .LENGTH  	(8  ),
    .DRIVE_L 	(1  ))
u_xorChain(
    .in_data  	(in_data   ),
    .in_ctrl  	(in_ctrl   ),
    .out_data 	(out_data  )
);

initial begin
    $dumpfile("tb_wave.vcd");
    $dumpvars(0, xor_tb);
end

initial begin
    $monitor($time,"\tin_data=%0x,out_data=%0x\n",in_data,out_data);
    doEXE(1, 1);
    doEXE(0, 1);
    $finish;
end

task automatic doEXE(
    input t_in,
    input t_ctrl
);
begin
    in_data = t_in;
    in_ctrl = t_ctrl;
    #`STEP;
end
endtask //automatic
endmodule

