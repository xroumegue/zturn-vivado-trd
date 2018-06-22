#! /bin/bash
set -eux
vivado -mode batch -source src/tcl/zturn_bd.tcl
