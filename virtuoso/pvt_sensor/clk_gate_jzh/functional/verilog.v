//Verilog HDL for "pvt_sensor", "clk_gate_jzh" "functional"


module clk_gate_jzh (clk, is_error,rst_n,clk_en);
	input clk;
	input is_error;
	input rst_n;
	output clk_en;

	localparam CYCLE_TIME = 8;
	localparam CNT_WIDTH = 3;
	reg [CNT_WIDTH:0] cnt;
	reg is_gated;

	always @(posedge clk) begin
	if (!rst_n) begin
	    cnt <= 1'b0;
	    is_gated <= 1'b0;
	end else begin
	    if (is_error) begin
		is_gated <= 1'b1;
		cnt <= 1'b1;                //cnt from 1 since is_gated pulls high
	    end else if (is_gated) begin
		if (cnt < CYCLE_TIME) begin
		    cnt <= cnt+1;
		end else begin
		    cnt <= 1'b0;
		    is_gated <= 1'b0;
		end
	    end else begin
		cnt <= 1'b0;
	    end
	end
	end    

	assign clk_en = ~is_gated;
endmodule
