module test_chip#(
    parameter TUNING_WIDTH=8,
    parameter TUNING_WIDTH_LOW=3,
    parameter WIDTH=32
)(
    input clk,
    input rst_n,
    input [TUNING_WIDTH-1:0] tuning_bits_trc,
    input [4:0] tuning_bits,
    output error_root,
    output error_leaf,
    output gated_clk,
    output [WIDTH-1:0] out_buff
);
//---------------wire declaration---------------------------
    //to better identify root/leaf parts' signals
    wire clk_root, clk_leaf;
    wire rst_n_root, rst_n_leaf;
    assign clk_root = clk;
    //for DVM_root and DVM_leaf
    wire is_error_root,is_error_leaf;
//---------------wire declaration end---------------------------

    // to get clock leaf
    tunable_delay u_tunable_delay(
        .clk_in      	(clk_root     ),
        .tuning_bits 	(tuning_bits  ),
        .clk_out     	(clk_leaf      )
    );
    //synchronize reset signal for root and leaf
    sync_rst u_sync_rst_root (
        .clk    (clk_root),
        .rst_n  (rst_n),
        .sync_rst_n(rst_n_root)
    );
    sync_rst u_sync_rst_leaf (
        .clk    (clk_leaf),
        .rst_n  (rst_n),
        .sync_rst_n(rst_n_leaf)
    );
    //Root DVM
    DVM #(
        .TUNING_WIDTH     	(TUNING_WIDTH  ),
        .TUNING_WIDTH_LOW 	(TUNING_WIDTH_LOW  ))
    u_DVM_root(
        .clk         	(clk_root     ),
        .rst_n       	(rst_n_root   ),
        .tuning_bits 	(tuning_bits_trc  ),
        .is_error    	(is_error_root     )
    );
    //Leaf part
    clock_gate #(
        .CYCLE_TIME 	(10  )) //define the number of cycles removing the clock edge
    u_clock_gate(
        .clk       	(clk_leaf   ),
        .is_error  	(is_error_root   ),
        .rst_n     	(rst_n_leaf      ),
        .gated_clk 	(gated_clk  )
    );
    //Leaf DVM
    DVM #(
        .TUNING_WIDTH     	(TUNING_WIDTH  ),
        .TUNING_WIDTH_LOW 	(TUNING_WIDTH_LOW  ))
    u_DVM_leaf(
        .clk         	(gated_clk          ),
        .rst_n       	(rst_n_leaf        ),
        .tuning_bits 	(tuning_bits_trc  ),
        .is_error    	(is_error_leaf     )
    );
    // output declaration of module processor
    processor #(
        .WIDTH 	(WIDTH  ))
    u_processor(
        .clk      	(gated_clk       ),
        .rst_n    	(rst_n_leaf     ),
        .out_buff 	(out_buff  )
    );
    
    assign  error_root = is_error_root;
    assign  error_leaf = is_error_leaf;
endmodule //test_chip

module sync_rst(
    input clk,
    input rst_n,
    output sync_rst_n
);
    reg r1,r2;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            r1 <= 1'b0;
            r2 <= 1'b0; 
        end else begin
            r1 <= 1'b1;
            r2 <= r1;
        end
    end
    assign sync_rst_n = r2;

endmodule
