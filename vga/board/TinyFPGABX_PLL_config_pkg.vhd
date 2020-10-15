library ieee;
context ieee.ieee_std_context;

use work.ICE40_PLL_config.ICE40_PLL_configs_t;

package TinyFPGABX_PLL_config is

constant TinyFPGABX_PLL_configs : ICE40_PLL_configs_t := (
--        DIVF  DIVQ        Desired  Achieved   Error
   0 => (   49,    5 ), --   25.175    25.000   0.175
   1 => (   62,    5 ), --   31.500    31.500
   2 => (   34,    4 ), --   34.960    35.000  -0.040
                        --   35.500            -0.500
   3 => (   35,    4 ), --   36.000    36.000
   4 => (   39,    4 ), --   40.000    40.000
   5 => (   42,    4 ), --   42.930    43.000  -0.070
   6 => (   42,    4 ), --   43.160    43.000   0.160
   7 => (   44,    4 ), --   44.900    45.000  -0.10
   8 => (   45,    4 ), --   45.510    46.000  -0.490
   9 => (   48,    4 ), --   49.500    49.000   0.500
  10 => (   49,    4 ), --   50.000    50.000
  11 => (   51,    4 ), --   51.840    52.000  -0.160
  12 => (   55,    4 ), --   56.250    56.000   0.250
  13 => (   62,    4 ), --   62.570    63.000  -0.430
  14 => (   64,    4 ), --   65.000    65.000
  15 => (   33,    3 ), --   68.180    68.000   0.180
  16 => (   36,    3 ), --   75.000    74.000   1.000
  17 => (   38,    3 ), --   78.800    78.000   0.800
  18 => (   40,    3 ), --   81.620    82.000  -0.380
  19 => (   41,    3 ), --   83.460    84.000  -0.560
  20 => (   42,    3 ), --   85.860    86.000  -0.140

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

end TinyFPGABX_PLL_config;
