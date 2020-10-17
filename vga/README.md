# VGA test pattern

This component aims to provide [Video Graphics Array](https://en.wikipedia.org/wiki/Video_Graphics_Array) (VGA) output examples for "*all the FPGA dev boards in the world*" ([sic](https://github.com/fusesoc/blinky)). It allows quickly testing your FPGA board and a monitor through tens of supported VGA modes (see [VGA_config_pkg.vhd](src/VGA_config_pkg.vhd)).

At the same time, the goal is to provide a reference structure for HDL projects with the following requirements:

- Design sources are written in VHDL and/or Verilog.
- Multiple target boards (hence, devices) are supported.
- Open source tooling and vendor tooling are used, for simulation, synthesis, implementation and programming.
- Open source resources are reused.

The sources of this component are organised as follows:

- `board`: a subdir for each supported board, where HDL sources specific to the board are located. At least, a file named `<BOARD_NAME>_Top.<EXTENSION>` is required, which is the top level unit for implementation.
- `device`: a subdir for each supported device, where HDL sources specific to the device are located. These sources are expected to be used in HDL sources located in `board/*/`.
- `src`: HDL sources of the component, which are common for simulation and/or synthesis, and for any target.
- `test`: resources for simulation (testing and verification), including testbenches, unit tests and co-simulation cores (such as a virtual screen).

Users willing to write their own applications/designs with VGA output are encouraged to clone this component and to adapt [demo.vhd](src/demo.vhd) for plugging their designs. The synchronism generation module (`VGA_sync_gen` or `VGA_sync_gen_cfg`) can be preserved, so that only the application logic needs to be described.

## Standing on the shoulders of...

The structure of this repository was heavily inspired by [PLC2/Solution-StopWatch](https://github.com/PLC2/Solution-StopWatch); the solution used by [Patrick Lehmann](https://github.com/Paebbels) in [PLC2](https://www.plc2.com)'s 5-day class [Professional VHDL](https://www.plc2.com/en/training/detail/professional-vhdl).

The idea about supporting "*all the FPGA dev boards in the world*" was borrowed from [fusesoc/blinky](https://github.com/fusesoc/blinky); one of the examples in the [base library](https://github.com/fusesoc/fusesoc-cores) of [Olof Kindgren](https://github.com/olofk/)'s [FuseSoC](https://github.com/olofk/fusesoc).

The makefile for mixed language synthesis using open source tooling ([GHDL](https://github.com/ghdl), [Yosys](https://github.com/YosysHQ/yosys), [nextpnr](https://github.com/YosysHQ/nextpnr), [icestorm](https://github.com/cliffordwolf/icestorm), etc.) was borrowed from [im-tomu/fomu-workshop](https://github.com/im-tomu/fomu-workshop); the workshop for the [Fomu](https://github.com/im-tomu/fomu-hardware) board by [Tim Ansell](https://github.com/mithro) and [Sean Cross](https://github.com/xobs).

Unlike all previous references, where ad-hoc constraint files (`*.xdc`, `*.pcf`, etc.) are used, here implementation constraint are imported from an open source repository. [hdl/constraints](https://github.com/hdl/constraints/) (based on [VLSI-EDA/PoC: ucf/](https://github.com/VLSI-EDA/PoC/tree/master/ucf)) is a submodule of this repository, and constraints are imported from there.

Co-simulation and the virtual screen are implemented using GHDL's VHPIDIRECT examples from [ghdl/ghdl-cosim](https://github.com/ghdl/ghdl-cosim). See [[LCS-202x] VHDL DPI/FFI based on GHDL’s implementation of VHPIDIRECT](https://umarcor.github.io/ghdl-cosim/vhdl202x/).

## Usage

> NOTE: for now, the only supported toolchain is: ghdl-yosy-plugin + Yosys + nextpnr. [open-tool-forge/fpga-toolchain](https://github.com/open-tool-forge/fpga-toolchain) provides ready-to-use packages for GNU/Linux, Windows or macOS, which include all of them. See [github.com/open-tool-forge/fpga-toolchain#installation](https://github.com/open-tool-forge/fpga-toolchain#installation).

First, run synthesis and implementation:

```sh
make VGA_BOARD=<BOARD_SUBDIR>
```

For instance:

```sh
make VGA_BOARD=icestick
```

Then, load the bitstream to the board. The following pattern should be shown in the monitor:

![VGA demo pattern](vga_demo.png)

## Development

Currently, the only supported build system is a [Makefile](Makefile). However, we are willing to support the following managers/runners:

- [VUnit](https://github.com/VUnit/vunit)
- [PyFPGA](https://gitlab.com/rodrigomelo9/pyfpga)
- [cocotb](https://github.com/cocotb/cocotb)
- [FuseSoC](https://github.com/olofk/fusesoc) and [edalize](https://github.com/olofk/edalize).
