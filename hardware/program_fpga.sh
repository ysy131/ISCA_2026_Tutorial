#!/bin/bash
# 烧录比特流到 FPGA
set -e

BITSTREAM="/home/syyao/newproject/custom_xczu47dr_rfdc/custom_xczu47dr_rfdc.runs/impl_1/TopCustomXczu47dr.bit"
PROGRAM_TCL="/home/syyao/newproject/custom_xczu47dr_rfdc/build_logs/program_fpga_latest.tcl"

echo "正在烧录比特流到 FPGA..."
echo "比特流文件: $BITSTREAM"

cat > "$PROGRAM_TCL" <<EOF
open_hw_manager
connect_hw_server
open_hw_target
current_hw_device [get_hw_devices xczu47dr_0]
set_property PROGRAM.FILE {$BITSTREAM} [get_hw_devices xczu47dr_0]
program_hw_devices [get_hw_devices xczu47dr_0]
close_hw_target
disconnect_hw_server
close_hw_manager
EOF

# 使用 Vivado Hardware Manager 烧录
vivado -mode batch -source "$PROGRAM_TCL"

echo "烧录完成！"
