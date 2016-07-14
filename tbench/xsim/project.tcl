set origin_dir "."

if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

set orig_proj_dir "[file normalize "$origin_dir/project_1"]"

create_project -f project_1 ./project_1

set proj_dir [get_property directory [current_project]]

set obj [get_projects project_1]
set_property "simulator_language" "Mixed" $obj

if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/../../src/uartdpi.sv"]"\
]
add_files -norecurse -fileset $obj $files

set obj [get_filesets sources_1]
set_property "top" "uartdpi" $obj

if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

set obj [get_filesets sim_1]
set files [list \
 "[file normalize "$origin_dir/../tb_uartdpi.sv"]"\
]
add_files -norecurse -fileset $obj $files

set obj [get_filesets sim_1]
set_property "top" "tb_uartdpi" $obj
set_property -name "xsim.elaborate.xelab.more_options" -value "-sv_lib dpi -sv_root ../../dpi" -objects $obj

exec xsc ../../src/uartdpi.c --work project_1/project_1.sim/dpi --additional_option -lutil --additional_option -Wall -C gcc

launch_simulation

run -all
