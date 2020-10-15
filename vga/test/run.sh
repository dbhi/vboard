#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "> Analyze ../src/*.vhd and ./hdl/*.vhd"
ghdl -i --std=08 -frelaxed ../src/*.vhd ./hdl/*.vhd

echo "> Build tb (with caux.c)"
ghdl -m --std=08 -frelaxed -Wl,caux.c -o tb tb_vga

echo "> Execute tb (save wave.ghw)"
./tb --wave=wave.ghw
