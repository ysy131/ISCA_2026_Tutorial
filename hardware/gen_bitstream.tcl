open_project custom_xczu47dr_rfdc.xpr

# Just regenerate bitstream (implementation already done)
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1

puts "Bitstream generation completed"

close_project
