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

create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_64b66b:12.0 aurora_64b66b_0
# set_property -dict [list CONFIG.CHANNEL_ENABLE {X0Y28} CONFIG.C_REFCLK_FREQUENCY {161.1328125} CONFIG.flow_mode {Immediate_NFC} CONFIG.C_AURORA_LANES {4} CONFIG.C_UCOLUMN_USED {left} CONFIG.C_USER_K {true} CONFIG.C_START_QUAD {Quad_X0Y7} CONFIG.C_START_LANE {X0Y28} CONFIG.C_REFCLK_SOURCE {MGTREFCLK0_of_Quad_X0Y7} CONFIG.crc_mode {true} CONFIG.SupportLevel {1} CONFIG.C_USE_BYTESWAP {false}] [get_bd_cells aurora_64b66b_0]
set_property -dict [list CONFIG.C_LINE_RATE {10.3125} CONFIG.CHANNEL_ENABLE {X0Y28 X0Y29 X0Y30 X0Y31} CONFIG.flow_mode {Immediate_NFC} CONFIG.C_AURORA_LANES {4} CONFIG.C_REFCLK_FREQUENCY {161.1328125} CONFIG.C_UCOLUMN_USED {left} CONFIG.C_USER_K {false} CONFIG.C_START_QUAD {Quad_X0Y7} CONFIG.C_START_LANE {X0Y28} CONFIG.C_REFCLK_SOURCE {MGTREFCLK0_of_Quad_X0Y7} CONFIG.C_GT_LOC_4 {4} CONFIG.C_GT_LOC_3 {3} CONFIG.C_GT_LOC_2 {2} CONFIG.crc_mode {true} CONFIG.SupportLevel {1} CONFIG.C_USE_BYTESWAP {false}] [get_bd_cells aurora_64b66b_0]


create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_inbound
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_outbound
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_1
set_property -dict [list CONFIG.TDATA_NUM_BYTES.VALUE_SRC USER CONFIG.HAS_TLAST.VALUE_SRC USER] [get_bd_cells axis_switch_1]
set_property -dict [list CONFIG.TDATA_NUM_BYTES {32} CONFIG.HAS_TLAST {1} CONFIG.ARB_ON_MAX_XFERS {256} CONFIG.ARB_ON_TLAST {1}] [get_bd_cells axis_switch_1]

create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_high
set_property -dict [list CONFIG.CONST_VAL {1}] [get_bd_cells xlconstant_high]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_low
set_property -dict [list CONFIG.CONST_VAL {0}] [get_bd_cells xlconstant_low]

create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0
set_property -dict [list CONFIG.FIFO_DEPTH {2048}] [get_bd_cells axis_data_fifo_0]


create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0

connect_bd_net [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins ulp_ucs/aresetn_kernel_slr0]
connect_bd_net [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins aurora_64b66b_0/user_clk_out]
connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins axis_clock_converter_inbound/s_axis_aresetn]
connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins axis_clock_converter_outbound/m_axis_aresetn]


#make it travel through QSFP loopback
disconnect_bd_intf_net [get_bd_intf_net simple_hGradient_out_r] [get_bd_intf_pins simple_hGradient/out_r]



connect_bd_net [get_bd_pins aurora_64b66b_0/user_clk_out] [get_bd_pins axis_clock_converter_inbound/s_axis_aclk]

set_property -dict [list CONFIG.TDATA_NUM_BYTES.VALUE_SRC USER CONFIG.HAS_TLAST.VALUE_SRC USER] [get_bd_cells axis_clock_converter_inbound]
set_property -dict [list CONFIG.TDATA_NUM_BYTES {32} CONFIG.HAS_TLAST {1}] [get_bd_cells axis_clock_converter_inbound]

connect_bd_net [get_bd_ports clk_kernel_in] [get_bd_pins axis_clock_converter_inbound/m_axis_aclk]
connect_bd_net [get_bd_pins axis_clock_converter_inbound/m_axis_aresetn] [get_bd_pins proc_sys_reset_kernel_slr0/peripheral_aresetn]

connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_clock_converter_inbound/M_AXIS]

connect_bd_intf_net [get_bd_intf_pins aurora_64b66b_0/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axis_clock_converter_inbound/S_AXIS]

connect_bd_net [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins proc_sys_reset_kernel_slr0/peripheral_aresetn]
connect_bd_net [get_bd_ports clk_kernel_in] [get_bd_pins axis_data_fifo_0/s_axis_aclk]
connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins axis_switch_1/S00_AXIS]


connect_bd_intf_net [get_bd_intf_pins axis_switch_1/M00_AXIS] [get_bd_intf_pins str2mem/in_r]

# connect_bd_intf_net [get_bd_intf_pins axis_switch_1/S00_AXIS] [get_bd_intf_pins simple_hGradient/out_r]



connect_bd_net [get_bd_pins aurora_64b66b_0/user_clk_out] [get_bd_pins axis_clock_converter_outbound/m_axis_aclk]

set_property -dict [list CONFIG.TDATA_NUM_BYTES.VALUE_SRC USER CONFIG.HAS_TLAST.VALUE_SRC USER] [get_bd_cells axis_clock_converter_outbound]
set_property -dict [list CONFIG.TDATA_NUM_BYTES {32} CONFIG.HAS_TLAST {1}] [get_bd_cells axis_clock_converter_outbound]

connect_bd_net [get_bd_ports clk_kernel_in] [get_bd_pins axis_clock_converter_outbound/s_axis_aclk]
connect_bd_net [get_bd_pins axis_clock_converter_outbound/s_axis_aresetn] [get_bd_pins proc_sys_reset_kernel_slr0/peripheral_aresetn]

connect_bd_intf_net [get_bd_intf_pins aurora_64b66b_0/USER_DATA_S_AXIS_TX] [get_bd_intf_pins axis_clock_converter_outbound/M_AXIS]
connect_bd_intf_net [get_bd_intf_pins simple_hGradient/out_r] [get_bd_intf_pins axis_clock_converter_outbound/S_AXIS]



connect_bd_net [get_bd_ports clk_kernel_in] [get_bd_pins axis_switch_1/aclk]
connect_bd_net [get_bd_pins axis_switch_1/aresetn] [get_bd_pins proc_sys_reset_kernel_slr0/peripheral_aresetn]





connect_bd_net [get_bd_pins aurora_64b66b_0/init_clk] [get_bd_pins ii_level0_wire/ulp_m_aclk_freerun_ref_00]
connect_bd_intf_net [get_bd_intf_ports io_clk_qsfp_refclka_00] [get_bd_intf_pins aurora_64b66b_0/GT_DIFF_REFCLK1]
connect_bd_net [get_bd_pins xlconstant_low/dout] [get_bd_pins aurora_64b66b_0/pma_init]
connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_reset] [get_bd_pins aurora_64b66b_0/reset_pb]


# create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0lb
# set_property -dict [list CONFIG.CONST_WIDTH {3}] [get_bd_cells xlconstant_0lb]
# connect_bd_net [get_bd_pins xlconstant_0lb/dout] [get_bd_pins aurora_64b66b_0/loopback]


# delete_bd_objs [get_bd_intf_nets axis_clock_converter_outbound_M_AXIS]
# delete_bd_objs [get_bd_intf_nets aurora_64b66b_0_USER_DATA_M_AXIS_RX]
# connect_bd_intf_net [get_bd_intf_pins axis_clock_converter_outbound/M_AXIS] [get_bd_intf_pins axis_clock_converter_inbound/S_AXIS]


create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0
set_property -dict [list CONFIG.C_ALL_INPUTS {1}] [get_bd_cells axi_gpio_0]


connect_bd_net [get_bd_ports clk_kernel_in] [get_bd_pins axi_gpio_0/s_axi_aclk]
connect_bd_net [get_bd_pins proc_sys_reset_kernel_slr0/peripheral_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn]

create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0

set_property -dict [list CONFIG.NUM_PORTS {32}] [get_bd_cells xlconcat_0]
connect_bd_net [get_bd_pins xlconcat_0/In0] [get_bd_pins aurora_64b66b_0/channel_up]
connect_bd_net [get_bd_pins aurora_64b66b_0/crc_pass_fail_n] [get_bd_pins xlconcat_0/In1]
connect_bd_net [get_bd_pins aurora_64b66b_0/crc_valid] [get_bd_pins xlconcat_0/In2]
connect_bd_net [get_bd_pins aurora_64b66b_0/gt_pll_lock] [get_bd_pins xlconcat_0/In3]
connect_bd_net [get_bd_pins aurora_64b66b_0/hard_err] [get_bd_pins xlconcat_0/In4]

set_property -dict [list CONFIG.IN5_WIDTH.VALUE_SRC USER] [get_bd_cells xlconcat_0]
set_property -dict [list CONFIG.IN5_WIDTH {4}] [get_bd_cells xlconcat_0]

connect_bd_net [get_bd_pins xlconcat_0/In5] [get_bd_pins aurora_64b66b_0/lane_up]
connect_bd_net [get_bd_pins aurora_64b66b_0/mmcm_not_locked_out] [get_bd_pins xlconcat_0/In6]
connect_bd_net [get_bd_pins xlconcat_0/In7] [get_bd_pins aurora_64b66b_0/soft_err]

