set top $::env(top)
set keep_hier 0
if {[info exists ::env(keep_hier)]} {
    set keep_hier $::env(keep_hier)
}

# set path
set_db init_hdl_search_path {../lib}

# input verilog design
#read_hdl ../src/$top.v ../src/LFSR.v ../src/stage_unit.v
read_hdl [glob ../src/*.v]
read_hdl [glob ../src/tunable_delay/*.v]

# input lib and lef
set_db library ../lib/NangateOpenCellLibrary_typical.lib
set_db lef_library ../lib/NangateOpenCellLibrary.lef

# set top design
elaborate $top
current_design $top

# read sdc file ( for timing constraints. It defines max delay, load, max capacitance and max transition of the circuit.)
read_sdc ../constrs/test_chip.sdc

# dont touch (!!!must befor "syn_part")
set Chains [get_db insts *drv*]
puts "Found Chains: \[$Chains\]"
set_db $Chains .dont_touch true 
set Tunable_delay [get_db hinsts u_tunable_delay/TDB/s* hinsts u_tunable_delay/WDB/seg*]
puts "Found Tunable_delay: \[$Tunable_delay\]"
set_db $Tunable_delay .dont_touch true 

# set_db auto_ungroup none
if {$keep_hier==1} {
set top_insts [get_db hinsts u_tunable_delay u_DVM_root u_DVM_leaf u_clock_gate u_processor]
puts "Found: \[$top_insts\]"
set_db $top_insts .ungroup_ok false    
}

# set_case_analysis 1 [get_ports tuning_bits_trc[0]]
# set_case_analysis 1 [get_ports tuning_bits_trc[1]]
# set_case_analysis 1 [get_ports tuning_bits_trc[2]]
# set_case_analysis 1 [get_ports tuning_bits_trc[3]]
# set_case_analysis 1 [get_ports tuning_bits_trc[4]]
# set_case_analysis 0 [get_ports tuning_bits_trc[5]]
# set_case_analysis 0 [get_ports tuning_bits_trc[6]]
# set_case_analysis 0 [get_ports tuning_bits_trc[7]]

# set_case_analysis 0 [get_ports tuning_bits[0]]
# set_case_analysis 0 [get_ports tuning_bits[1]]
# set_case_analysis 1 [get_ports tuning_bits[2]]
# set_case_analysis 0 [get_ports tuning_bits[3]]
# set_case_analysis 0 [get_ports tuning_bits[4]]

# synthesis and map to target library
# if we don not set the "ungroup attribute to false", the hierarchy will miss after syn_generic
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

# write sdf
write_sdf > ./output_src/sdf_files/$top\_syn.sdf