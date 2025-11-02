module TRC #(
    parameter TUNING_WIDTH=8,
    parameter TUNING_WIDTH_LOW=3
)(
    input data_in,
    input [TUNING_WIDTH-1:0] tuning_bits,
    output data_out
);
    localparam BIG_PART_NUM = 2**(TUNING_WIDTH-TUNING_WIDTH_LOW) - 1;
    localparam SMALL_PART_NUM = 2**TUNING_WIDTH_LOW;
    //8*31 + 7
    wire [BIG_PART_NUM:0] inv_chain_out;
    wire [SMALL_PART_NUM:0] inv_chain_small_out;
    wire mux1_out, mux2_out;

    assign inv_chain_out[0] = data_in;
    genvar i;
    generate
    for (i = 0; i< BIG_PART_NUM; i=i+1) begin: TRC_part_big
        invChain #(.LENGTH(SMALL_PART_NUM  ), .DRIVER_L(1  )) u_inv_chain8(
            .in_data  	(inv_chain_out[i]   ),
            .out_data 	(inv_chain_out[i+1]  )
        );
    end
    endgenerate

    assign inv_chain_small_out[0] = mux1_out;
    generate
    for (i = 0; i<SMALL_PART_NUM; i=i+1) begin: TRC_part_small
        invChain #(.LENGTH(1  ), .DRIVER_L(1  )) u_inv_chain1(
            .in_data  	(inv_chain_small_out[i]   ),
            .out_data 	(inv_chain_small_out[i+1]  )
        );
    end
    endgenerate

    assign mux1_out = inv_chain_out[tuning_bits[TUNING_WIDTH-1:TUNING_WIDTH_LOW]]; 
    assign mux2_out = inv_chain_small_out[tuning_bits[TUNING_WIDTH_LOW-1:0]+1];

    assign data_out = mux2_out;
endmodule //TRC
