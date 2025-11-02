set top $::env(top)

# set path
set_db init_hdl_search_path {../lib}

# input verilog design
#read_hdl ../src/$top.v ../src/LFSR.v ../src/stage_unit.v
read_hdl [glob ../src/*.v]

# input lib and lef
set_db library ../lib/NangateOpenCellLibrary_typical.lib
set_db lef_library ../lib/NangateOpenCellLibrary.lef

# set top design
elaborate $top
current_design $top

# read sdc file ( for timing constraints. It defines max delay, load, max capacitance and max transition of the circuit.)
read_sdc ../constrs/inv.sdc

# dont touch (!!!must befor "syn_part")
set Chains [get_db insts *drv*]
puts "Found NAND: \[$Chains\]"
set_db $Chains .dont_touch true 

set_case_analysis 0 [get_ports tuning_bits[0]]
set_case_analysis 0 [get_ports tuning_bits[1]]
set_case_analysis 1 [get_ports tuning_bits[2]]
set_case_analysis 1 [get_ports tuning_bits[3]]
set_case_analysis 1 [get_ports tuning_bits[4]]
set_case_analysis 0 [get_ports tuning_bits[5]]
set_case_analysis 0 [get_ports tuning_bits[6]]
set_case_analysis 0 [get_ports tuning_bits[7]]


# synthesis and map to target library
syn_generic
syn_map
syn_opt

# report
# time report
report_timing -from data_in -to data_out -max_paths 5 > ./reports/$top\_timing.rpt
# area report
report_area > ./reports/$top\_area.rpt

# write netlist
write_hdl > ./output_src/$top\_syn.v