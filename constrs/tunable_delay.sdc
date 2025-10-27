create_clock -name CLK_ROOT -period 10.0 [get_ports clk_in]

set_input_delay  0.5 -clock CLK_ROOT [get_ports tuning_bits*]
set_output_delay 0.5 -clock CLK_ROOT [get_ports clk_out]

set_max_fanout 8  [current_design]
set_max_transition 0.10 [current_design]
