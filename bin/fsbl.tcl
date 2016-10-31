#!/usr/bin/tclsh
#global env
#variable vivado $::env(VIVADO)

set hwdsgn [open_hw_design zturn.hdf]
generate_app -hw $hwdsgn -os standalone -proc ps7_cortexa9_0 -app zynq_fsbl -dir fsbl