set_property -dict [list CONFIG.NUM_PORTS {29}] [get_bd_cells xlconcat_0]

connect_bd_net [get_bd_pins xlconcat_0/dout] [get_bd_pins axi_gpio_0/gpio_io_i]


create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_0
set_property -dict [list CONFIG.C_PROBE0_WIDTH {32} CONFIG.C_DATA_DEPTH {4096} CONFIG.C_NUM_OF_PROBES {1} CONFIG.C_PROBE0_MU_CNT {2} CONFIG.ALL_PROBE_SAME_MU_CNT {2} CONFIG.C_ENABLE_ILA_AXI_MON {false} CONFIG.C_MONITOR_TYPE {Native}] [get_bd_cells ila_0]
connect_bd_net [get_bd_ports clk_kernel_in] [get_bd_pins ila_0/clk]
connect_bd_net [get_bd_pins xlconcat_0/dout] [get_bd_pins ila_0/probe0]
connect_bd_net [get_bd_pins xlconcat_0/In9] [get_bd_pins xlconstant_high/dout]

set_property -dict [list CONFIG.C_ALL_INPUTS {1}] [get_bd_cells SLR0/axi_gpio_null]
connect_bd_net [get_bd_pins SLR0/axi_gpio_null/gpio_io_i] [get_bd_pins xlconcat_0/dout]
# set_property offset 0x1430000 [get_bd_addr_segs {ii_level0_wire/ulp_m_axi_ctrl_user_00/SEG_gpioreader_Reg}]



set_property -dict [list CONFIG.C_LINE_RATE {10.3125} CONFIG.C_REFCLK_FREQUENCY {161.1328125} CONFIG.interface_mode {Streaming} CONFIG.flow_mode {None} CONFIG.crc_mode {false}] [get_bd_cells aurora_64b66b_0]
# set_property -dict [list CONFIG.C_LINE_RATE {25.78125} CONFIG.C_REFCLK_FREQUENCY {161.1328125} CONFIG.interface_mode {Streaming} CONFIG.flow_mode {None} CONFIG.crc_mode {false}] [get_bd_cells aurora_64b66b_0]
delete_bd_objs [get_bd_nets aurora_64b66b_0_crc_pass_fail_n] [get_bd_nets aurora_64b66b_0_crc_valid]
# # delete_bd_objs [get_bd_nets xlconstant_0_dout] [get_bd_cells xlconstant_0]

# # set_property -dict [list CONFIG.CHANNEL_ENABLE {X0Y28} CONFIG.C_AURORA_LANES {1} CONFIG.C_GT_LOC_4 {X} CONFIG.C_GT_LOC_3 {X} CONFIG.C_GT_LOC_2 {X}] [get_bd_cells aurora_64b66b_0]
# set_property -dict [list CONFIG.CHANNEL_ENABLE {X0Y31} CONFIG.C_START_LANE {X0Y31} CONFIG.C_AURORA_LANES {1} CONFIG.C_GT_LOC_4 {X} CONFIG.C_GT_LOC_3 {X} CONFIG.C_GT_LOC_2 {X}] [get_bd_cells aurora_64b66b_0]

# # set_property -dict [list CONFIG.CHANNEL_ENABLE {X0Y28 X0Y29} CONFIG.C_AURORA_LANES {2} CONFIG.C_GT_LOC_4 {X} CONFIG.C_GT_LOC_3 {X} CONFIG.C_GT_LOC_2 {2}] [get_bd_cells aurora_64b66b_0]

delete_bd_objs [get_bd_intf_nets Aurora_GT_intf_0_gt_serial_port] [get_bd_intf_ports io_gt_qsfp_00]
delete_bd_objs [get_bd_intf_nets Aurora_GT_intf_0_AuroraGT_rx] [get_bd_intf_nets aurora_64b66b_0_GT_SERIAL_TX] [get_bd_cells Aurora_GT_intf_0]
# make_bd_intf_pins_external  [get_bd_intf_pins aurora_64b66b_0/GT_SERIAL_TX]
# make_bd_intf_pins_external  [get_bd_intf_pins aurora_64b66b_0/GT_SERIAL_RX]

make_bd_pins_external  [get_bd_pins aurora_64b66b_0/txn]
make_bd_pins_external  [get_bd_pins aurora_64b66b_0/txp]
set_property name io_gt_qsfp_00_gtx_p [get_bd_ports txp_0]
set_property name io_gt_qsfp_00_gtx_n [get_bd_ports txn_0]
make_bd_pins_external  [get_bd_pins aurora_64b66b_0/rxn]
make_bd_pins_external  [get_bd_pins aurora_64b66b_0/rxp]
set_property name io_gt_qsfp_00_grx_n [get_bd_ports rxn_0]
set_property name io_gt_qsfp_00_grx_p [get_bd_ports rxp_0]

set_property RIGHT 3 [get_bd_ports /io_gt_qsfp_00_grx_n]
set_property RIGHT 3 [get_bd_ports /io_gt_qsfp_00_gtx_n]
set_property RIGHT 3 [get_bd_ports /io_gt_qsfp_00_grx_p]
set_property RIGHT 3 [get_bd_ports /io_gt_qsfp_00_gtx_p]


# ##2lane 

# # create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_1
# # set_property -dict [list CONFIG.IN0_WIDTH.VALUE_SRC USER CONFIG.IN1_WIDTH.VALUE_SRC USER] [get_bd_cells xlconcat_1]
# # set_property -dict [list CONFIG.NUM_PORTS {2} CONFIG.IN0_WIDTH {2} CONFIG.IN1_WIDTH {2}] [get_bd_cells xlconcat_1]
# # delete_bd_objs [get_bd_nets aurora_64b66b_0_txn]
# # connect_bd_net [get_bd_ports io_gt_qsfp_00_gtx_n] [get_bd_pins xlconcat_1/dout]

# # create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
# # set_property -dict [list CONFIG.CONST_WIDTH {2} CONFIG.CONST_VAL {0}] [get_bd_cells xlconstant_0]
# # # connect_bd_net [get_bd_pins xlconcat_1/In0] [get_bd_pins xlconstant_0/dout]
# # # connect_bd_net [get_bd_pins aurora_64b66b_0/txn] [get_bd_pins xlconcat_1/In1]

# # copy_bd_objs /  [get_bd_cells {xlconcat_1}]
# # delete_bd_objs [get_bd_nets aurora_64b66b_0_txp]
# # connect_bd_net [get_bd_ports io_gt_qsfp_00_gtx_p] [get_bd_pins xlconcat_2/dout]
# # # connect_bd_net [get_bd_pins xlconcat_2/In1] [get_bd_pins aurora_64b66b_0/txp]
# # # connect_bd_net [get_bd_pins xlconcat_2/In0] [get_bd_pins xlconstant_0/dout]

# # create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0
# # set_property -dict [list CONFIG.DIN_FROM {3} CONFIG.DIN_TO {2} CONFIG.DIN_WIDTH {4} CONFIG.DOUT_WIDTH {2}] [get_bd_cells xlslice_0]
# # delete_bd_objs [get_bd_nets rxp_0_1]
# # connect_bd_net [get_bd_ports io_gt_qsfp_00_grx_p] [get_bd_pins xlslice_0/Din]
# # connect_bd_net [get_bd_pins xlslice_0/Dout] [get_bd_pins aurora_64b66b_0/rxp]
# # copy_bd_objs /  [get_bd_cells {xlslice_0}]
# # delete_bd_objs [get_bd_nets rxn_0_1]
# # connect_bd_net [get_bd_ports io_gt_qsfp_00_grx_n] [get_bd_pins xlslice_1/Din]
# # connect_bd_net [get_bd_pins xlslice_1/Dout] [get_bd_pins aurora_64b66b_0/rxn]

# # set_property -dict [list CONFIG.IN2_WIDTH.VALUE_SRC USER] [get_bd_cells xlconcat_1]
# # set_property -dict [list CONFIG.NUM_PORTS {3} CONFIG.IN0_WIDTH {1} CONFIG.IN1_WIDTH {1} CONFIG.IN2_WIDTH {2} ] [get_bd_cells xlconcat_1]
# # set_property -dict [list CONFIG.IN2_WIDTH.VALUE_SRC USER] [get_bd_cells xlconcat_2]
# # set_property -dict [list CONFIG.NUM_PORTS {3} CONFIG.IN0_WIDTH {1} CONFIG.IN1_WIDTH {1} CONFIG.IN2_WIDTH {2} ] [get_bd_cells xlconcat_2]

# # # delete_bd_objs [get_bd_nets xlconstant_0_dout]
# # connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins xlconcat_1/In2]
# # connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins xlconcat_2/In2]

# # create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2

