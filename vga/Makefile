ifeq ($(VGA_BOARD),tinyfpgabx)
# TinyFPGA-BX
DEVICE = lp8k
PACKAGE = cm81
CONSTRAINTS_NAME = TinyFPGA-BX
BOARD_TOP = TinyFPGABX_Top
BOARD_FILES = board/$(VGA_BOARD)/TinyFPGABX_PLL_config_pkg.vhd
else
# Icestick
VGA_BOARD = icestick
DEVICE = hx1k
PACKAGE = tq144
CONSTRAINTS_NAME = IceStick
BOARD_TOP = Icestick_Top
BOARD_FILES = board/$(VGA_BOARD)/Icestick_PLL_config_pkg.vhd
$(info Default VGA_BOARD value: 'icestick' (allowed: 'tinyfpgabx' or 'icestick'))
endif

#--

GHDL          ?= ghdl
GHDL_SYNTH    ?= ghdl
YOSYS         ?= yosys
YOSYS_SYNTH   ?= synth_ice40
NEXTPNR       ?= nextpnr-ice40
ICEPACK       ?= icepack

GHDL_FLAGS    += --std=08
YOSYS_FLAGS   += -q
NEXTPNR_FLAGS += -q

VHDL_SYN_FILES = \
	src/VGA_config_pkg.vhd \
	src/VGA_sync_gen_idx.vhd \
	src/VGA_sync_gen.vhd \
	src/VGA_sync_gen_cfg.vhd \
	src/Design_Top.vhd \
	src/demo.vhd \
	device/ICE40/ICE40_components_pkg.vhd \
	device/ICE40/ICE40_PLL_config_pkg.vhd \
	$(BOARD_FILES) \
	board/$(VGA_BOARD)/$(BOARD_TOP).vhd

all: vgatest.bin
	@true

.DEFAULT: all

vgatest.json: $(VHDL_SYN_FILES) $(VERILOG_SYN_FILES)
	$(YOSYS) $(YOSYS_FLAGS) \
		-p \
		"$(GHDL_SYNTH) $(GHDL_FLAGS) $(VHDL_SYN_FILES) -e; \
		$(YOSYS_SYNTH) \
		-top $(BOARD_TOP) \
		-json $@" 2>&1 | tee yosys-report.txt

# To be drawn with netlistsvg
vganet.json: $(VHDL_SYN_FILES) $(VERILOG_SYN_FILES)
	$(YOSYS) $(YOSYS_FLAGS) \
		-p \
		"$(GHDL_SYNTH) $(GHDL_FLAGS) $(VHDL_SYN_FILES) -e; \
		prep \
		-top $(BOARD_TOP); \
		write_json $@;" 2>&1 | tee yosys-report.txt

vgatest.asc: vgatest.json
	$(NEXTPNR) \
		$(NEXTPNR_FLAGS) \
		--$(DEVICE) --package "$(PACKAGE)" \
		--pcf "../constraints/boards/$(CONSTRAINTS_NAME)/constraints.pcf" \
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
