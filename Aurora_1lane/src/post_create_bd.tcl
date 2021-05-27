#-----------------------------------------------------------
# Vivado v2020.2 (64-bit)
# SW Build 3064766 on Wed Nov 18 09:12:47 MST 2020
# IP Build 3064653 on Wed Nov 18 14:17:31 MST 2020
# Start of session at: Mon Mar 29 09:53:05 2021
# Process ID: 27514
# Current directory: /home/aferretti/U50_tutorial_base/Example_design_modif_2
# Command line: vivado u200/hw/_x/link/vivado/vpl/prj/prj.xpr
# Log file: /home/aferretti/U50_tutorial_base/Example_design_modif_2/vivado.log
# Journal file: /home/aferretti/U50_tutorial_base/Example_design_modif_2/vivado.jou
#-----------------------------------------------------------

# open_bd_design {/home/aferretti/U50_tutorial_base/Example_design_modif_2/u200/hw/_x/link/vivado/vpl/prj/prj.srcs/my_rm/bd/bd/ulp.bd}

set curr_ip_paths [get_property ip_repo_paths [current_project]]
# puts ""
# puts [exec pwd]
# puts ""

lappend curr_ip_paths ../../../../../../U50_repo
set_property ip_repo_paths $curr_ip_paths [current_project]


# set_property  ip_repo_paths  {/home/aferretti/U50_repo} [current_project]
update_ip_catalog
# update_ip_catalog -rebuild -scan_changes

create_bd_cell -type ip -vlnv user.org:user:Aurora_GT_intf_1lane:1.0 Aurora_GT_intf_0

create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_64b66b:12.0 aurora_64b66b_0
set_property -dict [list CONFIG.CHANNEL_ENABLE {X0Y28} CONFIG.C_REFCLK_FREQUENCY {161.1328125} CONFIG.flow_mode {Immediate_NFC} CONFIG.C_UCOLUMN_USED {left} CONFIG.C_USER_K {true} CONFIG.C_START_QUAD {Quad_X0Y7} CONFIG.C_START_LANE {X0Y28} CONFIG.C_REFCLK_SOURCE {MGTREFCLK0_of_Quad_X0Y7} CONFIG.crc_mode {true} CONFIG.SupportLevel {1} CONFIG.C_USE_BYTESWAP {false}] [get_bd_cells aurora_64b66b_0]

create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_1
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_1
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1
set_property -dict [list CONFIG.CONST_VAL {1}] [get_bd_cells xlconstant_1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2
set_property -dict [list CONFIG.CONST_VAL {0}] [get_bd_cells xlconstant_2]


disconnect_bd_intf_net [get_bd_intf_net simple_hGradient_out_r] [get_bd_intf_pins simple_hGradient/out_r]
connect_bd_intf_net [get_bd_intf_pins axis_switch_1/M00_AXIS] [get_bd_intf_pins str2mem/in_r]
connect_bd_intf_net [get_bd_intf_pins axis_switch_1/S00_AXIS] [get_bd_intf_pins simple_hGradient/out_r]
connect_bd_net [get_bd_ports clk_kernel_in] [get_bd_pins axis_switch_1/aclk]
connect_bd_net [get_bd_pins axis_switch_1/aresetn] [get_bd_pins proc_sys_reset_kernel_slr0/peripheral_aresetn]
connect_bd_intf_net [get_bd_intf_pins axis_switch_1/S01_AXIS] [get_bd_intf_pins axis_dwidth_converter_1/M_AXIS]
connect_bd_net [get_bd_pins axis_dwidth_converter_1/aresetn] [get_bd_pins proc_sys_reset_kernel_slr0/peripheral_aresetn]
connect_bd_net [get_bd_ports clk_kernel_in] [get_bd_pins axis_dwidth_converter_1/aclk]
connect_bd_net [get_bd_ports clk_kernel_in] [get_bd_pins axis_clock_converter_1/m_axis_aclk]
connect_bd_net [get_bd_pins axis_clock_converter_1/m_axis_aresetn] [get_bd_pins proc_sys_reset_kernel_slr0/peripheral_aresetn]
connect_bd_intf_net [get_bd_intf_pins axis_dwidth_converter_1/S_AXIS] [get_bd_intf_pins axis_clock_converter_1/M_AXIS]


set_property -dict [list CONFIG.S_TDATA_NUM_BYTES.VALUE_SRC USER] [get_bd_cells axis_dwidth_converter_1]
set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {8} CONFIG.M_TDATA_NUM_BYTES {4}] [get_bd_cells axis_dwidth_converter_1]

