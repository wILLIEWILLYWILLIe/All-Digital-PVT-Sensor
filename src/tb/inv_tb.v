`define STEP 10
`define WIDTH 32

module tb();

reg [`WIDTH-1:0] in_data;
wire out_data;

// invChain u_invChain (8,1)(
//     .in_data  	(in_data   ),
//     .out_data 	(out_data  )
// );


initial begin
    $dumpfile("tb_wave.vcd");
    $dumpvars(0, tb);
end

initial begin
    $monitor($time,"\tin_data=%0x,out_data=%0x\n",in_data,out_data);
    doEXE(32'h1);
    doEXE(32'h0);
    $finish;
end

task automatic doEXE(
    input [`WIDTH-1:0] t_in
);
begin
    in_data = t_in;
    #`STEP;
end
endtask //automatic
endmodule

