# ----------------------------------------------------------------------------
# Clock Source - Bank 13
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN Y9 [get_ports clk];
create_clock -period 10.000 -name clk -waveform {0.000 5.000} clk;
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];

# ----------------------------------------------------------------------------
# User Push Buttons - Bank 34
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN P16 [get_ports reset]; # "BTNC"
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];

# ----------------------------------------------------------------------------
# User LEDs - Bank 33
# ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN T22 [get_ports {MemWrite}];  # "LD0"
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];