#! /bin/bash

DIR=$1
HWDEF=../zturn.hdf
echo $DIR
mkdir -p "$DIR" && cd "$DIR" && cp "$HWDEF" .
hsi -mode batch -source ../bin/fsbl.tcl 
cd -
