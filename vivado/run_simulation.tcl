# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/../"]"



open_proj $orig_proj_dir/project_1.xpr


set sim_fileset sim_1

launch_simulation -simset [get_filesets $sim_fileset]
close_sim
cd ..
# Look for assertion failures in the simulation log
set log_file [glob *project_1.sim/$sim_fileset/behav/xsim/simulate.log]
set fp [open $log_file]
set file_data [read $fp]
exit [regex "Failure:" $file_data]
