#! /bin/bash
mkdir -p fsbl && cd fsbl && cp ../zturn.hdf .
hsi -mode batch -source ../bin/fsbl.tcl 
cd -
make -C fsbl/fsbl
cp fsbl/fsbl/executable.elf fsbl.elf
