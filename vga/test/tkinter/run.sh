#!/usr/bin/env sh

set -e

cd $(dirname "$0")

PY="python3"
if ! command -v "$PY"; then
  PY="python"
fi

echo "> Analyze ../src/*.vhd and ./hdl/*.vhd"
ghdl -a --std=08 -frelaxed ../../src/VGA_config_pkg.vhd
ghdl -a --std=08 -frelaxed ../../src/VGA_sync_gen_idx.vhd
ghdl -a --std=08 -frelaxed ../../src/VGA_sync_gen.vhd
ghdl -a --std=08 -frelaxed ../../src/VGA_sync_gen_cfg.vhd
ghdl -a --std=08 -frelaxed ../../src/Design_Top.vhd
ghdl -a --std=08 -frelaxed ../../src/demo.vhd

ghdl -a --std=08 -frelaxed ../hdl/VGA_screen_pkg.vhd
ghdl -a --std=08 -frelaxed ../hdl/VGA_screen.vhd
ghdl -a --std=08 -frelaxed ../hdl/VGA_tb.vhd

echo "> Build caux.so"
ghdl -e \
  --std=08 \
  -frelaxed \
  -Wl,-fPIC \
  -Wl,caux.c \
  -Wl,-shared \
  -Wl,-Wl,--version-script=./py.ver \
  -Wl,-Wl,-u,ghdl_main \
  -o caux.so \
  tb_vga

rm *.o *.cf

#echo "> Execute tb (save wave.ghw)"
#./tb --wave=wave.ghw

echo "> Execute run.py"
$PY run.py --wave=wave.ghw
