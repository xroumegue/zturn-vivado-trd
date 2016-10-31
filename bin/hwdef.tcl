open_project zturn-trd/zturn-trd.xpr
generate_target all [get_files  zturn-trd/zturn-trd.srcs/sources_1/bd/z_turn/z_turn.bd]
write_hwdef -force zturn.hdf
exit
