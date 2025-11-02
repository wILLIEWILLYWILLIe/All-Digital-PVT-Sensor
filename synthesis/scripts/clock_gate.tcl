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
read_sdc ../constrs/processor.sdc

# dont touch (!!!must befor "syn_part")
set Chains [get_db insts *drv*]
puts "Found NAND: \[$Chains\]"
set_db $Chains .dont_touch true 


# synthesis and map to target library
syn_generic
syn_map
syn_opt

# report
# time report
report_timing  > ./reports/$top\_timing.rpt
# area report
report_area > ./reports/$top\_area.rpt

# write netlist
write_hdl > ./output_src/$top\_syn.v