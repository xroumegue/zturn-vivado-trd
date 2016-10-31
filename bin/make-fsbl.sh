#! /bin/bash

mkdir -p "$FSBL" && cd "$FSBL" && cp ../"$HWDEF" .
hsi -mode batch -source ../bin/fsbl.tcl 
cd -