# # set_property -dict [list CONFIG.DIN_WIDTH {2}] [get_bd_cells xlslice_2]
# # copy_bd_objs /  [get_bd_cells {xlslice_2}]
# # copy_bd_objs /  [get_bd_cells {xlslice_2}]
# # copy_bd_objs /  [get_bd_cells {xlslice_2}]
# # set_property -dict [list CONFIG.DIN_TO {1} CONFIG.DIN_FROM {1} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_3]
# # set_property -dict [list CONFIG.DIN_TO {1} CONFIG.DIN_FROM {1} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_5]
# # connect_bd_net [get_bd_pins aurora_64b66b_0/txp] [get_bd_pins xlslice_2/Din]
# # connect_bd_net [get_bd_pins xlslice_3/Din] [get_bd_pins aurora_64b66b_0/txp]
# # connect_bd_net [get_bd_pins aurora_64b66b_0/txn] [get_bd_pins xlslice_4/Din]
# # connect_bd_net [get_bd_pins xlslice_5/Din] [get_bd_pins aurora_64b66b_0/txn]
# # connect_bd_net [get_bd_pins xlslice_2/Dout] [get_bd_pins xlconcat_2/In0]

# # # delete_bd_objs [get_bd_nets aurora_64b66b_0_txp]
# # connect_bd_net [get_bd_pins xlslice_3/Dout] [get_bd_pins xlconcat_2/In1]


# # connect_bd_net [get_bd_pins xlslice_4/Dout] [get_bd_pins xlconcat_1/In0]
# # connect_bd_net [get_bd_pins xlslice_5/Dout] [get_bd_pins xlconcat_1/In1]


# #1lane 

# create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_1
# set_property -dict [list CONFIG.IN0_WIDTH.VALUE_SRC USER CONFIG.IN1_WIDTH.VALUE_SRC USER] [get_bd_cells xlconcat_1]
# set_property -dict [list CONFIG.NUM_PORTS {4} CONFIG.IN0_WIDTH {1} CONFIG.IN1_WIDTH {1} CONFIG.IN2_WIDTH {1} CONFIG.IN3_WIDTH {1}] [get_bd_cells xlconcat_1]
# delete_bd_objs [get_bd_nets aurora_64b66b_0_txn]
# connect_bd_net [get_bd_ports io_gt_qsfp_00_gtx_n] [get_bd_pins xlconcat_1/dout]

# create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
# set_property -dict [list CONFIG.CONST_WIDTH {1} CONFIG.CONST_VAL {0}] [get_bd_cells xlconstant_0]
# # connect_bd_net [get_bd_pins xlconcat_1/In0] [get_bd_pins xlconstant_0/dout]
# # connect_bd_net [get_bd_pins aurora_64b66b_0/txn] [get_bd_pins xlconcat_1/In1]

# copy_bd_objs /  [get_bd_cells {xlconcat_1}]
# delete_bd_objs [get_bd_nets aurora_64b66b_0_txp]
# connect_bd_net [get_bd_ports io_gt_qsfp_00_gtx_p] [get_bd_pins xlconcat_2/dout]
# # connect_bd_net [get_bd_pins xlconcat_2/In1] [get_bd_pins aurora_64b66b_0/txp]
# # connect_bd_net [get_bd_pins xlconcat_2/In0] [get_bd_pins xlconstant_0/dout]

# create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0
# set_property -dict [list CONFIG.DIN_FROM {3} CONFIG.DIN_TO {3} CONFIG.DIN_WIDTH {4} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_0]
# delete_bd_objs [get_bd_nets rxp_0_1]
# connect_bd_net [get_bd_ports io_gt_qsfp_00_grx_p] [get_bd_pins xlslice_0/Din]
# connect_bd_net [get_bd_pins xlslice_0/Dout] [get_bd_pins aurora_64b66b_0/rxp]
# copy_bd_objs /  [get_bd_cells {xlslice_0}]
# delete_bd_objs [get_bd_nets rxn_0_1]
# connect_bd_net [get_bd_ports io_gt_qsfp_00_grx_n] [get_bd_pins xlslice_1/Din]
# connect_bd_net [get_bd_pins xlslice_1/Dout] [get_bd_pins aurora_64b66b_0/rxn]


# # delete_bd_objs [get_bd_nets xlconstant_0_dout]
# connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins xlconcat_1/In0]
# connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins xlconcat_1/In1]
# connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins xlconcat_1/In2]
# connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins xlconcat_2/In0]
# connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins xlconcat_2/In1]
# connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins xlconcat_2/In2]

# create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2

# # set_property -dict [list CONFIG.DIN_WIDTH {2}] [get_bd_cells xlslice_2]
# # copy_bd_objs /  [get_bd_cells {xlslice_2}]
# # copy_bd_objs /  [get_bd_cells {xlslice_2}]
# # copy_bd_objs /  [get_bd_cells {xlslice_2}]
# # set_property -dict [list CONFIG.DIN_TO {1} CONFIG.DIN_FROM {1} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_3]
# # set_property -dict [list CONFIG.DIN_TO {1} CONFIG.DIN_FROM {1} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_5]
# # connect_bd_net [get_bd_pins aurora_64b66b_0/txp] [get_bd_pins xlslice_2/Din]
# # connect_bd_net [get_bd_pins xlslice_3/Din] [get_bd_pins aurora_64b66b_0/txp]
# # connect_bd_net [get_bd_pins aurora_64b66b_0/txn] [get_bd_pins xlslice_4/Din]
# # connect_bd_net [get_bd_pins xlslice_5/Din] [get_bd_pins aurora_64b66b_0/txn]
# # connect_bd_net [get_bd_pins xlslice_2/Dout] [get_bd_pins xlconcat_2/In0]
# connect_bd_net [get_bd_pins aurora_64b66b_0/txp] [get_bd_pins xlconcat_2/In3]
# connect_bd_net [get_bd_pins aurora_64b66b_0/txn] [get_bd_pins xlconcat_1/In3]

# # delete_bd_objs [get_bd_nets aurora_64b66b_0_txp]
# # connect_bd_net [get_bd_pins xlslice_3/Dout] [get_bd_pins xlconcat_2/In1]


# # connect_bd_net [get_bd_pins xlslice_4/Dout] [get_bd_pins xlconcat_1/In0]
# # connect_bd_net [get_bd_pins xlslice_5/Dout] [get_bd_pins xlconcat_1/In1]


# #double aurora hook
# create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_64b66b:12.0 aurora_64b66b_1
# # set_property -dict [list CONFIG.CHANNEL_ENABLE {X0Y29 X0Y30 X0Y31} CONFIG.C_AURORA_LANES {3} CONFIG.C_LINE_RATE {25.78125} CONFIG.C_REFCLK_FREQUENCY {161.1328125} CONFIG.interface_mode {Streaming} CONFIG.C_UCOLUMN_USED {left} CONFIG.C_START_QUAD {Quad_X0Y7} CONFIG.C_START_LANE {X0Y29} CONFIG.C_REFCLK_SOURCE {MGTREFCLK0_of_Quad_X0Y7} CONFIG.C_GT_LOC_3 {3} CONFIG.C_GT_LOC_2 {2}] [get_bd_cells aurora_64b66b_1]
# set_property -dict [list CONFIG.CHANNEL_ENABLE {X0Y29} CONFIG.C_AURORA_LANES {1} CONFIG.C_LINE_RATE {10.3125} CONFIG.C_REFCLK_FREQUENCY {161.1328125} CONFIG.interface_mode {Streaming} CONFIG.C_UCOLUMN_USED {left} CONFIG.C_START_QUAD {Quad_X0Y7} CONFIG.C_START_LANE {X0Y29} CONFIG.C_REFCLK_SOURCE {MGTREFCLK0_of_Quad_X0Y7}] [get_bd_cells aurora_64b66b_1]
# connect_bd_net [get_bd_pins aurora_64b66b_1/gt_qpllrefclk_quad1_in] [get_bd_pins aurora_64b66b_0/gt_qpllrefclk_quad1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_0/gt_qpllclk_quad1_out] [get_bd_pins aurora_64b66b_1/gt_qpllclk_quad1_in]
# connect_bd_net [get_bd_pins aurora_64b66b_0/gt_refclk1_out] [get_bd_pins aurora_64b66b_1/refclk1_in]
# connect_bd_net [get_bd_pins aurora_64b66b_1/user_clk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins aurora_64b66b_1/sync_clk] [get_bd_pins aurora_64b66b_0/sync_clk_out]
# connect_bd_net [get_bd_pins aurora_64b66b_1/gt_qplllock_quad1_in] [get_bd_pins aurora_64b66b_0/gt_qplllock_quad1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_1/gt_qpllrefclklost_quad1] [get_bd_pins aurora_64b66b_0/gt_qpllrefclklost_quad1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_1/reset_pb] [get_bd_pins proc_sys_reset_0/peripheral_reset]
# connect_bd_net [get_bd_pins aurora_64b66b_1/pma_init] [get_bd_pins xlconstant_low/dout]
# connect_bd_net [get_bd_pins aurora_64b66b_1/init_clk] [get_bd_pins ii_level0_wire/ulp_m_aclk_freerun_ref_00]
# connect_bd_net [get_bd_pins aurora_64b66b_1/channel_up] [get_bd_pins xlconcat_0/In10]
# connect_bd_net [get_bd_pins aurora_64b66b_1/gt_pll_lock] [get_bd_pins xlconcat_0/In11]
# connect_bd_net [get_bd_pins aurora_64b66b_1/gt_to_common_qpllreset_out] [get_bd_pins xlconcat_0/In12]
# connect_bd_net [get_bd_pins aurora_64b66b_1/hard_err] [get_bd_pins xlconcat_0/In13]
# connect_bd_net [get_bd_pins aurora_64b66b_1/lane_up] [get_bd_pins xlconcat_0/In14]
# connect_bd_net [get_bd_pins aurora_64b66b_1/soft_err] [get_bd_pins xlconcat_0/In15]


