SYN_HOME := $(shell pwd)
SCRIPTS_DIR := "$(SYN_HOME)/scripts"
LOG_DIR := "$(SYN_HOME)/log_cmd"

syn:
	@export top=$(TOP);\
	@export keep_hier=$(keep_hier);\
	genus -f $(SCRIPTS_DIR)/$(TOP).tcl -log $(LOG_DIR)/$(TOP)