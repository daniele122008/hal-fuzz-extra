#!/bin/bash

BINARY=./st-plc.yml
INPUTS=-
OUTPUTS=./output_new2
HARNESS="python3 -m hal_fuzz.harness -c $BINARY"
nprocs=22
for i in `seq 2 $nprocs`; do
    ./../afl-fuzz -t 2000 -S slave$i -U -m none -i $INPUTS -o $OUTPUTS -- $HARNESS @@ >/dev/null 2>&1 &
done
./../afl-fuzz -t 1000+ -M master -U -m none -i $INPUTS -o $OUTPUTS -- $HARNESS @@
pkill afl-fuzz

