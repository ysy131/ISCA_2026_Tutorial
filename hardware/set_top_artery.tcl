open_project custom_xczu47dr_rfdc.xpr

set bridge_file [get_files -quiet artery_ddr_udp_feedback.v]
if {$bridge_file == ""} {
    add_files -norecurse /home/syyao/newproject/custom_xczu47dr_rfdc/custom_xczu47dr_rfdc.srcs/sources_1/imports/hardware/vivado/src/artery_ddr_udp_feedback.v
}

set packer_file [get_files -quiet axis_128_to_256_packer.v]
if {$packer_file == ""} {
    add_files -norecurse /home/syyao/newproject/custom_xczu47dr_rfdc/custom_xczu47dr_rfdc.srcs/sources_1/imports/hardware/vivado/src/axis_128_to_256_packer.v
}

# Use the full board top. The former artery_network_top bypasses DDR.
set_property top TopCustomXczu47dr [current_fileset]

# Update compile order
update_compile_order -fileset sources_1

close_project