# # connect_bd_net [get_bd_pins xlconstant_0lb/dout] [get_bd_pins aurora_64b66b_1/loopback]

# #1lane + 3lane hook
# delete_bd_objs [get_bd_nets xlconstant_0_dout]
# create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3
# set_property -dict [list CONFIG.DIN_WIDTH {3}] [get_bd_cells xlslice_3]
# copy_bd_objs /  [get_bd_cells {xlslice_3}]
# copy_bd_objs /  [get_bd_cells {xlslice_3}]
# copy_bd_objs /  [get_bd_cells {xlslice_3}]
# copy_bd_objs /  [get_bd_cells {xlslice_3}]
# copy_bd_objs /  [get_bd_cells {xlslice_3}]
# connect_bd_net [get_bd_pins aurora_64b66b_1/txn] [get_bd_pins xlslice_3/Din]
# connect_bd_net [get_bd_pins aurora_64b66b_1/txp] [get_bd_pins xlslice_6/Din]
# set_property -dict [list CONFIG.DIN_TO {1} CONFIG.DIN_FROM {1} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_4]
# set_property -dict [list CONFIG.DIN_TO {1} CONFIG.DIN_FROM {1} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_7]
# set_property -dict [list CONFIG.DIN_TO {2} CONFIG.DIN_FROM {2} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_5]
# set_property -dict [list CONFIG.DIN_TO {2} CONFIG.DIN_FROM {2} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_8]
# connect_bd_net [get_bd_pins xlslice_4/Din] [get_bd_pins aurora_64b66b_1/txn]
# connect_bd_net [get_bd_pins xlslice_5/Din] [get_bd_pins aurora_64b66b_1/txn]
# connect_bd_net [get_bd_pins xlslice_7/Din] [get_bd_pins aurora_64b66b_1/txp]
# connect_bd_net [get_bd_pins xlslice_8/Din] [get_bd_pins aurora_64b66b_1/txp]
# connect_bd_net [get_bd_pins xlslice_3/Dout] [get_bd_pins xlconcat_1/In2]
# connect_bd_net [get_bd_pins xlslice_4/Dout] [get_bd_pins xlconcat_1/In1]
# connect_bd_net [get_bd_pins xlslice_5/Dout] [get_bd_pins xlconcat_1/In0]
# connect_bd_net [get_bd_pins xlslice_8/Dout] [get_bd_pins xlconcat_2/In0]
# connect_bd_net [get_bd_pins xlslice_7/Dout] [get_bd_pins xlconcat_2/In1]
# connect_bd_net [get_bd_pins xlslice_6/Dout] [get_bd_pins xlconcat_2/In2]
# copy_bd_objs /  [get_bd_cells {xlslice_3}]
# set_property -dict [list CONFIG.DIN_FROM {2} CONFIG.DIN_WIDTH {4} CONFIG.DOUT_WIDTH {3}] [get_bd_cells xlslice_9]
# copy_bd_objs /  [get_bd_cells {xlslice_9}]
# connect_bd_net [get_bd_ports io_gt_qsfp_00_grx_n] [get_bd_pins xlslice_10/Din]
# connect_bd_net [get_bd_pins xlslice_10/Dout] [get_bd_pins aurora_64b66b_1/rxn]
# connect_bd_net [get_bd_pins xlslice_9/Dout] [get_bd_pins aurora_64b66b_1/rxp]
# connect_bd_net [get_bd_ports io_gt_qsfp_00_grx_p] [get_bd_pins xlslice_9/Din]

# #hook them up 3+1
# delete_bd_objs [get_bd_intf_nets axis_clock_converter_outbound_M_AXIS]
# create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
# connect_bd_intf_net [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins axis_clock_converter_outbound/M_AXIS]
# connect_bd_net [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]

# create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0
# copy_bd_objs /  [get_bd_cells {axis_subset_converter_0}]
# connect_bd_intf_net [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins axis_subset_converter_1/S_AXIS]
# connect_bd_net [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_subset_converter_1/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
# connect_bd_net [get_bd_pins axis_subset_converter_1/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]

# set_property -dict [list CONFIG.S_TDATA_NUM_BYTES.VALUE_SRC USER CONFIG.M_TDATA_NUM_BYTES.VALUE_SRC USER] [get_bd_cells axis_subset_converter_0]
# set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {32} CONFIG.M_TDATA_NUM_BYTES {8} CONFIG.TDATA_REMAP {tdata[63:0]}] [get_bd_cells axis_subset_converter_0]
# set_property -dict [list CONFIG.S_TDATA_NUM_BYTES.VALUE_SRC USER CONFIG.M_TDATA_NUM_BYTES.VALUE_SRC USER] [get_bd_cells axis_subset_converter_1]
# set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {32} CONFIG.M_TDATA_NUM_BYTES {24} CONFIG.TDATA_REMAP {tdata[255:64]}] [get_bd_cells axis_subset_converter_1]
# connect_bd_intf_net [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins aurora_64b66b_0/USER_DATA_S_AXIS_TX]
# connect_bd_intf_net [get_bd_intf_pins axis_subset_converter_1/M_AXIS] [get_bd_intf_pins aurora_64b66b_1/USER_DATA_S_AXIS_TX]
# delete_bd_objs [get_bd_intf_nets aurora_64b66b_0_USER_DATA_M_AXIS_RX]




# create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
# set_property -dict [list CONFIG.TDATA_NUM_BYTES.VALUE_SRC USER] [get_bd_cells axis_combiner_0]
# set_property -dict [list CONFIG.TDATA_NUM_BYTES {8} CONFIG.NUM_SI {4}] [get_bd_cells axis_combiner_0]
# create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_11
# set_property -dict [list CONFIG.DIN_TO {64} CONFIG.DIN_FROM {127} CONFIG.DIN_WIDTH {192} CONFIG.DOUT_WIDTH {64}] [get_bd_cells xlslice_11]
# create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0
# set_property -dict [list CONFIG.TDATA_NUM_BYTES.VALUE_SRC USER] [get_bd_cells axis_register_slice_0]
# set_property -dict [list CONFIG.TDATA_NUM_BYTES {8}] [get_bd_cells axis_register_slice_0]
# copy_bd_objs /  [get_bd_cells {axis_register_slice_0}]
# copy_bd_objs /  [get_bd_cells {axis_register_slice_0}]
# connect_bd_net [get_bd_pins axis_register_slice_0/s_axis_tvalid] [get_bd_pins axis_register_slice_1/s_axis_tvalid]
# connect_bd_net [get_bd_pins axis_register_slice_2/s_axis_tvalid] [get_bd_pins axis_register_slice_0/s_axis_tvalid]
# copy_bd_objs /  [get_bd_cells {xlslice_11}]
# copy_bd_objs /  [get_bd_cells {xlslice_11}]
# set_property -dict [list CONFIG.DIN_TO {0} CONFIG.DIN_FROM {63}] [get_bd_cells xlslice_11]
# set_property -dict [list CONFIG.DIN_TO {128} CONFIG.DIN_FROM {191} CONFIG.DOUT_WIDTH {64}] [get_bd_cells xlslice_13]
# connect_bd_net [get_bd_pins xlslice_13/Dout] [get_bd_pins axis_register_slice_2/s_axis_tdata]
# connect_bd_net [get_bd_pins xlslice_12/Dout] [get_bd_pins axis_register_slice_1/s_axis_tdata]
# connect_bd_net [get_bd_pins xlslice_11/Dout] [get_bd_pins axis_register_slice_0/s_axis_tdata]
# connect_bd_net [get_bd_pins xlslice_11/Din] [get_bd_pins aurora_64b66b_1/m_axi_rx_tdata]
# connect_bd_net [get_bd_pins xlslice_13/Din] [get_bd_pins aurora_64b66b_1/m_axi_rx_tdata]
# connect_bd_net [get_bd_pins xlslice_12/Din] [get_bd_pins aurora_64b66b_1/m_axi_rx_tdata]
# connect_bd_net [get_bd_pins aurora_64b66b_1/m_axi_rx_tvalid] [get_bd_pins axis_register_slice_0/s_axis_tvalid]
# connect_bd_net [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_register_slice_1/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_register_slice_2/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_combiner_0/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_combiner_0/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
# delete_bd_objs [get_bd_intf_nets aurora_64b66b_0_USER_DATA_M_AXIS_RX]
# connect_bd_intf_net [get_bd_intf_pins axis_combiner_0/M_AXIS] [get_bd_intf_pins axis_clock_converter_inbound/S_AXIS]
# create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1
# set_property -dict [list CONFIG.TDATA_NUM_BYTES.VALUE_SRC USER] [get_bd_cells axis_data_fifo_1]
# set_property -dict [list CONFIG.TDATA_NUM_BYTES {8} CONFIG.FIFO_DEPTH {4096}] [get_bd_cells axis_data_fifo_1]
# copy_bd_objs /  [get_bd_cells {axis_data_fifo_1}]
# copy_bd_objs /  [get_bd_cells {axis_data_fifo_1}]
# connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_3/M_AXIS] [get_bd_intf_pins axis_combiner_0/S03_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_2/M_AXIS] [get_bd_intf_pins axis_combiner_0/S02_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_1/M_AXIS] [get_bd_intf_pins axis_combiner_0/S01_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_register_slice_0/M_AXIS] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_register_slice_1/M_AXIS] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_register_slice_2/M_AXIS] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]
# connect_bd_net [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_register_slice_2/aresetn]  [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
# connect_bd_net [get_bd_pins axis_register_slice_2/aresetn] [get_bd_pins axis_register_slice_0/aresetn]
# connect_bd_net [get_bd_pins axis_register_slice_1/aresetn] [get_bd_pins axis_register_slice_2/aresetn]
# connect_bd_net [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_register_slice_2/aresetn]
# connect_bd_net [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_register_slice_2/aresetn]
# connect_bd_net [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_register_slice_2/aresetn]
# copy_bd_objs /  [get_bd_cells {axis_data_fifo_1 axis_register_slice_0}]
# connect_bd_intf_net [get_bd_intf_pins aurora_64b66b_0/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axis_register_slice_3/S_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_register_slice_3/M_AXIS] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_4/M_AXIS] [get_bd_intf_pins axis_combiner_0/S00_AXIS]
# connect_bd_net [get_bd_pins axis_register_slice_3/aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk]
# connect_bd_net [get_bd_pins axis_register_slice_3/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_register_slice_3/aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn]
# connect_bd_net [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_register_slice_3/aresetn]


