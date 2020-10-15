library ieee;
context ieee.ieee_std_context;

use work.ICE40_PLL_config.ICE40_PLL_configs_t;

package Icestick_PLL_config is

constant Icestick_PLL_configs : ICE40_PLL_configs_t := (
--        DIVF  DIVQ        Desired  Achieved  Error
   0 => (   66,    5 ), --   25.175    25.125   0.05
   1 => (   83,    5 ), --   31.500    31.500
   2 => (   46,    4 ), --   34.960    35.250  -0.29
                        --   35.500            -0.25
   3 => (   47,    4 ), --   36.000    36.000
   4 => (   52,    4 ), --   40.000    39.750   0.25
   5 => (   56,    4 ), --   42.930    42.750   0.18
   6 => (   57,    4 ), --   43.160    42.350   0.81
   7 => (   59,    4 ), --   44.900    45.000  -0.10
   8 => (   60,    4 ), --   45.510    45.750  -0.24
   9 => (   65,    4 ), --   49.500    49.500
  10 => (   66,    4 ), --   50.000    52.250  -2.25
  11 => (   68,    4 ), --   51.840    51.750   0.09
  12 => (   74,    4 ), --   56.250    56.250
  13 => (   82,    4 ), --   62.570    62.250   0.32
  14 => (   86,    4 ), --   65.000    65.250  -0.25
  15 => (   44,    3 ), --   68.180    67.500   0.68
  16 => (   49,    3 ), --   75.000    75.000
  17 => (   52,    3 ), --   78.800    79.500  -0.70
  18 => (   53,    3 ), --   81.620    81.000   0.62
  19 => (   55,    3 ), --   83.460    84.000  -0.56
  20 => (   56,    3 ), --   85.860    85.500   0.36

  -- TODO
  21 => (    0,    0 ), --   94.500
  22 => (    0,    0 ), --  102.100
  23 => (    0,    0 ), --  106.470
  24 => (    0,    0 ), --  108.000
  25 => (    0,    0 ), --  113.310
  26 => (    0,    0 ), --  119.650
  27 => (    0,    0 ), --  122.610
  28 => (    0,    0 ), --  124.540
  29 => (    0,    0 ), --  129.860
  30 => (    0,    0 ), --  135.000
  31 => (    0,    0 ), --  143.470
  32 => (    0,    0 ), --  147.140
  33 => (    0,    0 ), --  148.500
  34 => (    0,    0 ), --  149.340
  35 => (    0,    0 ), --  155.850
  36 => (    0,    0 ), --  157.500
  37 => (    0,    0 ), --  162.000
  38 => (    0,    0 ), --  175.500
  39 => (    0,    0 ), --  178.990
  40 => (    0,    0 ), --  179.260
  41 => (    0,    0 ), --  189.000
  42 => (    0,    0 ), --  190.960
  43 => (    0,    0 ), --  193.160
  44 => (    0,    0 ), --  202.500
  45 => (    0,    0 ), --  204.800
  46 => (    0,    0 ), --  214.390
  47 => (    0,    0 ), --  218.300
  48 => (    0,    0 ), --  229.500
  49 => (    0,    0 ), --  229.500
  50 => (    0,    0 ), --  234.000
  51 => (    0,    0 ), --  280.640
  52 => (    0,    0 ), --  288.000
  53 => (    0,    0 )  --  297.000
);

end Icestick_PLL_config;
