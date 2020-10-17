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
    'board/ICE40_components_pkg.vhd',
    'board/ICE40_PLL_config_pkg.vhd'
]

# Fileset-2
ICESTICK = {
    # Constraints | implementation
    'constraints': [
        '../constraints/boards/IceStick/constraints.pcf'
    ],
    # VHDL | implementation
    'srcs': [
        'board/Icestick_PLL_config_pkg.vhd',
        'board/Icestick_Top.vhd'
    ]
}

# Fileset-3
# VHDL | implementation
TINYFPGA_SRCS = [
    'board/TinyFPGABX_PLL_config_pkg.vhd',
    'board/TinyFPGABX_Top.vhd'
]
# Fileset-4
# Constraints | implementation
TINYFPGA_CONSTRAINTS = [
    '../constraints/boards/TinyFPGA-BX/constraints.pcf'
]

#-

TASKS = {
    'icestick': { # Class YosysNextpnr
        'top': 'Icestick_Top',
        'arch': '',
        'part': 'hx1k-tq144',
        'srcs': DESIGN_SRCS + ICE40_SRCS + ICESTICK['srcs'],
        'constraints': ICESTICK['constraints'],
        'tools': TOOLS, # optional
        'flags': FLAGS # optional
    },
    'tinyfpgabx': { # Class YosysNextpnr
        'top': 'TinyFPGABX_Top',
        'arch': '',
        'part': 'lp8k-cm81',
        'srcs': DESIGN_SRCS + ICE40_SRCS + TINYFPGA_SRCS,
        'constraints': TINYFPGA_CONSTRAINTS,
        'tools': TOOLS, # optional
        'flags': FLAGS # optional
    }
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


def run_cmd(cmd):
    print(cmd)


def run_yosys(task):
    run_cmd(TOOLS['yosys'] + FLAGS['yosys'] + [
        '-p',
        ' '.join(TOOLS['ghdl.plugin']) + ' ' +
        ' '.join(FLAGS['ghdl.synth']) + ' ' +
        ' '.join(task['srcs']) + '-e; ' +
        ' '.join(TOOLS['yosys.synth']) +
        (' -top %s' % task['top']) +
        ' -json vgatest.json'
    ])


def run_nextpnr(task):
    # extract device and package from task['part']
    # join constraints file list
    run_cmd(TOOLS['nextpnr'] + FLAGS['nextpnr'])


def gen_bitstream(task):
    run_cmd(TOOLS['icepack'])


for key, task in TASKS.items():
    print('> %s' % key)
    run_yosys(task)
    run_nextpnr(task)
    gen_bitstream(task)
    print()
