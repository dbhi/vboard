ifeq ($(VGA_BOARD),tinyfpgabx)
# TinyFPGA-BX
PNRFLAGS  ?= --lp8k --package cm81 --pcf board/tinyfpgabx.pcf -q
BOARD_TOP = TinyFPGABX_Top
BOARD_FILES = board/TinyFPGABX_PLL_config_pkg.vhd
else
# Icestick
PNRFLAGS  ?= --hx1k --package tq144 --pcf board/icestick.pcf -q
BOARD_TOP = Icestick_Top
BOARD_FILES = board/Icestick_PLL_config_pkg.vhd
$(info Default VGA_BOARD value: 'icestick' (allowed: 'tinyfpgabx' or 'icestick'))
endif

#--

YOSYS_FLAGS ?=
YOSYS_SYNTH ?= synth_ice40
GHDL        ?= ghdl
GHDL_FLAGS  += --std=08
GHDL_SYNTH  ?= ghdl
YOSYS       ?= yosys
NEXTPNR     ?= nextpnr-ice40
ICEPACK     ?= icepack

VHDL_SYN_FILES = \
	src/cfg_pkg.vhd \
	src/sync_gen.vhd \
	src/sync_st.vhd \
	src/Design_Top.vhd \
	src/pattern.vhd \
	board/ICE40_components_pkg.vhd \
	board/ICE40_PLL_config_pkg.vhd \
	$(BOARD_FILES) \
	board/$(BOARD_TOP).vhd

all: vgatest.bin
	@true

.DEFAULT: all

vgatest.json: $(VHDL_SYN_FILES) $(VERILOG_SYN_FILES)
	$(YOSYS) $(YOSYS_FLAGS) \
		-p \
		"$(GHDL_SYNTH) $(GHDL_FLAGS) $(VHDL_SYN_FILES) -e; \
		$(YOSYS_SYNTH) \
		-top $(BOARD_TOP) \
		-json $@" 2>&1 board/pll.v | tee yosys-report.txt

vgatest.asc: vgatest.json
	$(NEXTPNR) \
		$(PNRFLAGS) \
		--json $< \
		--asc $@

vgatest.bin: vgatest.asc
	$(ICEPACK) $< $@

load: vgatest.bin
	iceprog $<
#	tinyprog -p $<

.PHONY: load

clean:
	rm -fr *.cf *.json *-report.txt *.asc *.bin abc.history

.PHONY: clean
