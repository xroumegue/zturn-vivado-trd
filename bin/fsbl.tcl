#!/usr/bin/tclsh

source ../bin/env.tcl

set hwdsgn [open_hw_design $project.hdf]
generate_app -hw $hwdsgn -os standalone -proc ps7_cortexa9_0 -app zynq_fsbl -dir fsbl
