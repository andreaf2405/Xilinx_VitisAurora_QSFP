################################################################################

# This XDC is used only for OOC mode of synthesis, implementation
# This constraints file contains default clock frequencies to be used during
# out-of-context flows such as OOC Synthesis and Hierarchical Designs.
# This constraints file is not used in normal top-down synthesis (default flow
# of Vivado)
################################################################################
create_clock -name init_clk_0 -period 10 [get_ports init_clk_0]
create_clock -name GT_DIFF_REFCLK1_0_clk_p -period 6.206 [get_ports GT_DIFF_REFCLK1_0_clk_p]

################################################################################