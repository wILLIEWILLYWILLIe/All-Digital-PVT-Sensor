module processor #(parameter WIDTH = 32)(
    input clk,
    input rst_n,
    output [WIDTH-1:0] out_buff
);

    // output declaration of module LFSR
    wire [WIDTH-1:0] in_data1,in_data2;
    // stage 1
    wire [WIDTH-1:0] st1_pipeReg_in_0,st1_pipeReg_in_1;
    reg  [WIDTH-1:0] st1_pipeReg_out_0,st1_pipeReg_out_1;
    // stage 2
    wire [WIDTH-1:0] st2_pipeReg_in_0,st2_pipeReg_in_1;
    reg  [WIDTH-1:0] st2_pipeReg_out_0,st2_pipeReg_out_1;
    // stage 3
    wire [WIDTH-1:0] st3_pipeReg_in_0;
    reg  [WIDTH-1:0] result;

//----------------------------------------------------------------
    LFSR #(.WIDTH(WIDTH), .INIT_LFSR(1 )) u_LFSR_0(
        .clk      	(clk       ),
        .rst_n    	(rst_n     ),
        .out_data 	(in_data1  )
    );
    LFSR #(.WIDTH(WIDTH), .INIT_LFSR(3 )) u_LFSR_1(
        .clk      	(clk       ),
        .rst_n    	(rst_n     ),
        .out_data 	(in_data2  )
    );


    always @(posedge clk) begin
        //stage1
        st1_pipeReg_out_0 <= st1_pipeReg_in_0;
        st1_pipeReg_out_1 <= st1_pipeReg_in_1;
        //stage2
        st2_pipeReg_out_0 <= st2_pipeReg_in_0;
        st2_pipeReg_out_1 <= st2_pipeReg_in_1;
        //stage3
        result <= st3_pipeReg_in_0;
    end
    //propagate in_data2:
    assign st1_pipeReg_in_1 = in_data2;
    assign st2_pipeReg_in_1 = st1_pipeReg_out_1;

    stageUnit #(.WIDTH 	(WIDTH  )) u_stageUnit_0(
        .in_data1 	(in_data1  ),
        .in_data2 	(in_data2  ),
        .out_data 	(st1_pipeReg_in_0  )
    );
    stageUnit #(.WIDTH 	(WIDTH  )) u_stageUnit_1(
        .in_data1 	(st1_pipeReg_out_0  ),
        .in_data2 	(st1_pipeReg_out_1  ),
        .out_data 	(st2_pipeReg_in_0  )
    );
    stageUnit #(.WIDTH 	(WIDTH  )) u_stageUnit_2(
        .in_data1 	(st2_pipeReg_out_0  ),
        .in_data2 	(st2_pipeReg_out_1  ),
        .out_data 	(st3_pipeReg_in_0  )
    );
    
    assign out_buff = result;
endmodule