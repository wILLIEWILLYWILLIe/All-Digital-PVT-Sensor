## 初始化
请先项目路径下执行 make prepare_dirs 生成必要的文件夹

## 文件构成：
waves：             储存功能仿真波形
synthesis：         一切综合都在这个文件夹
synthesis/scripts:  配合synthesis/Makefile实现一键仿真
synthesis/output_src:   综合后的输出文件
synthesis/reports:  综合后的时序与面积报告
synthesis/log_cmd:  genus日志
build:              存放功能仿真执行文件
constrs:            时序约束
lib:                工艺库
sim:xcelium:        运行的地方

## 命名规则：
- 要仿真的顶层模块名，需与顶层文件名一致
- testbench命名为，`顶层模块名_tb`
- 源文件放在`src`， 仿真文件放在`src/tb`
| eg:
| 顶层文件名 ： processor.v
| 顶层模块名 ： processor
| testbench ： processor_tb
| tb_文件   :  processor_tb.v