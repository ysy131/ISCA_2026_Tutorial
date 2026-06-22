# TCL script to configure the ARTERY + DDR + Network project.
# Data path:
#   UDP writes s21/IQ data to DDR
#   DataMover reads DDR data into ARTERY
#   ARTERY result and DDR-to-result latency are returned by UDP

# Open the project
open_project /home/syyao/newproject/custom_xczu47dr_rfdc/custom_xczu47dr_rfdc.xpr

# Add ARTERY source file (if not already added)
set artery_file [get_files -quiet ARTERYTop.v]
if {$artery_file == ""} {
    add_files -norecurse /home/syyao/newproject/custom_xczu47dr_rfdc/custom_xczu47dr_rfdc.srcs/sources_1/imports/hardware/vivado/src/ARTERYTop.v
    puts "Added ARTERYTop.v to project"
} else {
    puts "ARTERYTop.v already in project"
}

# Add DDR-to-ARTERY UDP feedback bridge
set bridge_file [get_files -quiet artery_ddr_udp_feedback.v]
if {$bridge_file == ""} {
    add_files -norecurse /home/syyao/newproject/custom_xczu47dr_rfdc/custom_xczu47dr_rfdc.srcs/sources_1/imports/hardware/vivado/src/artery_ddr_udp_feedback.v
    puts "Added artery_ddr_udp_feedback.v to project"
} else {
    puts "artery_ddr_udp_feedback.v already in project"
}

# Add 8-lane input packer used by the DDR-to-ARTERY bridge
set packer_file [get_files -quiet axis_128_to_256_packer.v]
if {$packer_file == ""} {
    add_files -norecurse /home/syyao/newproject/custom_xczu47dr_rfdc/custom_xczu47dr_rfdc.srcs/sources_1/imports/hardware/vivado/src/axis_128_to_256_packer.v
    puts "Added axis_128_to_256_packer.v to project"
} else {
    puts "axis_128_to_256_packer.v already in project"
}

# Use the full board top so DDR4, DataMover, RFDC clocks and 10G UDP are present.
set_property top TopCustomXczu47dr [current_fileset]
puts "Set TopCustomXczu47dr as top module"

# Update compile order
update_compile_order -fileset sources_1
puts "Updated compile order"

# Close the project after updating compile order. Vivado writes project metadata
# for file additions and top changes when the project is closed.
close_project

puts ""
puts "=========================================="
puts "Project configuration completed!"
puts "=========================================="
puts "Top module: TopCustomXczu47dr"
puts "ARTERY core: ARTERYCore (from ARTERYTop.v)"
puts "Network: udp_10G"
puts "DDR bridge: artery_ddr_udp_feedback"
puts ""
puts "Next steps:"
puts "1. Run synthesis: launch_runs synth_1"
puts "2. Run implementation: launch_runs impl_1"
puts "3. Generate bitstream: launch_runs impl_1 -to_step write_bitstream"
puts "=========================================="
