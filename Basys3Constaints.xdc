# This is for the display exercise

set_property IOSTANDARD LVCMOS33 [get_ports *]


## Clock signal
set_property PACKAGE_PIN W5 [get_ports clock]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clock]
 
## Switches
set_property PACKAGE_PIN V17 [get_ports {io_switches[0]}]
set_property PACKAGE_PIN V16 [get_ports {io_switches[1]}]
set_property PACKAGE_PIN W16 [get_ports {io_switches[2]}]
set_property PACKAGE_PIN W17 [get_ports {io_switches[3]}]
set_property PACKAGE_PIN W15 [get_ports {io_switches[4]}]
set_property PACKAGE_PIN V15 [get_ports {io_switches[5]}]
set_property PACKAGE_PIN W14 [get_ports {io_switches[6]}]
set_property PACKAGE_PIN W13 [get_ports {io_switches[7]}]
set_property PACKAGE_PIN V2  [get_ports {io_switches[8]}]
set_property PACKAGE_PIN T3  [get_ports {io_switches[9]}]
set_property PACKAGE_PIN T2  [get_ports {io_switches[10]}]
set_property PACKAGE_PIN R3  [get_ports {io_switches[11]}]
set_property PACKAGE_PIN W2  [get_ports {io_switches[12]}]
set_property PACKAGE_PIN U1  [get_ports {io_switches[13]}]
set_property PACKAGE_PIN T1  [get_ports {io_switches[14]}]
set_property PACKAGE_PIN R2  [get_ports {io_switches[15]}]

## LEDs
set_property PACKAGE_PIN U16 [get_ports {io_leds[0]}]
set_property PACKAGE_PIN E19 [get_ports {io_leds[1]}]
set_property PACKAGE_PIN U19 [get_ports {io_leds[2]}]
set_property PACKAGE_PIN V19 [get_ports {io_leds[3]}]
set_property PACKAGE_PIN W18 [get_ports {io_leds[4]}]
set_property PACKAGE_PIN U15 [get_ports {io_leds[5]}]
set_property PACKAGE_PIN U14 [get_ports {io_leds[6]}]
set_property PACKAGE_PIN V14 [get_ports {io_leds[7]}]
set_property PACKAGE_PIN V13 [get_ports {io_leds[8]}]
set_property PACKAGE_PIN V3  [get_ports {io_leds[9]}]
set_property PACKAGE_PIN W3  [get_ports {io_leds[10]}]
set_property PACKAGE_PIN U3  [get_ports {io_leds[11]}]
set_property PACKAGE_PIN P3  [get_ports {io_leds[12]}]
set_property PACKAGE_PIN N3  [get_ports {io_leds[13]}]
set_property PACKAGE_PIN P1  [get_ports {io_leds[14]}]
set_property PACKAGE_PIN L1  [get_ports {io_leds[15]}]

##Buttons
# btnR proposed as reset
#set_property PACKAGE_PIN T17 [get_ports btnR]
set_property PACKAGE_PIN T17 [get_ports reset]


## Pmod in lower row
# BTN0
# set_property PACKAGE_PIN A15 [get_ports {io_coin2}]
# BTN1
# set_property PACKAGE_PIN A17 [get_ports {io_coin5}]
# BTN2
# set_property PACKAGE_PIN C15 [get_ports {io_buy}]
# BTN3 -  can be used as manual clock
#set_property PACKAGE_PIN C16 [get_ports {io_btn[3]}]

##7 segment display
set_property PACKAGE_PIN W7 [get_ports {io_display_segments[0]}]
set_property PACKAGE_PIN W6 [get_ports {io_display_segments[1]}]
set_property PACKAGE_PIN U8 [get_ports {io_display_segments[2]}]
set_property PACKAGE_PIN V8 [get_ports {io_display_segments[3]}]
set_property PACKAGE_PIN U5 [get_ports {io_display_segments[4]}]
set_property PACKAGE_PIN V5 [get_ports {io_display_segments[5]}]
set_property PACKAGE_PIN U7 [get_ports {io_display_segments[6]}]
#set_property PACKAGE_PIN V7 [get_ports io_dp]
set_property PACKAGE_PIN U2 [get_ports {io_display_selector[0]}]
set_property PACKAGE_PIN U4 [get_ports {io_display_selector[1]}]
set_property PACKAGE_PIN V4 [get_ports {io_display_selector[2]}]
set_property PACKAGE_PIN W4 [get_ports {io_display_selector[3]}]
