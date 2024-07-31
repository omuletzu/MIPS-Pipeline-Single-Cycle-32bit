# This file is a general .xdc for the Nexys A7-100T
# To use it in a project:
# - uncomment the lines corresponding to used pins
# - rename the used ports (in each line, after get_ports) according to the top level signal names in the project


# Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports {clk}];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}];


# Switches
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports {sw[0]}];
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports {sw[1]}];
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports {sw[2]}];
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports {sw[3]}];
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports {sw[4]}];
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports {sw[5]}];
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports {sw[6]}];
set_property -dict { PACKAGE_PIN R13   IOSTANDARD LVCMOS33 } [get_ports {sw[7]}];
set_property -dict { PACKAGE_PIN T8    IOSTANDARD LVCMOS18 } [get_ports {sw[8]}];
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS18 } [get_ports {sw[9]}];
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports {sw[10]}];
set_property -dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports {sw[11]}];
set_property -dict { PACKAGE_PIN H6    IOSTANDARD LVCMOS33 } [get_ports {sw[12]}];
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports {sw[13]}];
set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 } [get_ports {sw[14]}];
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports {sw[15]}];


# LEDs
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports {led[0]}];
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports {led[1]}];
set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports {led[2]}];
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports {led[3]}];
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports {led[4]}];
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {led[5]}];
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports {led[6]}];
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports {led[7]}];
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports {led[8]}];
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports {led[9]}];
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports {led[10]}];
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports {led[11]}];
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports {led[12]}];
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports {led[13]}];
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports {led[14]}];
set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports {led[15]}];


# 7 segment display
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports {cat[0]}]; # Ca
set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports {cat[1]}]; # Cb
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports {cat[2]}]; # Cc
set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports {cat[3]}]; # Cd
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports {cat[4]}]; # Ce
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports {cat[5]}]; # Cf
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports {cat[6]}]; # Cg
#set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports {dp}]; # dot point

set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports {an[0]}];
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports {an[1]}];
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports {an[2]}];
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports {an[3]}];
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports {an[4]}];
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports {an[5]}];
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports {an[6]}];
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports {an[7]}];


# Buttons
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports {btn[0]}]; # center
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports {btn[1]}]; # up
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports {btn[2]}]; # left
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports {btn[3]}]; # right
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports {btn[4]}]; # down


# UART
#set_property -dict { PACKAGE_PIN C4    IOSTANDARD LVCMOS33 } [get_ports {tx}];
#set_property -dict { PACKAGE_PIN D4    IOSTANDARD LVCMOS33 } [get_ports {rx}];