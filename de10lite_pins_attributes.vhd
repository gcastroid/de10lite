-- Pin assignments
attribute chip_pin: string;
-- Clock
attribute chip_pin of i_clk: signal is "p11";
-- Push Buttons
attribute chip_pin of i_key0: signal is "b8";
attribute chip_pin of i_key1: signal is "a7";
-- Switches
attribute chip_pin of i_sw: signal is "f15, b14, a14, a13, b12, a12, c12, d12, c11, c10";
-- Leds
attribute chip_pin of o_led: signal is "b11, a11, d14, e14, c13, d13, b10, a10, a9, a8";
-- 7 Segment Displays
attribute chip_pin of o_disp1: signal is "d15, c17, d17, e16, c16, c15, e15, c14";
attribute chip_pin of o_disp2: signal is "a16, b17, a18, a17, b16, e18, d18, c18";
attribute chip_pin of o_disp3: signal is "a19, b22, c22, b21, a21, b19, a20, b20";
attribute chip_pin of o_disp4: signal is "d22, e17, d19, c20, c19, e21, e22, f21";
attribute chip_pin of o_disp5: signal is "f17, f20, f19, h19, j18, e19, e20, f18";
attribute chip_pin of o_disp6: signal is "l19, n20, n19, m20, n18, l18, k20, j20";
-- GPIO
attribute chip_pin of gpio: signal is "v5, w6, w7, v7, w8, v8, w9, v9, w10, v10";
-- Arduino Header

-- ADC

-- VGA
attribute chip_pin of o_hor_sync: signal is "n3";
attribute chip_pin of o_ver_sync: signal is "n1";
attribute chip_pin of o_red: signal is "y1, y2, v1, aa1";
attribute chip_pin of o_grn: signal is "r1, r2, t2, w1";
attribute chip_pin of o_blu: signal is "n2, p4, t1, p1";

-- SDRAM

-- Accelerometer