# create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5
# delete_bd_objs [get_bd_intf_nets axis_subset_converter_0_M_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
# connect_bd_net [get_bd_pins axis_data_fifo_5/s_axis_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
# connect_bd_net [get_bd_pins axis_data_fifo_5/s_axis_aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# set_property -dict [list CONFIG.TDATA_NUM_BYTES.VALUE_SRC USER] [get_bd_cells axis_data_fifo_5]
# set_property -dict [list CONFIG.TDATA_NUM_BYTES {8} CONFIG.FIFO_DEPTH {4096}] [get_bd_cells axis_data_fifo_5]
# connect_bd_net [get_bd_pins axis_data_fifo_5/m_axis_tdata] [get_bd_pins aurora_64b66b_0/s_axi_tx_tdata]
# copy_bd_objs /  [get_bd_cells {axis_data_fifo_5}]
# set_property -dict [list CONFIG.TDATA_NUM_BYTES {24} CONFIG.FIFO_DEPTH {4096}] [get_bd_cells axis_data_fifo_6]
# delete_bd_objs [get_bd_intf_nets axis_subset_converter_1_M_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_6/S_AXIS] [get_bd_intf_pins axis_subset_converter_1/M_AXIS]
# connect_bd_net [get_bd_pins axis_data_fifo_6/s_axis_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
# connect_bd_net [get_bd_pins axis_data_fifo_6/s_axis_aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_data_fifo_6/m_axis_tdata] [get_bd_pins aurora_64b66b_1/s_axi_tx_tdata]
# create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0
# set_property -dict [list CONFIG.C_SIZE {1}] [get_bd_cells util_vector_logic_0]
# connect_bd_net [get_bd_pins aurora_64b66b_0/s_axi_tx_tready] [get_bd_pins util_vector_logic_0/Op1]
# connect_bd_net [get_bd_pins aurora_64b66b_1/s_axi_tx_tready] [get_bd_pins util_vector_logic_0/Op2]
# copy_bd_objs /  [get_bd_cells {util_vector_logic_0}]
# connect_bd_net [get_bd_pins axis_data_fifo_5/m_axis_tvalid] [get_bd_pins util_vector_logic_1/Op1]
# connect_bd_net [get_bd_pins axis_data_fifo_6/m_axis_tvalid] [get_bd_pins util_vector_logic_1/Op2]
# copy_bd_objs /  [get_bd_cells {util_vector_logic_0}]
# connect_bd_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins util_vector_logic_2/Op1]
# connect_bd_net [get_bd_pins util_vector_logic_1/Res] [get_bd_pins util_vector_logic_2/Op2]
# connect_bd_net [get_bd_pins axis_data_fifo_5/m_axis_tready] [get_bd_pins util_vector_logic_0/Res]
# connect_bd_net [get_bd_pins axis_data_fifo_6/m_axis_tready] [get_bd_pins util_vector_logic_0/Res]
# connect_bd_net [get_bd_pins util_vector_logic_2/Res] [get_bd_pins aurora_64b66b_0/s_axi_tx_tvalid]
# connect_bd_net [get_bd_pins aurora_64b66b_1/s_axi_tx_tvalid] [get_bd_pins util_vector_logic_2/Res]

# # copy_bd_objs /  [get_bd_cells {axis_data_fifo_1}]
# # copy_bd_objs /  [get_bd_cells {axis_data_fifo_1}]

# # set_property -dict [list CONFIG.FIFO_DEPTH {4096}] [get_bd_cells axis_data_fifo_4]
# # set_property -dict [list CONFIG.FIFO_DEPTH {4096} CONFIG.TDATA_NUM_BYTES {24} ] [get_bd_cells axis_data_fifo_5]

# # delete_bd_objs [get_bd_intf_nets aurora_64b66b_0_USER_DATA_M_AXIS_RX]
# # connect_bd_intf_net [get_bd_intf_pins aurora_64b66b_0/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
# # connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_5/M_AXIS] [get_bd_intf_pins axis_combiner_0/S00_AXIS]
# # connect_bd_net [get_bd_pins axis_data_fifo_5/s_axis_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
# # connect_bd_net [get_bd_pins axis_data_fifo_5/s_axis_aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]

# # connect_bd_net [get_bd_pins axis_data_fifo_5/s_axis_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
# # connect_bd_net [get_bd_pins axis_data_fifo_5/s_axis_aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# # delete_bd_objs [get_bd_intf_nets aurora_64b66b_1_USER_DATA_M_AXIS_RX]
# # connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_5/M_AXIS] [get_bd_intf_pins axis_combiner_0/S01_AXIS]
# # connect_bd_intf_net [get_bd_intf_pins aurora_64b66b_1/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]


# # #1lane + 1lane hook
# # delete_bd_objs [get_bd_nets xlconstant_0_dout]
# # create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3
# # set_property -dict [list CONFIG.DIN_WIDTH {3}] [get_bd_cells xlslice_3]
# # copy_bd_objs /  [get_bd_cells {xlslice_3}]

# # connect_bd_net [get_bd_pins aurora_64b66b_1/txn] [get_bd_pins xlslice_3/Din]
# # set_property -dict [list CONFIG.DIN_TO {2} CONFIG.DIN_FROM {2} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_4]
# # set_property -dict [list CONFIG.DIN_TO {2} CONFIG.DIN_FROM {2} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_3]
# # connect_bd_net [get_bd_pins xlslice_4/Din] [get_bd_pins aurora_64b66b_1/txp]
# # connect_bd_net [get_bd_pins xlslice_3/Dout] [get_bd_pins xlconcat_1/In2]
# # connect_bd_net [get_bd_pins xlslice_4/Dout] [get_bd_pins xlconcat_2/In2]
# # connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins xlconcat_1/In0]
# # connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins xlconcat_2/In0]
# # connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins xlconcat_1/In1]
# # connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins xlconcat_2/In1]
# # create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslicerx_3
# # set_property -dict [list CONFIG.DIN_TO {2} CONFIG.DIN_FROM {2} CONFIG.DIN_WIDTH {4} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslicerx_3]
# # copy_bd_objs /  [get_bd_cells {xlslicerx_3}]
# # connect_bd_net [get_bd_ports io_gt_qsfp_00_grx_n] [get_bd_pins xlslicerx_4/Din]
# # connect_bd_net [get_bd_pins xlslicerx_4/Dout] [get_bd_pins aurora_64b66b_1/rxn]
# # connect_bd_net [get_bd_pins xlslicerx_3/Dout] [get_bd_pins aurora_64b66b_1/rxp]
# # connect_bd_net [get_bd_ports io_gt_qsfp_00_grx_p] [get_bd_pins xlslicerx_3/Din]


# #hook them up 1+1
# # delete_bd_objs [get_bd_intf_nets axis_clock_converter_outbound_M_AXIS]
# # create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
# # connect_bd_intf_net [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins axis_clock_converter_outbound/M_AXIS]
# # connect_bd_net [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# # connect_bd_net [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]

# # create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0
# # copy_bd_objs /  [get_bd_cells {axis_subset_converter_0}]
# # connect_bd_intf_net [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]
# # connect_bd_intf_net [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins axis_subset_converter_1/S_AXIS]
# # connect_bd_net [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# # connect_bd_net [get_bd_pins axis_subset_converter_1/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# # connect_bd_net [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
# # connect_bd_net [get_bd_pins axis_subset_converter_1/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]

