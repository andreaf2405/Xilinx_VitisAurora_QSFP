set_false_path -through [get_pins -hier *probe0[*]]

# Due to lack of cell attachment points in upper hierarchies, re-apply QSFP HSIO and refclk package_pin constraints at this scope
set_property PACKAGE_PIN N37 [get_ports {io_clk_qsfp_refclka_00_clk_n}]
set_property PACKAGE_PIN N36 [get_ports {io_clk_qsfp_refclka_00_clk_p}]
set_property PACKAGE_PIN M39 [get_ports {io_clk_qsfp_refclkb_00_clk_n}]
set_property PACKAGE_PIN M38 [get_ports {io_clk_qsfp_refclkb_00_clk_p}]