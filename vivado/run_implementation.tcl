# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/../"]"



open_proj $orig_proj_dir/project_1.xpr

set run_name impl_1
set cpu_count 4

reset_runs $run_name
launch_runs $run_name -jobs $cpu_count
wait_on_run $run_name

set status [get_property STATUS [get_runs $run_name]]
if {$status != "route_design Complete!"} {
  exit 1
}
exit 0