# # set_property -dict [list CONFIG.S_TDATA_NUM_BYTES.VALUE_SRC USER CONFIG.M_TDATA_NUM_BYTES.VALUE_SRC USER] [get_bd_cells axis_subset_converter_0]
# # set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {16} CONFIG.M_TDATA_NUM_BYTES {8} CONFIG.TDATA_REMAP {tdata[63:0]}] [get_bd_cells axis_subset_converter_0]
# # set_property -dict [list CONFIG.S_TDATA_NUM_BYTES.VALUE_SRC USER CONFIG.M_TDATA_NUM_BYTES.VALUE_SRC USER] [get_bd_cells axis_subset_converter_1]
# # set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {16} CONFIG.M_TDATA_NUM_BYTES {8} CONFIG.TDATA_REMAP {tdata[127:64]}] [get_bd_cells axis_subset_converter_1]
# # connect_bd_intf_net [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins aurora_64b66b_0/USER_DATA_S_AXIS_TX]
# # connect_bd_intf_net [get_bd_intf_pins axis_subset_converter_1/M_AXIS] [get_bd_intf_pins aurora_64b66b_1/USER_DATA_S_AXIS_TX]
# # delete_bd_objs [get_bd_intf_nets aurora_64b66b_0_USER_DATA_M_AXIS_RX]

# # create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
# # set_property -dict [list CONFIG.NUM_SI {2}] [get_bd_cells axis_combiner_0]
# # connect_bd_intf_net [get_bd_intf_pins aurora_64b66b_0/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axis_combiner_0/S00_AXIS]
# # connect_bd_intf_net [get_bd_intf_pins aurora_64b66b_1/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axis_combiner_0/S01_AXIS]
# # connect_bd_intf_net [get_bd_intf_pins axis_combiner_0/M_AXIS] [get_bd_intf_pins axis_clock_converter_inbound/S_AXIS]
# # connect_bd_net [get_bd_pins axis_combiner_0/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# # connect_bd_net [get_bd_pins axis_combiner_0/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]




# #4-way split 

# # set_property -dict [list CONFIG.CHANNEL_ENABLE {X0Y29} CONFIG.C_AURORA_LANES {1} CONFIG.C_GT_LOC_3 {X} CONFIG.C_GT_LOC_2 {X}] [get_bd_cells aurora_64b66b_1]
# create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_64b66b:12.0 aurora_64b66b_2
# copy_bd_objs /  [get_bd_cells {aurora_64b66b_2}]
# set_property -dict [list CONFIG.CHANNEL_ENABLE {X0Y30} CONFIG.C_REFCLK_FREQUENCY {161.1328125} CONFIG.interface_mode {Streaming} CONFIG.C_UCOLUMN_USED {left} CONFIG.C_START_QUAD {Quad_X0Y7} CONFIG.C_START_LANE {X0Y30} CONFIG.C_REFCLK_SOURCE {MGTREFCLK0_of_Quad_X0Y7}] [get_bd_cells aurora_64b66b_2]
# # set_property -dict [list CONFIG.CHANNEL_ENABLE {X0Y31} CONFIG.C_REFCLK_FREQUENCY {161.1328125} CONFIG.interface_mode {Streaming} CONFIG.C_UCOLUMN_USED {left} CONFIG.C_START_QUAD {Quad_X0Y7} CONFIG.C_START_LANE {X0Y31} CONFIG.C_REFCLK_SOURCE {MGTREFCLK0_of_Quad_X0Y7}] [get_bd_cells aurora_64b66b_3]
# set_property -dict [list CONFIG.CHANNEL_ENABLE {X0Y28} CONFIG.C_REFCLK_FREQUENCY {161.1328125} CONFIG.interface_mode {Streaming} CONFIG.C_UCOLUMN_USED {left} CONFIG.C_START_QUAD {Quad_X0Y7} CONFIG.C_START_LANE {X0Y28} CONFIG.C_REFCLK_SOURCE {MGTREFCLK0_of_Quad_X0Y7}] [get_bd_cells aurora_64b66b_3]
# set_property -dict [list CONFIG.C_LINE_RATE {10.3125} CONFIG.C_REFCLK_FREQUENCY {161.1328125}] [get_bd_cells aurora_64b66b_3]
# set_property -dict [list CONFIG.C_LINE_RATE {10.3125} CONFIG.C_REFCLK_FREQUENCY {161.1328125}] [get_bd_cells aurora_64b66b_2]

# connect_bd_net [get_bd_pins aurora_64b66b_3/refclk1_in] [get_bd_pins aurora_64b66b_0/gt_refclk1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_3/user_clk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins aurora_64b66b_3/sync_clk] [get_bd_pins aurora_64b66b_0/sync_clk_out]
# connect_bd_net [get_bd_pins aurora_64b66b_3/gt_qpllclk_quad1_in] [get_bd_pins aurora_64b66b_0/gt_qpllclk_quad1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_3/gt_qpllrefclk_quad1_in] [get_bd_pins aurora_64b66b_0/gt_qpllrefclk_quad1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_3/gt_qplllock_quad1_in] [get_bd_pins aurora_64b66b_0/gt_qplllock_quad1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_3/gt_qpllrefclklost_quad1] [get_bd_pins aurora_64b66b_0/gt_qpllrefclklost_quad1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_3/reset_pb] [get_bd_pins proc_sys_reset_0/peripheral_reset]
# connect_bd_net [get_bd_pins aurora_64b66b_3/pma_init] [get_bd_pins xlconstant_low/dout]
# connect_bd_net [get_bd_pins aurora_64b66b_3/init_clk] [get_bd_pins ii_level0_wire/ulp_m_aclk_freerun_ref_00]
# connect_bd_net [get_bd_pins aurora_64b66b_2/refclk1_in] [get_bd_pins aurora_64b66b_0/gt_refclk1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_2/user_clk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins aurora_64b66b_2/sync_clk] [get_bd_pins aurora_64b66b_0/sync_clk_out]
# connect_bd_net [get_bd_pins aurora_64b66b_2/gt_qpllclk_quad1_in] [get_bd_pins aurora_64b66b_0/gt_qpllclk_quad1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_2/gt_qpllrefclk_quad1_in] [get_bd_pins aurora_64b66b_0/gt_qpllrefclk_quad1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_2/gt_qplllock_quad1_in] [get_bd_pins aurora_64b66b_0/gt_qplllock_quad1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_2/gt_qpllrefclklost_quad1] [get_bd_pins aurora_64b66b_0/gt_qpllrefclklost_quad1_out]
# connect_bd_net [get_bd_pins aurora_64b66b_2/reset_pb] [get_bd_pins proc_sys_reset_0/peripheral_reset]
# connect_bd_net [get_bd_pins aurora_64b66b_2/pma_init] [get_bd_pins xlconstant_low/dout]
# connect_bd_net [get_bd_pins aurora_64b66b_2/init_clk] [get_bd_pins ii_level0_wire/ulp_m_aclk_freerun_ref_00]

# delete_bd_objs [get_bd_nets aurora_64b66b_1_txn]
# delete_bd_objs [get_bd_nets xlslice_3_Dout] [get_bd_cells xlslice_3]
# connect_bd_net [get_bd_pins aurora_64b66b_1/txn] [get_bd_pins xlconcat_1/In2]
# delete_bd_objs [get_bd_nets xlslice_4_Dout] [get_bd_cells xlslice_4]
# connect_bd_net [get_bd_pins aurora_64b66b_2/txn] [get_bd_pins xlconcat_1/In1]
# delete_bd_objs [get_bd_nets xlslice_5_Dout] [get_bd_cells xlslice_5]
# connect_bd_net [get_bd_pins aurora_64b66b_3/txn] [get_bd_pins xlconcat_1/In0]
# delete_bd_objs [get_bd_nets aurora_64b66b_1_txp]
# delete_bd_objs [get_bd_nets xlslice_6_Dout] [get_bd_cells xlslice_6]
# connect_bd_net [get_bd_pins aurora_64b66b_1/txp] [get_bd_pins xlconcat_2/In2]
# delete_bd_objs [get_bd_nets xlslice_7_Dout] [get_bd_cells xlslice_7]
# connect_bd_net [get_bd_pins aurora_64b66b_2/txp] [get_bd_pins xlconcat_2/In1]
# delete_bd_objs [get_bd_nets xlslice_8_Dout] [get_bd_cells xlslice_8]
# connect_bd_net [get_bd_pins aurora_64b66b_3/txp] [get_bd_pins xlconcat_2/In0]

# set_property -dict [list CONFIG.DIN_TO {2} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_10]
# set_property -dict [list CONFIG.DIN_TO {2} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_9]
# create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3
# set_property -dict [list CONFIG.DIN_TO {1} CONFIG.DIN_FROM {1} CONFIG.DIN_WIDTH {4} CONFIG.DOUT_WIDTH {1}] [get_bd_cells xlslice_3]
# copy_bd_objs /  [get_bd_cells {xlslice_3}]
# copy_bd_objs /  [get_bd_cells {xlslice_3}]
# copy_bd_objs /  [get_bd_cells {xlslice_3}]
# set_property -dict [list CONFIG.DIN_TO {0} CONFIG.DIN_FROM {0}] [get_bd_cells xlslice_5]
# set_property -dict [list CONFIG.DIN_TO {0} CONFIG.DIN_FROM {0}] [get_bd_cells xlslice_6]