set_property -dict [list CONFIG.TDATA_NUM_BYTES.VALUE_SRC USER CONFIG.HAS_TLAST.VALUE_SRC USER] [get_bd_cells axis_switch_1]
set_property -dict [list CONFIG.TDATA_NUM_BYTES {4} CONFIG.HAS_TLAST {1} CONFIG.ARB_ON_MAX_XFERS {256} CONFIG.ARB_ON_TLAST {1}] [get_bd_cells axis_switch_1]

connect_bd_net [get_bd_pins aurora_64b66b_0/user_clk_out] [get_bd_pins axis_clock_converter_1/s_axis_aclk]
connect_bd_net [get_bd_pins axis_clock_converter_1/s_axis_aresetn] [get_bd_pins xlconstant_1/dout]
connect_bd_intf_net [get_bd_intf_pins aurora_64b66b_0/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axis_clock_converter_1/S_AXIS]

set_property -dict [list CONFIG.TDATA_NUM_BYTES.VALUE_SRC USER CONFIG.HAS_TLAST.VALUE_SRC USER] [get_bd_cells axis_clock_converter_1]
set_property -dict [list CONFIG.TDATA_NUM_BYTES {8} CONFIG.HAS_TLAST {1}] [get_bd_cells axis_clock_converter_1]

connect_bd_net [get_bd_pins aurora_64b66b_0/init_clk] [get_bd_pins ii_level0_wire/ulp_m_aclk_freerun_ref_00]

connect_bd_intf_net [get_bd_intf_ports io_clk_qsfp_refclka_00] [get_bd_intf_pins aurora_64b66b_0/GT_DIFF_REFCLK1]
connect_bd_net [get_bd_pins xlconstant_2/dout] [get_bd_pins aurora_64b66b_0/pma_init]
connect_bd_net [get_bd_pins aurora_64b66b_0/reset_pb] [get_bd_pins xlconstant_2/dout]

connect_bd_intf_net [get_bd_intf_ports io_gt_qsfp_00] [get_bd_intf_pins Aurora_GT_intf_0/gt_serial_port]



connect_bd_intf_net [get_bd_intf_pins Aurora_GT_intf_0/AuroraGT_rx] [get_bd_intf_pins aurora_64b66b_0/GT_SERIAL_RX]
connect_bd_intf_net [get_bd_intf_pins Aurora_GT_intf_0/AuroraGT_tx] [get_bd_intf_pins aurora_64b66b_0/GT_SERIAL_TX]



create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0

set_property -dict [list CONFIG.FIFO_DEPTH {2048}] [get_bd_cells axis_data_fifo_0]
delete_bd_objs [get_bd_intf_nets axis_clock_converter_1_M_AXIS] [get_bd_intf_nets axis_dwidth_converter_1_M_AXIS] [get_bd_cells axis_dwidth_converter_1]
connect_bd_intf_net [get_bd_intf_pins axis_clock_converter_1/M_AXIS] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]

connect_bd_net [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins proc_sys_reset_kernel_slr0/peripheral_aresetn]
connect_bd_net [get_bd_ports clk_kernel_in] [get_bd_pins axis_data_fifo_0/s_axis_aclk]
connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins axis_switch_1/S01_AXIS]

set_property -dict [list CONFIG.TDATA_NUM_BYTES {8}] [get_bd_cells axis_switch_1]

disconnect_bd_net /xlconstant_2_dout [get_bd_pins aurora_64b66b_0/reset_pb]

create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0

connect_bd_net [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins ulp_ucs/aresetn_kernel_slr0]
connect_bd_net [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins aurora_64b66b_0/user_clk_out]
delete_bd_objs [get_bd_nets xlconstant_1_dout]
connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins axis_clock_converter_1/s_axis_aresetn]
connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_reset] [get_bd_pins aurora_64b66b_0/reset_pb]


set_property CONFIG.FREQ_HZ 161132813 [get_bd_intf_ports /io_clk_qsfp_refclka_00]
save_bd_design
# validate_bd_design
