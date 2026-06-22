open_project custom_xczu47dr_rfdc.xpr
reset_run impl_1
launch_runs impl_1 -jobs 8
wait_on_run impl_1
open_run impl_1
report_timing_summary -file timing_summary_100mhz.rpt