# connect_bd_net [get_bd_ports io_gt_qsfp_00_grx_n] [get_bd_pins xlslice_3/Din]
# connect_bd_net [get_bd_ports io_gt_qsfp_00_grx_n] [get_bd_pins xlslice_5/Din]
# connect_bd_net [get_bd_pins xlslice_5/Dout] [get_bd_pins aurora_64b66b_3/rxn]
# connect_bd_net [get_bd_pins aurora_64b66b_2/rxn] [get_bd_pins xlslice_3/Dout]
# connect_bd_net [get_bd_ports io_gt_qsfp_00_grx_p] [get_bd_pins xlslice_4/Din]
# connect_bd_net [get_bd_ports io_gt_qsfp_00_grx_p] [get_bd_pins xlslice_6/Din]
# connect_bd_net [get_bd_pins aurora_64b66b_3/rxp] [get_bd_pins xlslice_6/Dout]
# connect_bd_net [get_bd_pins aurora_64b66b_2/rxp] [get_bd_pins xlslice_4/Dout]

# # connect_bd_net [get_bd_pins aurora_64b66b_3/loopback] [get_bd_pins xlconstant_0lb/dout]
# # connect_bd_net [get_bd_pins aurora_64b66b_2/loopback] [get_bd_pins xlconstant_0lb/dout]

# delete_bd_objs [get_bd_nets aurora_64b66b_1_m_axi_rx_tdata] [get_bd_nets xlslice_11_Dout] [get_bd_nets xlslice_13_Dout] [get_bd_nets xlslice_12_Dout] [get_bd_cells xlslice_11] [get_bd_cells xlslice_13] [get_bd_cells xlslice_12]

# disconnect_bd_net /Net [get_bd_pins axis_register_slice_1/s_axis_tvalid]
# disconnect_bd_net /Net [get_bd_pins axis_register_slice_2/s_axis_tvalid]

# connect_bd_intf_net [get_bd_intf_pins aurora_64b66b_2/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axis_register_slice_1/S_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_register_slice_0/S_AXIS] [get_bd_intf_pins aurora_64b66b_1/USER_DATA_M_AXIS_RX]
# connect_bd_intf_net [get_bd_intf_pins axis_register_slice_2/S_AXIS] [get_bd_intf_pins aurora_64b66b_3/USER_DATA_M_AXIS_RX]

# set_property -dict [list CONFIG.NUM_MI {4}] [get_bd_cells axis_broadcaster_0]
# create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_2
# set_property -dict [list CONFIG.S_TDATA_NUM_BYTES.VALUE_SRC USER CONFIG.M_TDATA_NUM_BYTES.VALUE_SRC USER] [get_bd_cells axis_subset_converter_2]
# set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {32} CONFIG.M_TDATA_NUM_BYTES {8} CONFIG.TDATA_REMAP {tdata[191:128]}] [get_bd_cells axis_subset_converter_2]
# copy_bd_objs /  [get_bd_cells {axis_subset_converter_2}]
# set_property -dict [list CONFIG.TDATA_REMAP {tdata[255:192]}] [get_bd_cells axis_subset_converter_3]
# set_property -dict [list CONFIG.M_TDATA_NUM_BYTES {8} CONFIG.TDATA_REMAP {tdata[127:64]}] [get_bd_cells axis_subset_converter_1]
# set_property -dict [list CONFIG.TDATA_NUM_BYTES {8}] [get_bd_cells axis_data_fifo_6]
# create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_7
# set_property -dict [list CONFIG.TDATA_NUM_BYTES.VALUE_SRC USER] [get_bd_cells axis_data_fifo_7]
# set_property -dict [list CONFIG.TDATA_NUM_BYTES {8} CONFIG.FIFO_DEPTH {4096}] [get_bd_cells axis_data_fifo_7]
# copy_bd_objs /  [get_bd_cells {axis_data_fifo_7}]
# connect_bd_intf_net [get_bd_intf_pins axis_subset_converter_3/M_AXIS] [get_bd_intf_pins axis_data_fifo_8/S_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_subset_converter_2/M_AXIS] [get_bd_intf_pins axis_data_fifo_7/S_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_broadcaster_0/M02_AXIS] [get_bd_intf_pins axis_subset_converter_2/S_AXIS]
# connect_bd_intf_net [get_bd_intf_pins axis_broadcaster_0/M03_AXIS] [get_bd_intf_pins axis_subset_converter_3/S_AXIS]
# connect_bd_net [get_bd_pins axis_subset_converter_3/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_subset_converter_2/aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_subset_converter_2/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
# connect_bd_net [get_bd_pins axis_subset_converter_3/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
# connect_bd_net [get_bd_pins axis_data_fifo_8/s_axis_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
# connect_bd_net [get_bd_pins axis_data_fifo_8/s_axis_aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_data_fifo_7/s_axis_aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# connect_bd_net [get_bd_pins axis_data_fifo_7/s_axis_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
# connect_bd_net [get_bd_pins aurora_64b66b_2/s_axi_tx_tdata] [get_bd_pins axis_data_fifo_7/m_axis_tdata]
# connect_bd_net [get_bd_pins aurora_64b66b_3/s_axi_tx_tdata] [get_bd_pins axis_data_fifo_8/m_axis_tdata]
# create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_3
# set_property -dict [list CONFIG.C_SIZE {1}] [get_bd_cells util_vector_logic_3]
# copy_bd_objs /  [get_bd_cells {util_vector_logic_3}]
# connect_bd_net [get_bd_pins aurora_64b66b_2/s_axi_tx_tready] [get_bd_pins util_vector_logic_3/Op1]
# connect_bd_net [get_bd_pins aurora_64b66b_3/s_axi_tx_tready] [get_bd_pins util_vector_logic_3/Op2]
# connect_bd_net [get_bd_pins util_vector_logic_3/Res] [get_bd_pins util_vector_logic_4/Op1]
# disconnect_bd_net /util_vector_logic_0_Res [get_bd_pins util_vector_logic_0/Res]
# connect_bd_net [get_bd_pins util_vector_logic_4/Res] [get_bd_pins util_vector_logic_2/Op1]
# connect_bd_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins util_vector_logic_4/Op2]
# copy_bd_objs /  [get_bd_cells {util_vector_logic_4}]
# copy_bd_objs /  [get_bd_cells {util_vector_logic_4}]
# connect_bd_net [get_bd_pins util_vector_logic_5/Res] [get_bd_pins util_vector_logic_6/Op2]
# disconnect_bd_net /util_vector_logic_2_Res [get_bd_pins util_vector_logic_2/Res]
# connect_bd_net [get_bd_pins util_vector_logic_2/Res] [get_bd_pins util_vector_logic_6/Op1]
# connect_bd_net [get_bd_pins util_vector_logic_6/Res] [get_bd_pins aurora_64b66b_0/s_axi_tx_tvalid]
# connect_bd_net [get_bd_pins aurora_64b66b_3/s_axi_tx_tvalid] [get_bd_pins util_vector_logic_6/Res]
# connect_bd_net [get_bd_pins aurora_64b66b_2/s_axi_tx_tvalid] [get_bd_pins util_vector_logic_6/Res]
# connect_bd_net [get_bd_pins util_vector_logic_5/Op1] [get_bd_pins axis_data_fifo_7/m_axis_tvalid]
# connect_bd_net [get_bd_pins util_vector_logic_5/Op2] [get_bd_pins axis_data_fifo_8/m_axis_tvalid]
# connect_bd_net [get_bd_pins axis_data_fifo_7/m_axis_tready] [get_bd_pins util_vector_logic_4/Res]
# connect_bd_net [get_bd_pins axis_data_fifo_8/m_axis_tready] [get_bd_pins util_vector_logic_4/Res]
# delete_bd_objs [get_bd_nets util_vector_logic_2_Res1]
# connect_bd_net [get_bd_pins util_vector_logic_6/Op1] [get_bd_pins util_vector_logic_4/Res]
# disconnect_bd_net /util_vector_logic_0_Res [get_bd_pins util_vector_logic_2/Op1]
# connect_bd_net [get_bd_pins util_vector_logic_5/Res] [get_bd_pins util_vector_logic_2/Op1]
# disconnect_bd_net /util_vector_logic_5_Res [get_bd_pins util_vector_logic_6/Op2]
# connect_bd_net [get_bd_pins util_vector_logic_2/Res] [get_bd_pins util_vector_logic_6/Op2]


# ##chipscope
# # set_property -dict [list CONFIG.C_USE_CHIPSCOPE {true}] [get_bd_cells aurora_64b66b_2]

