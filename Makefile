.PHONY: init
init:
	mkdir -p waves build sim
	mkdir -p synthesis/log_cmd synthesis/reports

#-------------------------------------------------------------------------------------
VSRC:=src
LIB_DIR:=lib
BUILD_DIR:= build

TOP?=processor
TB:=$(TOP)_tb
TB_DIR:=$(VSRC)/tb

sim_xor: $(VSRC)/processor.v $(VSRC)/xor_tb.v
	iverilog -o xor_tb $(VSRC)/processor.v $(VSRC)/xor_tb.v ./lib/*.v -s xor_tb
	./xor_tb

sim_lfsr: $(VSRC)/LFSR.v $(VSRC)/lfsr_tb.v
	iverilog -o lfsr_tb $(VSRC)/LFSR.v $(VSRC)/lfsr_tb.v ./lib/*.v -s lfsr_tb
	./lfsr_tb

# tb文件中写的dumpfile的路径，是以cmd（也就是执行这条makefile文件时命令行所处位置）为基准的
sim_processor: $(VSRC)/processor.v $(VSRC)/processor_tb.v
	iverilog -o ./build/processor_tb $(VSRC)/processor.v $(VSRC)/processor_tb.v $(VSRC)/stage_unit.v $(VSRC)/LFSR.v ./lib/*.v -s processor_tb
	./build/processor_tb

# need to specify top module's name: 
# eg:make func_sim TOP=processor
func_sim: $(VSRC)/$(TOP).v $(TB_DIR)/$(TB).v
	iverilog -o $(BUILD_DIR)/$(TB) $(TB_DIR)/$(TB).v $(VSRC)/*.v $(LIB_DIR)/*.v -s $(TB)
	./$(BUILD_DIR)/$(TB)

func_sim2: $(VSRC)/$(TOP).v $(TB_DIR)/$(TB).v
	iverilog -o $(BUILD_DIR)/$(TB) $(TB_DIR)/$(TB).v $(VSRC)/*.v $(VSRC)/tunable_delay/*.v $(LIB_DIR)/*.v -s $(TB)
	./$(BUILD_DIR)/$(TB)