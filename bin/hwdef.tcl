#!/usr/bin/tclsh
source bin/env.tcl

open_project $project/$project.xpr
generate_target all [get_files  $project/$project.srcs/sources_1/bd/z_turn/z_turn.bd]
write_hwdef -force ${hwdef}
exit