# # set_property -dict [list CONFIG.C_USE_CHIPSCOPE {true}] [get_bd_cells aurora_64b66b_3]
# connect_bd_net [get_bd_pins xlconcat_0/In16] [get_bd_pins aurora_64b66b_2/channel_up]
# connect_bd_net [get_bd_pins xlconcat_0/In17] [get_bd_pins aurora_64b66b_2/gt_pll_lock]
# connect_bd_net [get_bd_pins xlconcat_0/In18] [get_bd_pins aurora_64b66b_2/gt_to_common_qpllreset_out]
# connect_bd_net [get_bd_pins xlconcat_0/In19] [get_bd_pins aurora_64b66b_2/hard_err]
# connect_bd_net [get_bd_pins xlconcat_0/In20] [get_bd_pins aurora_64b66b_2/lane_up]
# connect_bd_net [get_bd_pins xlconcat_0/In21] [get_bd_pins aurora_64b66b_2/soft_err]
# connect_bd_net [get_bd_pins aurora_64b66b_3/channel_up] [get_bd_pins xlconcat_0/In22]
# connect_bd_net [get_bd_pins xlconcat_0/In23] [get_bd_pins aurora_64b66b_3/gt_pll_lock]
# connect_bd_net [get_bd_pins aurora_64b66b_3/gt_to_common_qpllreset_out] [get_bd_pins xlconcat_0/In24]
# connect_bd_net [get_bd_pins xlconcat_0/In25] [get_bd_pins aurora_64b66b_3/hard_err]
# connect_bd_net [get_bd_pins aurora_64b66b_3/lane_up] [get_bd_pins xlconcat_0/In26]
# connect_bd_net [get_bd_pins xlconcat_0/In27] [get_bd_pins aurora_64b66b_3/soft_err]

# #treadys
# connect_bd_net [get_bd_pins xlconcat_0/In8] [get_bd_pins util_vector_logic_0/Res]
# connect_bd_net [get_bd_pins xlconcat_0/In28] [get_bd_pins util_vector_logic_3/Res]


# # set_property -dict [list CONFIG.C_REFCLK_FREQUENCY {322.265625}] [get_bd_cells aurora_64b66b_*]


# # singlended clk
# # delete_bd_objs [get_bd_intf_nets io_clk_qsfp_refclka_00_1]
# # create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_0
# # set_property -dict [list CONFIG.C_BUF_TYPE {IBUFDSGTE}] [get_bd_cells util_ds_buf_0]
# # connect_bd_intf_net [get_bd_intf_ports io_clk_qsfp_refclka_00] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
# # set_property -dict [list CONFIG.SINGLEEND_GTREFCLK {true}] [get_bd_cells aurora_64b66b_0]
# # connect_bd_net [get_bd_pins aurora_64b66b_0/refclk1_in] [get_bd_pins util_ds_buf_0/IBUF_OUT]
# # connect_bd_net [get_bd_pins aurora_64b66b_1/refclk1_in] [get_bd_pins util_ds_buf_0/IBUF_OUT]
# # connect_bd_net [get_bd_pins aurora_64b66b_2/refclk1_in] [get_bd_pins util_ds_buf_0/IBUF_OUT]
# # connect_bd_net [get_bd_pins aurora_64b66b_3/refclk1_in] [get_bd_pins util_ds_buf_0/IBUF_OUT]


# ##twomasters?  -- does not work
# # set_property -dict [list CONFIG.SupportLevel {1}] [get_bd_cells aurora_64b66b_2]
# # delete_bd_objs [get_bd_nets aurora_64b66b_2_gt_to_common_qpllreset_out]
# # set_property -dict [list CONFIG.SINGLEEND_GTREFCLK {true}] [get_bd_cells aurora_64b66b_2]
# # connect_bd_net [get_bd_pins aurora_64b66b_2/refclk1_in] [get_bd_pins aurora_64b66b_0/gt_refclk1_out]
# # disconnect_bd_net /ii_level0_wire_ulp_m_aclk_freerun_ref_00 [get_bd_pins aurora_64b66b_3/init_clk]
# # disconnect_bd_net /aurora_64b66b_0_user_clk_out [get_bd_pins aurora_64b66b_3/user_clk]
# # disconnect_bd_net /aurora_64b66b_0_sync_clk_out [get_bd_pins aurora_64b66b_3/sync_clk]
# # disconnect_bd_net /aurora_64b66b_0_gt_qpllrefclklost_quad1_out [get_bd_pins aurora_64b66b_3/gt_qpllrefclklost_quad1]
# # disconnect_bd_net /aurora_64b66b_0_gt_qpllrefclk_quad1_out [get_bd_pins aurora_64b66b_3/gt_qpllrefclk_quad1_in]
# # disconnect_bd_net /aurora_64b66b_0_gt_refclk1_out [get_bd_pins aurora_64b66b_3/refclk1_in]
# # disconnect_bd_net /aurora_64b66b_0_gt_qpllclk_quad1_out [get_bd_pins aurora_64b66b_3/gt_qpllclk_quad1_in]
# # disconnect_bd_net /aurora_64b66b_0_gt_qplllock_quad1_out [get_bd_pins aurora_64b66b_3/gt_qplllock_quad1_in]
# # connect_bd_net [get_bd_pins aurora_64b66b_2/gt_qplllock_quad1_out] [get_bd_pins aurora_64b66b_3/gt_qplllock_quad1_in]
# # connect_bd_net [get_bd_pins aurora_64b66b_2/gt_qpllrefclklost_quad1_out] [get_bd_pins aurora_64b66b_3/gt_qpllrefclklost_quad1]
# # connect_bd_net [get_bd_pins aurora_64b66b_3/refclk1_in] [get_bd_pins aurora_64b66b_0/gt_refclk1_out]
# # connect_bd_net [get_bd_pins aurora_64b66b_2/user_clk_out] [get_bd_pins aurora_64b66b_3/user_clk]
# # connect_bd_net [get_bd_pins aurora_64b66b_2/sync_clk_out] [get_bd_pins aurora_64b66b_3/sync_clk]
# # connect_bd_net [get_bd_pins aurora_64b66b_3/init_clk] [get_bd_pins ii_level0_wire/ulp_m_aclk_freerun_ref_00]
# # connect_bd_net [get_bd_pins aurora_64b66b_3/gt_qpllclk_quad1_in] [get_bd_pins aurora_64b66b_2/gt_qpllclk_quad1_out]
# # connect_bd_net [get_bd_pins aurora_64b66b_3/gt_qpllrefclk_quad1_in] [get_bd_pins aurora_64b66b_2/gt_qpllrefclk_quad1_out]
# # set_property -dict [list CONFIG.IS_ACLK_ASYNC {1}] [get_bd_cells axis_data_fifo_2]
# # connect_bd_net [get_bd_pins axis_data_fifo_2/m_axis_aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# # disconnect_bd_net /aurora_64b66b_0_user_clk_out [get_bd_pins axis_data_fifo_2/s_axis_aclk]
# # disconnect_bd_net /aurora_64b66b_0_user_clk_out [get_bd_pins axis_register_slice_1/aclk]
# # disconnect_bd_net /aurora_64b66b_0_user_clk_out [get_bd_pins axis_register_slice_2/aclk]
# # connect_bd_net [get_bd_pins axis_register_slice_2/aclk] [get_bd_pins axis_register_slice_1/aclk]
# # connect_bd_net [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_register_slice_1/aclk]
# # set_property -dict [list CONFIG.IS_ACLK_ASYNC {1}] [get_bd_cells axis_data_fifo_3]
# # connect_bd_net [get_bd_pins axis_data_fifo_3/m_axis_aclk] [get_bd_pins aurora_64b66b_0/user_clk_out]
# # disconnect_bd_net /aurora_64b66b_0_user_clk_out [get_bd_pins axis_data_fifo_3/s_axis_aclk]
# # connect_bd_net [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_register_slice_2/aclk]
# # connect_bd_net [get_bd_pins axis_register_slice_2/aclk] [get_bd_pins aurora_64b66b_2/user_clk_out]
# # create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1
# # connect_bd_net [get_bd_pins proc_sys_reset_1/ext_reset_in] [get_bd_pins ulp_ucs/aresetn_kernel_slr0]
# # connect_bd_net [get_bd_pins proc_sys_reset_1/slowest_sync_clk] [get_bd_pins aurora_64b66b_2/user_clk_out]
# # disconnect_bd_net /proc_sys_reset_0_peripheral_reset [get_bd_pins aurora_64b66b_3/reset_pb] [get_bd_pins aurora_64b66b_2/reset_pb]
# # connect_bd_net [get_bd_pins aurora_64b66b_3/reset_pb] [get_bd_pins proc_sys_reset_1/peripheral_reset]
# # connect_bd_net [get_bd_pins proc_sys_reset_1/peripheral_reset] [get_bd_pins aurora_64b66b_2/reset_pb]
# # disconnect_bd_net /proc_sys_reset_0_peripheral_aresetn [get_bd_pins axis_register_slice_1/aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_register_slice_2/aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn]
# # connect_bd_net [get_bd_pins axis_register_slice_2/aresetn] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
# # connect_bd_net [get_bd_pins proc_sys_reset_1/peripheral_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn]
# # connect_bd_net [get_bd_pins proc_sys_reset_1/peripheral_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn]
# # connect_bd_net [get_bd_pins proc_sys_reset_1/peripheral_aresetn] [get_bd_pins axis_register_slice_1/aresetn]



file delete ../../../../../../u50/hw/_x/link/vivado/vpl/.local/hw_platform/tcl_hooks/postopt.tcl
exec touch ../../../../../../u50/hw/_x/link/vivado/vpl/.local/hw_platform/tcl_hooks/postopt.tcl

set_property CONFIG.FREQ_HZ 161132813 [get_bd_intf_ports /io_clk_qsfp_refclka_00]

# set_property CONFIG.FREQ_HZ 322265625 [get_bd_intf_ports /io_clk_qsfp_refclkb_00]
save_bd_design
# validate_bd_design
