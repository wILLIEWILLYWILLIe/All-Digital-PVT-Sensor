set top $::env(top)

# set path
set_db init_hdl_search_path {../lib}

# input verilog design
read_hdl ../src/tunable_delay/transistor_segment.v
read_hdl ../src/tunable_delay/transistor_delay_block.v
read_hdl ../src/tunable_delay/wire_segment.v
read_hdl ../src/tunable_delay/wire_delay_block.v
read_hdl ../src/tunable_delay/delay_mux.v
read_hdl ../src/tunable_delay/tunable_delay.v

# input lib and lef
set_db library ../lib/NangateOpenCellLibrary_typical.lib
set_db lef_library ../lib/NangateOpenCellLibrary.lef

# set top design
elaborate $top
current_design $top

# read sdc file ( for timing constraints. It defines max delay, load, max capacitance and max transition of the circuit.)
read_sdc ../constrs/$top.sdc

# dont touch (!!!must befor "syn_part")
set_dont_touch [get_designs transistor_segment]
set_dont_touch [get_designs wire_segment]

# synthesis and map to target library
syn_generic
syn_map 
syn_opt

# report
# time report
report_timing > ./reports/$top\_timing.rpt
# area report
report_area > ./reports/$top\_area.rpt

# write netlist
write_hdl > ./output_src/$top\_syn.v

# write SDF for post-synthesis simulation
write_sdf > ./output_src/$top\_syn.sdf
