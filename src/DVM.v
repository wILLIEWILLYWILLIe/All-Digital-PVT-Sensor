module DVM #(
    parameter TUNING_WIDTH = 8,
    parameter TUNING_WIDTH_LOW = 3
)(
    input clk,
    input rst_n,
    input [TUNING_WIDTH-1:0] tuning_bits,
    output reg is_error
);
    //Toggle FF
    reg T_FF;
    wire D_out,D_out_n;

    always @(posedge clk) begin
        if (!rst_n) begin
            T_FF <= 1'b0;
        end else begin
            T_FF <= D_out_n;
        end
    end
    assign D_out = T_FF;
    assign D_out_n = ~D_out;

    //Instantiate the TRC modules for is_error detection
    wire data_out0,data_out1;
    reg trc_in1,trc_in0;
    reg trc_out1,trc_out0;

    always @(posedge clk) begin
        trc_in0 <= D_out;
        trc_in1 <= D_out_n;
        trc_out0 <= data_out0;
        trc_out1 <= data_out1;
    end

    //TRC
    TRC #(.TUNING_WIDTH(TUNING_WIDTH), .TUNING_WIDTH_LOW(TUNING_WIDTH_LOW)) u_TRC_0(
        .data_in    (trc_in0      ),
        .tuning_bits(tuning_bits),
        .data_out   (data_out0      )
    );
    TRC #(.TUNING_WIDTH(TUNING_WIDTH), .TUNING_WIDTH_LOW(TUNING_WIDTH_LOW)) u_TRC_1(
        .data_in    (trc_in1      ),
        .tuning_bits(tuning_bits),
        .data_out   (data_out1      )
    );

    //checker
    reg D_out_synced1,D_out_synced2;
    wire checker_out;

    always @(posedge clk) begin
        D_out_synced1 <= D_out_n;
        D_out_synced2 <= D_out_synced1;
    end

    checker u_checker(
        .data_in1(trc_out1),
        .data_in0(trc_out0),
        .ref_in1(D_out_synced2),
        .last_bit(tuning_bits[0]),
        .is_error(checker_out)
    );

    always @(posedge clk) begin
        if (!rst_n) begin
            is_error <= 1'b0;
        end else begin
            is_error <= checker_out;
        end
    end
endmodule //DVM

module checker(
    input data_in1,
    input data_in0,
    input ref_in1,
    input last_bit,
    output is_error
);
    wire ref_even_in0, ref_even_in1;
    wire is_even;
    wire is_error0, is_error1;

    assign is_even = last_bit;
    assign ref_even_in1 = ref_in1;          //by passing 2 regs(2cycles) d_n_now equals to d_n_2cycles_before
    assign ref_even_in0 = ~ref_in1;

    assign is_error1 = is_even? (ref_even_in1^data_in1): (ref_even_in1~^data_in1);
    assign is_error0 = is_even? (ref_even_in0^data_in0): (ref_even_in0~^data_in0);

    assign is_error = is_error0|is_error1;
    
endmodule //checker

