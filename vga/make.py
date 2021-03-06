from fpga import Project

# Tool names/aliases as lists. This allows replacing them with containers
TOOLS = {
    'yosys': ['yosys'],
    'yosys.synth': ['synth_ice40'],
    'ghdl': ['ghdl'],
    'ghdl.plugin': ['ghdl'],
    'nextpnr': ['nextpnr-ice40'],
    'icepack': ['icepack']
}

FLAGS = {
    'yosys': [],
    'ghdl.synth': ['--std=08'],
    'ghdl.sim': ['--std=08'],
    'nextpnr': []
}

#-

# TODO
# - Add VHDL sources belonging to different libraries
# - Mix VHDL and Verilog sources

# Fileset-0
# VHDL | common
DESIGN_SRCS = [
    'src/VGA_config_pkg.vhd',
    'src/VGA_sync_gen_idx.vhd',
    'src/VGA_sync_gen.vhd',
    'src/VGA_sync_gen_cfg.vhd',
    'src/Design_Top.vhd',
    'src/demo.vhd'
]

# Fileset-1
# VHDL | implementation
ICE40_SRCS = [
    'device/ICE40/ICE40_components_pkg.vhd',
    'device/ICE40/ICE40_PLL_config_pkg.vhd'
]

# Fileset-2
ICESTICK = {
    # Constraints | implementation
    'constraints': [
        '../constraints/boards/IceStick/constraints.pcf'
    ],
    # VHDL | implementation
    'srcs': [
        'board/icestick/Icestick_PLL_config_pkg.vhd',
        'board/icestick/Icestick_Top.vhd'
    ]
}

# Fileset-3
# VHDL | implementation
TINYFPGA_SRCS = [
    'board/tinyfpgabx/TinyFPGABX_PLL_config_pkg.vhd',
    'board/tinyfpgabx/TinyFPGABX_Top.vhd'
]
# Fileset-4
# Constraints | implementation
TINYFPGA_CONSTRAINTS = [
    '../constraints/boards/TinyFPGA-BX/constraints.pcf'
]

#-

TASKS = {
    'icestick': Project(
        tool='openflow',
        project='icestick',
        init={
            'top': 'Icestick_Top',
            'arch': '',
            'part': 'hx1k-tq144',
            'vhdl': DESIGN_SRCS + ICE40_SRCS + ICESTICK['srcs'],
            'constraint': ICESTICK['constraints']
        }
     ),
    'tinyfpgabx': Project(
        tool='openflow',
        project='tinyfpgabx',
        init={
            'top': 'TinyFPGABX_Top',
            'arch': '',
            'part': 'lp8k-cm81',
            'vhdl': DESIGN_SRCS + ICE40_SRCS + TINYFPGA_SRCS,
            'constraint': TINYFPGA_CONSTRAINTS
        }
    )
    #'pynq': { # Class Vivado, GhdlVivado and/or YosysVivado
    #    'top': '',
    #    'arch': '',
    #    'part': '',
    #    'srcs':
    #    'constraints':
    #    'tools': TOOLS,
    #    'flags': FLAGS
    #},
    #'vunit': { # Class VUnitJSON
    #    'top':
    #    'arch':
    #    'srcs':
    #    ...
    # }
}

# YosysNextpnr: ghdl-yosys-plugin + Yosys for synthesis, and nextpnr for implementation.
# Vivado: Vivado for synthesis and implementation.
# GhdlVivado: GHDL synth as a preprocessor, and Vivado for synthesis and implementation.
# YosysVivado: ghdl-yosy-plugin + Yosys for synthesis, and Vivado for implementation.
# VUnitJSON: generate a JSON file describing the filesets and params to be imported in VUnit `run.py` files.

for task in TASKS:
    TASKS[task].generate()
