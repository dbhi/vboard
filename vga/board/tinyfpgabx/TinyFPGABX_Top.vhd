library ieee;
context ieee.ieee_std_context;

use work.ICE40_components.all;
use work.ICE40_PLL_config.ICE40_PLL_config_t;
use work.ICE40_PLL_config.ICE40_Screen_configs;
use work.TinyFPGABX_PLL_config.TinyFPGABX_PLL_configs;

entity TinyFPGABX_Top is
  generic (
    SCREEN : natural := 22
  );
  port (
    CLK    : in  std_logic; -- System clock (16 Mhz)
    PIN_15 : in  std_logic; -- Reset

    USBPU  : out std_logic; -- USB pull resistor

    PIN_13 : out std_logic; -- VGA VSync
    PIN_12 : out std_logic; -- VGA HSync
    PIN_11 : out std_logic; -- VGA R
    PIN_10 : out std_logic; -- VGA G
    PIN_9  : out std_logic  -- VGA B
  );
end;

architecture arch of TinyFPGABX_Top is

  constant PLL_cfg : ICE40_PLL_config_t := TinyFPGABX_PLL_configs(ICE40_Screen_configs(SCREEN));

  signal clki : std_logic;
  signal rgb  : std_logic_vector(2 downto 0);

begin

  -- Drive USB pull-up resistor to '0' to disable USB
  USBPU <= '0';

  PLL_0: SB_PLL40_CORE
  generic map (
    DIVF => to_unsigned( PLL_cfg.DIVF, 7),
    DIVQ => to_unsigned( PLL_cfg.DIVQ, 3)
  )
  port map (
    REFERENCECLK => CLK,
    PLLOUTCORE   => clki,
    BYPASS       => '0',
    RESETB       => '1'
  );

  UUT: entity work.Design_Top(pattern)
  generic map (
    G_SCREEN => SCREEN
  )
  port map (
    CLK   => clki,
    EN    => '1',
    RST   => PIN_15,
    HSYNC => PIN_12,
    VSYNC => PIN_13,
    RGB   => rgb
  );

  PIN_11 <= rgb(2);
  PIN_10 <= rgb(1);
  PIN_9  <= rgb(0);

end;
