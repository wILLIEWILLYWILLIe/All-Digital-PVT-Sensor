`timescale 1ns/1ps
`define SDF_PATH "./synthesis/output_src/tunable_delay_syn.sdf"

module tb_tunable_delay;

    // ---------------------------------
    // tb signals
    // ---------------------------------
    reg         clk_in;
    reg  [4:0]  tuning_bits;
    wire        clk_out;

    // Calculate clk_in / clk_out positive edge time
    real t_last_in;
    real t_last_out;
    real skew_ps; // 

    // ---------------------------------
    // DUT
    // ---------------------------------
    tunable_delay DUT (
        .clk_in      (clk_in),
        .tuning_bits (tuning_bits),
        .clk_out     (clk_out)
    );

    // ---------------------------------
    // SDF back-annotation
    // ---------------------------------
    initial begin
        $display("[%0t] Applying SDF from %s", $time, `SDF_PATH);
        $sdf_annotate(`SDF_PATH, DUT);
    end

    // ---------------------------------
    // Clock generator: 100MHz = 10ns period
    // ---------------------------------
    // initial begin
    //     clk_in = 1'b0;
    //     forever #5 clk_in = ~clk_in; // 5ns high / 5ns low
    // end

    // =======================================
    // --------- Single pulse generator ------
    // =======================================
    task automatic send_pulse(input real high_ns);
    begin
        clk_in = 1'b0;  #(5.0);       
        clk_in = 1'b1;  #(high_ns);   
        clk_in = 1'b0;  #(20.0);     
    end
    endtask
    initial begin
        tuning_bits = 5'b00000; #(20);

        tuning_bits = 5'b00001; $display("[%0t] select cand0", $realtime);
        send_pulse(1.0);   

        tuning_bits = 5'b00010; $display("[%0t] select t_tap[4]", $realtime);
        send_pulse(1.0);

        tuning_bits = 5'b00100; $display("[%0t] select t_tap[8/12]", $realtime);
        send_pulse(1.0);

        tuning_bits = 5'b01000; $display("[%0t] select w_tap_b", $realtime);
        send_pulse(1.0);

        tuning_bits = 5'b10000; $display("[%0t] select w_tap_c", $realtime);
        send_pulse(1.0);

        $finish;
    end
    // --------- Signle pulse generator ------



    // ---------------------------------
    // waveform dump (for SimVision / gtkwave)
    // ---------------------------------
    initial begin
        $dumpfile("tunable_delay.vcd");
        $dumpvars(0, tb_tunable_delay);
    end

    // ---------------------------------
    // Stimulus: scan tuning_bits
    // ---------------------------------
    initial begin
        // Given all 0 
        tuning_bits = 5'b00000;
        #20;

        // 1) 直接 clk_in
        tuning_bits = 5'b00001; // sel[0]
        $display("[%0t ns] >>> select = clk_in       sel=%b", $realtime, tuning_bits);
        #50;

        // 2) transistor mid tap (t_tap[4])
        tuning_bits = 5'b00010; // sel[1]
        $display("[%0t ns] >>> select = t_tap[4]     sel=%b", $realtime, tuning_bits);
        #50;

        // 3) transistor long tap (t_tap[12])
        tuning_bits = 5'b00100; // sel[2]
        $display("[%0t ns] >>> select = t_tap[12]    sel=%b", $realtime, tuning_bits);
        #50;

        // 4) wire medium (w_tap_b)
        tuning_bits = 5'b01000; // sel[3]
        $display("[%0t ns] >>> select = w_tap_b      sel=%b", $realtime, tuning_bits);
        #50;

        // 5) wire long (w_tap_c)
        tuning_bits = 5'b10000; // sel[4]
        $display("[%0t ns] >>> select = w_tap_c      sel=%b", $realtime, tuning_bits);
        #50;

        $finish;
    end

    // ---------------------------------
    // Timestamp monitor 1:
    //   Everytime clk_in rise, record the time
    // ---------------------------------
    always @(posedge clk_in) begin
        t_last_in = $realtime;  // $realtime is  real，with the unit of testbench timescale (1ns/1ps)
        $display("[%0t ns] clk_in ↑   sel=%b", $realtime, tuning_bits);
    end

    // ---------------------------------
    // Timestamp monitor 2:
    //   Everytime clk_out rise，calculate clk_out is how much slower than clk_in 
    //   skew_ps = (t_last_out - t_last_in) * 1e3
    //   t_last_out/t_last_in (ns), *1000 -> ps
    // ---------------------------------
    always @(posedge clk_out) begin
        t_last_out = $realtime;
        skew_ps = (t_last_out - t_last_in) * 1e3; // 1ns = 1000ps
        $display("[%0t ns] clk_out ↑  sel=%b  SKEW = %.2f ps",
                 $realtime, tuning_bits, skew_ps);
    end

endmodule
