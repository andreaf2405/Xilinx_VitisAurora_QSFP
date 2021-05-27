
################################################################
# This is a generated script based on design: ulp
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source ulp_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcu50-fsvh2104-2-e
   set_property BOARD_PART xilinx.com:au50:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name ulp

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design -bdsource Vitis $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:aurora_64b66b:12.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:axi_vip:1.1\
xilinx.com:ip:axis_broadcaster:1.1\
xilinx.com:ip:axis_clock_converter:1.1\
xilinx.com:ip:axis_combiner:1.1\
xilinx.com:ip:axis_data_fifo:2.0\
xilinx.com:ip:axis_register_slice:1.1\
xilinx.com:ip:axis_subset_converter:1.1\
xilinx.com:ip:axis_switch:1.1\
xilinx.com:ip:debug_bridge:3.0\
xilinx.com:ip:hbm_memory_subsystem:1.0\
xilinx.com:ip:ii_level0_wire:1.0\
xilinx.com:ip:ila:6.2\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:xlslice:1.0\
xilinx.com:hls:simple_hGradient:1.0\
xilinx.com:hls:str2mem:1.0\
xilinx.com:ip:shell_ucs_subsystem:2.0\
xilinx.com:ip:util_ds_buf:2.1\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:axi_register_slice:2.1\
xilinx.com:ip:axi_fifo_mm_s:4.2\
xilinx.com:ip:trace_hub:1.1\
xilinx.com:ip:accelerator_monitor:1.1\
xilinx.com:ip:axi_stream_monitor:1.1\
xilinx.com:ip:axi_interface_monitor:1.1\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: interrupt_concat
proc create_hier_cell_interrupt_concat { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_interrupt_concat() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 In0
  create_bd_pin -dir I -from 0 -to 0 In1
  create_bd_pin -dir O -from 127 -to 0 xlconcat_interrupt_dout

  # Create instance: workaround_cr1039626_orgate, and set properties
  set workaround_cr1039626_orgate [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 workaround_cr1039626_orgate ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {128} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $workaround_cr1039626_orgate

  # Create instance: xlconcat_interrupt, and set properties
  set xlconcat_interrupt [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_interrupt ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_interrupt

  # Create instance: xlconcat_interrupt_0, and set properties
  set xlconcat_interrupt_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_interrupt_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {32} \
 ] $xlconcat_interrupt_0

  # Create instance: xlconcat_interrupt_1, and set properties
  set xlconcat_interrupt_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_interrupt_1 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {32} \
 ] $xlconcat_interrupt_1

  # Create instance: xlconcat_interrupt_2, and set properties
  set xlconcat_interrupt_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_interrupt_2 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {32} \
 ] $xlconcat_interrupt_2

  # Create instance: xlconcat_interrupt_3, and set properties
  set xlconcat_interrupt_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_interrupt_3 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {32} \
 ] $xlconcat_interrupt_3

  # Create instance: xlconstant_gnd, and set properties
  set xlconstant_gnd [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_gnd ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_gnd

  # Create instance: xlconstant_gnd128, and set properties
  set xlconstant_gnd128 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_gnd128 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {128} \
 ] $xlconstant_gnd128

  # Create port connections
  connect_bd_net -net In0_1 [get_bd_pins In0] [get_bd_pins xlconcat_interrupt_0/In0]
  connect_bd_net -net In1_1 [get_bd_pins In1] [get_bd_pins xlconcat_interrupt_0/In1]
  connect_bd_net -net workaround_cr1039626_orgate_Res [get_bd_pins xlconcat_interrupt_dout] [get_bd_pins workaround_cr1039626_orgate/Res]
  connect_bd_net -net xlconcat_interrupt_0_dout [get_bd_pins xlconcat_interrupt/In0] [get_bd_pins xlconcat_interrupt_0/dout]
  connect_bd_net -net xlconcat_interrupt_1_dout [get_bd_pins xlconcat_interrupt/In1] [get_bd_pins xlconcat_interrupt_1/dout]
  connect_bd_net -net xlconcat_interrupt_2_dout [get_bd_pins xlconcat_interrupt/In2] [get_bd_pins xlconcat_interrupt_2/dout]
  connect_bd_net -net xlconcat_interrupt_3_dout [get_bd_pins xlconcat_interrupt/In3] [get_bd_pins xlconcat_interrupt_3/dout]
  connect_bd_net -net xlconcat_interrupt_dout1 [get_bd_pins workaround_cr1039626_orgate/Op1] [get_bd_pins xlconcat_interrupt/dout]
  connect_bd_net -net xlconstant_gnd128_dout [get_bd_pins workaround_cr1039626_orgate/Op2] [get_bd_pins xlconstant_gnd128/dout]
  connect_bd_net -net xlconstant_gnd_dout [get_bd_pins xlconcat_interrupt_0/In2] [get_bd_pins xlconcat_interrupt_0/In3] [get_bd_pins xlconcat_interrupt_0/In4] [get_bd_pins xlconcat_interrupt_0/In5] [get_bd_pins xlconcat_interrupt_0/In6] [get_bd_pins xlconcat_interrupt_0/In7] [get_bd_pins xlconcat_interrupt_0/In8] [get_bd_pins xlconcat_interrupt_0/In9] [get_bd_pins xlconcat_interrupt_0/In10] [get_bd_pins xlconcat_interrupt_0/In11] [get_bd_pins xlconcat_interrupt_0/In12] [get_bd_pins xlconcat_interrupt_0/In13] [get_bd_pins xlconcat_interrupt_0/In14] [get_bd_pins xlconcat_interrupt_0/In15] [get_bd_pins xlconcat_interrupt_0/In16] [get_bd_pins xlconcat_interrupt_0/In17] [get_bd_pins xlconcat_interrupt_0/In18] [get_bd_pins xlconcat_interrupt_0/In19] [get_bd_pins xlconcat_interrupt_0/In20] [get_bd_pins xlconcat_interrupt_0/In21] [get_bd_pins xlconcat_interrupt_0/In22] [get_bd_pins xlconcat_interrupt_0/In23] [get_bd_pins xlconcat_interrupt_0/In24] [get_bd_pins xlconcat_interrupt_0/In25] [get_bd_pins xlconcat_interrupt_0/In26] [get_bd_pins xlconcat_interrupt_0/In27] [get_bd_pins xlconcat_interrupt_0/In28] [get_bd_pins xlconcat_interrupt_0/In29] [get_bd_pins xlconcat_interrupt_0/In30] [get_bd_pins xlconcat_interrupt_0/In31] [get_bd_pins xlconcat_interrupt_1/In0] [get_bd_pins xlconcat_interrupt_1/In1] [get_bd_pins xlconcat_interrupt_1/In2] [get_bd_pins xlconcat_interrupt_1/In3] [get_bd_pins xlconcat_interrupt_1/In4] [get_bd_pins xlconcat_interrupt_1/In5] [get_bd_pins xlconcat_interrupt_1/In6] [get_bd_pins xlconcat_interrupt_1/In7] [get_bd_pins xlconcat_interrupt_1/In8] [get_bd_pins xlconcat_interrupt_1/In9] [get_bd_pins xlconcat_interrupt_1/In10] [get_bd_pins xlconcat_interrupt_1/In11] [get_bd_pins xlconcat_interrupt_1/In12] [get_bd_pins xlconcat_interrupt_1/In13] [get_bd_pins xlconcat_interrupt_1/In14] [get_bd_pins xlconcat_interrupt_1/In15] [get_bd_pins xlconcat_interrupt_1/In16] [get_bd_pins xlconcat_interrupt_1/In17] [get_bd_pins xlconcat_interrupt_1/In18] [get_bd_pins xlconcat_interrupt_1/In19] [get_bd_pins xlconcat_interrupt_1/In20] [get_bd_pins xlconcat_interrupt_1/In21] [get_bd_pins xlconcat_interrupt_1/In22] [get_bd_pins xlconcat_interrupt_1/In23] [get_bd_pins xlconcat_interrupt_1/In24] [get_bd_pins xlconcat_interrupt_1/In25] [get_bd_pins xlconcat_interrupt_1/In26] [get_bd_pins xlconcat_interrupt_1/In27] [get_bd_pins xlconcat_interrupt_1/In28] [get_bd_pins xlconcat_interrupt_1/In29] [get_bd_pins xlconcat_interrupt_1/In30] [get_bd_pins xlconcat_interrupt_1/In31] [get_bd_pins xlconcat_interrupt_2/In0] [get_bd_pins xlconcat_interrupt_2/In1] [get_bd_pins xlconcat_interrupt_2/In2] [get_bd_pins xlconcat_interrupt_2/In3] [get_bd_pins xlconcat_interrupt_2/In4] [get_bd_pins xlconcat_interrupt_2/In5] [get_bd_pins xlconcat_interrupt_2/In6] [get_bd_pins xlconcat_interrupt_2/In7] [get_bd_pins xlconcat_interrupt_2/In8] [get_bd_pins xlconcat_interrupt_2/In9] [get_bd_pins xlconcat_interrupt_2/In10] [get_bd_pins xlconcat_interrupt_2/In11] [get_bd_pins xlconcat_interrupt_2/In12] [get_bd_pins xlconcat_interrupt_2/In13] [get_bd_pins xlconcat_interrupt_2/In14] [get_bd_pins xlconcat_interrupt_2/In15] [get_bd_pins xlconcat_interrupt_2/In16] [get_bd_pins xlconcat_interrupt_2/In17] [get_bd_pins xlconcat_interrupt_2/In18] [get_bd_pins xlconcat_interrupt_2/In19] [get_bd_pins xlconcat_interrupt_2/In20] [get_bd_pins xlconcat_interrupt_2/In21] [get_bd_pins xlconcat_interrupt_2/In22] [get_bd_pins xlconcat_interrupt_2/In23] [get_bd_pins xlconcat_interrupt_2/In24] [get_bd_pins xlconcat_interrupt_2/In25] [get_bd_pins xlconcat_interrupt_2/In26] [get_bd_pins xlconcat_interrupt_2/In27] [get_bd_pins xlconcat_interrupt_2/In28] [get_bd_pins xlconcat_interrupt_2/In29] [get_bd_pins xlconcat_interrupt_2/In30] [get_bd_pins xlconcat_interrupt_2/In31] [get_bd_pins xlconcat_interrupt_3/In0] [get_bd_pins xlconcat_interrupt_3/In1] [get_bd_pins xlconcat_interrupt_3/In2] [get_bd_pins xlconcat_interrupt_3/In3] [get_bd_pins xlconcat_interrupt_3/In4] [get_bd_pins xlconcat_interrupt_3/In5] [get_bd_pins xlconcat_interrupt_3/In6] [get_bd_pins xlconcat_interrupt_3/In7] [get_bd_pins xlconcat_interrupt_3/In8] [get_bd_pins xlconcat_interrupt_3/In9] [get_bd_pins xlconcat_interrupt_3/In10] [get_bd_pins xlconcat_interrupt_3/In11] [get_bd_pins xlconcat_interrupt_3/In12] [get_bd_pins xlconcat_interrupt_3/In13] [get_bd_pins xlconcat_interrupt_3/In14] [get_bd_pins xlconcat_interrupt_3/In15] [get_bd_pins xlconcat_interrupt_3/In16] [get_bd_pins xlconcat_interrupt_3/In17] [get_bd_pins xlconcat_interrupt_3/In18] [get_bd_pins xlconcat_interrupt_3/In19] [get_bd_pins xlconcat_interrupt_3/In20] [get_bd_pins xlconcat_interrupt_3/In21] [get_bd_pins xlconcat_interrupt_3/In22] [get_bd_pins xlconcat_interrupt_3/In23] [get_bd_pins xlconcat_interrupt_3/In24] [get_bd_pins xlconcat_interrupt_3/In25] [get_bd_pins xlconcat_interrupt_3/In26] [get_bd_pins xlconcat_interrupt_3/In27] [get_bd_pins xlconcat_interrupt_3/In28] [get_bd_pins xlconcat_interrupt_3/In29] [get_bd_pins xlconcat_interrupt_3/In30] [get_bd_pins xlconcat_interrupt_3/In31] [get_bd_pins xlconstant_gnd/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: System_DPA
proc create_hier_cell_System_DPA { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_System_DPA() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Monitor -vlnv xilinx.com:interface:axis_rtl:1.0 MON_AXIS

  create_bd_intf_pin -mode Monitor -vlnv xilinx.com:interface:axis_rtl:1.0 MON_AXIS1

  create_bd_intf_pin -mode Monitor -vlnv xilinx.com:interface:aximm_rtl:1.0 MON_M_AXI

  create_bd_intf_pin -mode Monitor -vlnv xilinx.com:interface:aximm_rtl:1.0 MON_S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Monitor -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_MON


  # Create pins
  create_bd_pin -dir I -type clk S00_ACLK
  create_bd_pin -dir I -type rst S00_ARESETN
  create_bd_pin -dir I -type clk clk_kernel_in
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir I -type rst trace_rst

  # Create instance: dpa_cdc, and set properties
  set dpa_cdc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 dpa_cdc ]

  # Create instance: dpa_ctrl_interconnect, and set properties
  set dpa_ctrl_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 dpa_ctrl_interconnect ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.M04_HAS_REGSLICE {1} \
   CONFIG.M05_HAS_REGSLICE {1} \
   CONFIG.M06_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {7} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_REGSLICE {1} \
 ] $dpa_ctrl_interconnect

  # Create instance: dpa_fifo, and set properties
  set dpa_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_fifo_mm_s:4.2 dpa_fifo ]
  set_property -dict [ list \
   CONFIG.C_AXI4_BASEADDR {0x01420000} \
   CONFIG.C_AXI4_HIGHADDR {0x01421FFF} \
   CONFIG.C_DATA_INTERFACE_TYPE {1} \
   CONFIG.C_RX_CASCADE_HEIGHT {1} \
   CONFIG.C_RX_FIFO_DEPTH {8192} \
   CONFIG.C_S_AXI4_DATA_WIDTH {64} \
   CONFIG.C_USE_RX_CUT_THROUGH {true} \
   CONFIG.C_USE_TX_DATA {0} \
   CONFIG.SLR_ASSIGNMENTS {SLR0} \
 ] $dpa_fifo
  set_property HDL_ATTRIBUTE.DPA_IP {true} [get_bd_cells /System_DPA/dpa_fifo]
  set_property HDL_ATTRIBUTE.DPA_IP_FULLNAME {dpa_fifo} [get_bd_cells /System_DPA/dpa_fifo]
  set_property HDL_ATTRIBUTE.DPA_IP_PROPERTIES {0} [get_bd_cells /System_DPA/dpa_fifo]

  # Create instance: dpa_hub, and set properties
  set dpa_hub [ create_bd_cell -type ip -vlnv xilinx.com:ip:trace_hub:1.1 dpa_hub ]
  set_property -dict [ list \
   CONFIG.NUM_TRACE_PORTS {6} \
   CONFIG.SLR_ASSIGNMENTS {SLR0} \
 ] $dpa_hub
  set_property HDL_ATTRIBUTE.DPA_IP {true} [get_bd_cells /System_DPA/dpa_hub]
  set_property HDL_ATTRIBUTE.DPA_IP_FULLNAME {dpa_hub} [get_bd_cells /System_DPA/dpa_hub]
  set_property HDL_ATTRIBUTE.DPA_IP_PROPERTIES {0} [get_bd_cells /System_DPA/dpa_hub]

  # Create instance: dpa_mon0, and set properties
  set dpa_mon0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:accelerator_monitor:1.1 dpa_mon0 ]
  set_property -dict [ list \
   CONFIG.COUNT_WIDTH {64} \
   CONFIG.ENABLE_TRACE {1} \
   CONFIG.EN_AXI_LITE {1} \
   CONFIG.MONITOR_MODE {1} \
   CONFIG.STALL_MON {0} \
   CONFIG.TRACE_ID {64} \
 ] $dpa_mon0
  set_property HDL_ATTRIBUTE.DPA_IP {true} [get_bd_cells /System_DPA/dpa_mon0]
  set_property HDL_ATTRIBUTE.DPA_IP_FULLNAME {/simple_hGradient} [get_bd_cells /System_DPA/dpa_mon0]
  set_property HDL_ATTRIBUTE.DPA_IP_PROPERTIES {11} [get_bd_cells /System_DPA/dpa_mon0]

  # Create instance: dpa_mon1, and set properties
  set dpa_mon1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_stream_monitor:1.1 dpa_mon1 ]
  set_property -dict [ list \
   CONFIG.DETAILED_TRACE {1} \
   CONFIG.ENABLE_TRACE {1} \
   CONFIG.EN_AXI_LITE {true} \
   CONFIG.TRACE_ID {576} \
 ] $dpa_mon1
  set_property HDL_ATTRIBUTE.DPA_IP {true} [get_bd_cells /System_DPA/dpa_mon1]
  set_property HDL_ATTRIBUTE.DPA_IP_FULLNAME {simple_hGradient/out_r-axis_clock_converter_outbound/S_AXIS} [get_bd_cells /System_DPA/dpa_mon1]
  set_property HDL_ATTRIBUTE.DPA_IP_PROPERTIES {1} [get_bd_cells /System_DPA/dpa_mon1]

  # Create instance: dpa_mon2, and set properties
  set dpa_mon2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:accelerator_monitor:1.1 dpa_mon2 ]
  set_property -dict [ list \
   CONFIG.COUNT_WIDTH {64} \
   CONFIG.ENABLE_TRACE {1} \
   CONFIG.EN_AXI_LITE {1} \
   CONFIG.MONITOR_MODE {1} \
   CONFIG.STALL_MON {0} \
   CONFIG.TRACE_ID {80} \
 ] $dpa_mon2
  set_property HDL_ATTRIBUTE.DPA_IP {true} [get_bd_cells /System_DPA/dpa_mon2]
  set_property HDL_ATTRIBUTE.DPA_IP_FULLNAME {/str2mem} [get_bd_cells /System_DPA/dpa_mon2]
  set_property HDL_ATTRIBUTE.DPA_IP_PROPERTIES {11} [get_bd_cells /System_DPA/dpa_mon2]

  # Create instance: dpa_mon3, and set properties
  set dpa_mon3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_stream_monitor:1.1 dpa_mon3 ]
  set_property -dict [ list \
   CONFIG.DETAILED_TRACE {1} \
   CONFIG.ENABLE_TRACE {1} \
   CONFIG.EN_AXI_LITE {true} \
   CONFIG.TRACE_ID {577} \
 ] $dpa_mon3
  set_property HDL_ATTRIBUTE.DPA_IP {true} [get_bd_cells /System_DPA/dpa_mon3]
  set_property HDL_ATTRIBUTE.DPA_IP_FULLNAME {axis_switch_1/M00_AXIS-str2mem/in_r} [get_bd_cells /System_DPA/dpa_mon3]
  set_property HDL_ATTRIBUTE.DPA_IP_PROPERTIES {3} [get_bd_cells /System_DPA/dpa_mon3]

  # Create instance: dpa_mon4, and set properties
  set dpa_mon4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interface_monitor:1.1 dpa_mon4 ]
  set_property -dict [ list \
   CONFIG.CAPTURE_BURSTS {0} \
   CONFIG.COUNT_WIDTH {64} \
   CONFIG.ENABLE_COUNTERS {1} \
   CONFIG.ENABLE_DEBUG {1} \
   CONFIG.ENABLE_TRACE {1} \
   CONFIG.EN_AXI_LITE {1} \
   CONFIG.MODE_SDACCEL {1} \
   CONFIG.TRACE_READ_ID {0} \
   CONFIG.TRACE_WRITE_ID {1} \
 ] $dpa_mon4
  set_property HDL_ATTRIBUTE.DPA_IP {true} [get_bd_cells /System_DPA/dpa_mon4]
  set_property HDL_ATTRIBUTE.DPA_IP_FULLNAME {/str2mem/m_axi_aximm1-HBM[1]} [get_bd_cells /System_DPA/dpa_mon4]
  set_property HDL_ATTRIBUTE.DPA_IP_PROPERTIES {11} [get_bd_cells /System_DPA/dpa_mon4]

  # Create instance: dpa_reg_slice, and set properties
  set dpa_reg_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 dpa_reg_slice ]

  # Create instance: dpa_reg_slice2, and set properties
  set dpa_reg_slice2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 dpa_reg_slice2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins dpa_ctrl_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net SLR0_M01_AXI [get_bd_intf_pins S_AXI_MON] [get_bd_intf_pins dpa_mon0/S_AXI_MON]
  connect_bd_intf_net -intf_net SLR0_M02_AXI [get_bd_intf_pins MON_S_AXI] [get_bd_intf_pins dpa_mon4/MON_S_AXI]
  connect_bd_intf_net -intf_net [get_bd_intf_nets SLR0_M02_AXI] [get_bd_intf_pins MON_S_AXI] [get_bd_intf_pins dpa_mon2/S_AXI_MON]
  connect_bd_intf_net -intf_net axi_data_sc_M03_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins dpa_reg_slice/S_AXI]
  connect_bd_intf_net -intf_net dpa_cdc_M_AXIS [get_bd_intf_pins dpa_cdc/M_AXIS] [get_bd_intf_pins dpa_fifo/AXI_STR_RXD]
  connect_bd_intf_net -intf_net dpa_ctrl_interconnect_M00_AXI [get_bd_intf_pins dpa_ctrl_interconnect/M00_AXI] [get_bd_intf_pins dpa_fifo/S_AXI]
  connect_bd_intf_net -intf_net dpa_ctrl_interconnect_M01_AXI [get_bd_intf_pins dpa_ctrl_interconnect/M01_AXI] [get_bd_intf_pins dpa_hub/S_AXI]
  connect_bd_intf_net -intf_net dpa_ctrl_interconnect_M02_AXI [get_bd_intf_pins dpa_ctrl_interconnect/M02_AXI] [get_bd_intf_pins dpa_mon0/S_AXI]
  connect_bd_intf_net -intf_net dpa_ctrl_interconnect_M03_AXI [get_bd_intf_pins dpa_ctrl_interconnect/M03_AXI] [get_bd_intf_pins dpa_mon1/S_AXI]
  connect_bd_intf_net -intf_net dpa_ctrl_interconnect_M04_AXI [get_bd_intf_pins dpa_ctrl_interconnect/M04_AXI] [get_bd_intf_pins dpa_mon2/S_AXI]
  connect_bd_intf_net -intf_net dpa_ctrl_interconnect_M05_AXI [get_bd_intf_pins dpa_ctrl_interconnect/M05_AXI] [get_bd_intf_pins dpa_mon3/S_AXI]
  connect_bd_intf_net -intf_net dpa_ctrl_interconnect_M06_AXI [get_bd_intf_pins dpa_ctrl_interconnect/M06_AXI] [get_bd_intf_pins dpa_mon4/S_AXI]
  connect_bd_intf_net -intf_net dpa_hub_M_AXIS [get_bd_intf_pins dpa_cdc/S_AXIS] [get_bd_intf_pins dpa_hub/M_AXIS]
  connect_bd_intf_net -intf_net dpa_mon0_TRACE_OUT [get_bd_intf_pins dpa_hub/TRACE_0] [get_bd_intf_pins dpa_mon0/TRACE_OUT]
  connect_bd_intf_net -intf_net dpa_mon1_TRACE_OUT [get_bd_intf_pins dpa_hub/TRACE_1] [get_bd_intf_pins dpa_mon1/TRACE_OUT]
  connect_bd_intf_net -intf_net dpa_mon2_TRACE_OUT [get_bd_intf_pins dpa_hub/TRACE_2] [get_bd_intf_pins dpa_mon2/TRACE_OUT]
  connect_bd_intf_net -intf_net dpa_mon3_TRACE_OUT [get_bd_intf_pins dpa_hub/TRACE_3] [get_bd_intf_pins dpa_mon3/TRACE_OUT]
  connect_bd_intf_net -intf_net dpa_mon4_TRACE_OUT_0 [get_bd_intf_pins dpa_hub/TRACE_4] [get_bd_intf_pins dpa_mon4/TRACE_OUT_0]
  connect_bd_intf_net -intf_net dpa_mon4_TRACE_OUT_1 [get_bd_intf_pins dpa_hub/TRACE_5] [get_bd_intf_pins dpa_mon4/TRACE_OUT_1]
  connect_bd_intf_net -intf_net dpa_reg_slice2_M_AXI [get_bd_intf_pins dpa_fifo/S_AXI_FULL] [get_bd_intf_pins dpa_reg_slice2/M_AXI]
  connect_bd_intf_net -intf_net dpa_reg_slice_M_AXI [get_bd_intf_pins dpa_reg_slice/M_AXI] [get_bd_intf_pins dpa_reg_slice2/S_AXI]
  connect_bd_intf_net -intf_net simple_hGradient_out_r [get_bd_intf_pins MON_AXIS1] [get_bd_intf_pins dpa_mon3/MON_AXIS]
  connect_bd_intf_net -intf_net simple_hGradient_out_r1 [get_bd_intf_pins MON_AXIS] [get_bd_intf_pins dpa_mon1/MON_AXIS]
  connect_bd_intf_net -intf_net str2mem_m_axi_aximm1 [get_bd_intf_pins MON_M_AXI] [get_bd_intf_pins dpa_mon4/MON_M_AXI]

  # Create port connections
  connect_bd_net -net clk_kernel_in_1 [get_bd_pins clk_kernel_in] [get_bd_pins dpa_cdc/s_axis_aclk] [get_bd_pins dpa_ctrl_interconnect/M01_ACLK] [get_bd_pins dpa_ctrl_interconnect/M02_ACLK] [get_bd_pins dpa_ctrl_interconnect/M03_ACLK] [get_bd_pins dpa_ctrl_interconnect/M04_ACLK] [get_bd_pins dpa_ctrl_interconnect/M05_ACLK] [get_bd_pins dpa_ctrl_interconnect/M06_ACLK] [get_bd_pins dpa_hub/mon_clk] [get_bd_pins dpa_hub/trace_clk] [get_bd_pins dpa_mon0/mon_clk] [get_bd_pins dpa_mon0/trace_clk] [get_bd_pins dpa_mon1/mon_clk] [get_bd_pins dpa_mon1/trace_clk] [get_bd_pins dpa_mon2/mon_clk] [get_bd_pins dpa_mon2/trace_clk] [get_bd_pins dpa_mon3/mon_clk] [get_bd_pins dpa_mon3/trace_clk] [get_bd_pins dpa_mon4/mon_clk] [get_bd_pins dpa_mon4/trace_clk]
  connect_bd_net -net ii_level0_wire_ulp_m_aclk_ctrl_00 [get_bd_pins S00_ACLK] [get_bd_pins dpa_ctrl_interconnect/ACLK] [get_bd_pins dpa_ctrl_interconnect/S00_ACLK]
  connect_bd_net -net ii_level0_wire_ulp_m_aclk_pcie_00 [get_bd_pins s_axi_aclk] [get_bd_pins dpa_cdc/m_axis_aclk] [get_bd_pins dpa_ctrl_interconnect/M00_ACLK] [get_bd_pins dpa_fifo/s_axi_aclk] [get_bd_pins dpa_reg_slice/aclk] [get_bd_pins dpa_reg_slice2/aclk]
  connect_bd_net -net proc_sys_reset_ctrl_slr1_peripheral_aresetn [get_bd_pins S00_ARESETN] [get_bd_pins dpa_ctrl_interconnect/ARESETN] [get_bd_pins dpa_ctrl_interconnect/S00_ARESETN]
  connect_bd_net -net proc_sys_reset_kernel_slr0_peripheral_aresetn [get_bd_pins trace_rst] [get_bd_pins dpa_cdc/s_axis_aresetn] [get_bd_pins dpa_ctrl_interconnect/M01_ARESETN] [get_bd_pins dpa_ctrl_interconnect/M02_ARESETN] [get_bd_pins dpa_ctrl_interconnect/M03_ARESETN] [get_bd_pins dpa_ctrl_interconnect/M04_ARESETN] [get_bd_pins dpa_ctrl_interconnect/M05_ARESETN] [get_bd_pins dpa_ctrl_interconnect/M06_ARESETN] [get_bd_pins dpa_hub/mon_resetn] [get_bd_pins dpa_hub/trace_resetn] [get_bd_pins dpa_mon0/mon_resetn] [get_bd_pins dpa_mon0/trace_rst] [get_bd_pins dpa_mon1/mon_resetn] [get_bd_pins dpa_mon1/trace_rst] [get_bd_pins dpa_mon2/mon_resetn] [get_bd_pins dpa_mon2/trace_rst] [get_bd_pins dpa_mon3/mon_resetn] [get_bd_pins dpa_mon3/trace_rst] [get_bd_pins dpa_mon4/mon_resetn] [get_bd_pins dpa_mon4/trace_rst]
  connect_bd_net -net ulp_ucs_aresetn_pcie_slr0 [get_bd_pins s_axi_aresetn] [get_bd_pins dpa_cdc/m_axis_aresetn] [get_bd_pins dpa_ctrl_interconnect/M00_ARESETN] [get_bd_pins dpa_fifo/s_axi_aresetn] [get_bd_pins dpa_reg_slice/aresetn] [get_bd_pins dpa_reg_slice2/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: SLR1
proc create_hier_cell_SLR1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_SLR1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_sdx_memory

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_ctrl_user

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_data


  # Create pins
  create_bd_pin -dir I -type clk aclk_ctrl
  create_bd_pin -dir I -type clk aclk_pcie
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn_ctrl
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn_kernel
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn_kernel2
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn_pcie
  create_bd_pin -dir I -type clk kernel_clk_1
  create_bd_pin -dir I -type clk kernel_clk_2

  # Create instance: axi_vip_ctrl_userpf, and set properties
  set axi_vip_ctrl_userpf [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.1 axi_vip_ctrl_userpf ]

  # Create instance: interconnect_axilite_user, and set properties
  set interconnect_axilite_user [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 interconnect_axilite_user ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.M01_HAS_REGSLICE {4} \
   CONFIG.M02_HAS_REGSLICE {4} \
   CONFIG.M03_HAS_REGSLICE {4} \
   CONFIG.M04_HAS_REGSLICE {4} \
   CONFIG.M05_HAS_REGSLICE {4} \
   CONFIG.M06_HAS_REGSLICE {4} \
   CONFIG.M07_HAS_REGSLICE {4} \
   CONFIG.M08_HAS_REGSLICE {4} \
   CONFIG.M09_HAS_REGSLICE {4} \
   CONFIG.M10_HAS_REGSLICE {4} \
   CONFIG.M11_HAS_REGSLICE {4} \
   CONFIG.M12_HAS_REGSLICE {4} \
   CONFIG.M13_HAS_REGSLICE {4} \
   CONFIG.M14_HAS_REGSLICE {4} \
   CONFIG.M15_HAS_REGSLICE {4} \
   CONFIG.M16_HAS_REGSLICE {4} \
   CONFIG.M17_HAS_REGSLICE {4} \
   CONFIG.M18_HAS_REGSLICE {4} \
   CONFIG.M19_HAS_REGSLICE {4} \
   CONFIG.M20_HAS_REGSLICE {4} \
   CONFIG.M21_HAS_REGSLICE {4} \
   CONFIG.M22_HAS_REGSLICE {4} \
   CONFIG.M23_HAS_REGSLICE {4} \
   CONFIG.M24_HAS_REGSLICE {4} \
   CONFIG.M25_HAS_REGSLICE {4} \
   CONFIG.M26_HAS_REGSLICE {4} \
   CONFIG.M27_HAS_REGSLICE {4} \
   CONFIG.M28_HAS_REGSLICE {4} \
   CONFIG.M29_HAS_REGSLICE {4} \
   CONFIG.M30_HAS_REGSLICE {4} \
   CONFIG.M31_HAS_REGSLICE {4} \
   CONFIG.M32_HAS_REGSLICE {4} \
   CONFIG.M33_HAS_REGSLICE {4} \
   CONFIG.M34_HAS_REGSLICE {4} \
   CONFIG.M35_HAS_REGSLICE {4} \
   CONFIG.M36_HAS_REGSLICE {4} \
   CONFIG.M37_HAS_REGSLICE {4} \
   CONFIG.M38_HAS_REGSLICE {4} \
   CONFIG.M39_HAS_REGSLICE {4} \
   CONFIG.M40_HAS_REGSLICE {4} \
   CONFIG.M41_HAS_REGSLICE {4} \
   CONFIG.M42_HAS_REGSLICE {4} \
   CONFIG.M43_HAS_REGSLICE {4} \
   CONFIG.M44_HAS_REGSLICE {4} \
   CONFIG.M45_HAS_REGSLICE {4} \
   CONFIG.M46_HAS_REGSLICE {4} \
   CONFIG.M47_HAS_REGSLICE {4} \
   CONFIG.M48_HAS_REGSLICE {4} \
   CONFIG.M49_HAS_REGSLICE {4} \
   CONFIG.M50_HAS_REGSLICE {4} \
   CONFIG.M51_HAS_REGSLICE {4} \
   CONFIG.M52_HAS_REGSLICE {4} \
   CONFIG.M53_HAS_REGSLICE {4} \
   CONFIG.M54_HAS_REGSLICE {4} \
   CONFIG.M55_HAS_REGSLICE {4} \
   CONFIG.M56_HAS_REGSLICE {4} \
   CONFIG.M57_HAS_REGSLICE {4} \
   CONFIG.M58_HAS_REGSLICE {4} \
   CONFIG.M59_HAS_REGSLICE {4} \
   CONFIG.M60_HAS_REGSLICE {4} \
   CONFIG.M61_HAS_REGSLICE {4} \
   CONFIG.M62_HAS_REGSLICE {4} \
   CONFIG.M63_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.SLR_ASSIGNMENTS {SLR1} \
 ] $interconnect_axilite_user

  # Create instance: regslice_control_userpf, and set properties
  set regslice_control_userpf [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 regslice_control_userpf ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {25} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.REG_R {7} \
   CONFIG.REG_W {7} \
   CONFIG.SLR_ASSIGNMENTS {SLR1} \
 ] $regslice_control_userpf

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins interconnect_axilite_user/S00_AXI] [get_bd_intf_pins regslice_control_userpf/M_AXI]
  connect_bd_intf_net -intf_net axi_vip_ctrl_userpf_M_AXI [get_bd_intf_pins axi_vip_ctrl_userpf/M_AXI] [get_bd_intf_pins regslice_control_userpf/S_AXI]
  connect_bd_intf_net -intf_net interconnect_axilite_user_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins interconnect_axilite_user/M00_AXI]
  connect_bd_intf_net -intf_net s_axi_ctrl_user_1 [get_bd_intf_pins s_axi_ctrl_user] [get_bd_intf_pins axi_vip_ctrl_userpf/S_AXI]

  # Create port connections
  connect_bd_net -net aclk_ctrl_1 [get_bd_pins aclk_ctrl] [get_bd_pins axi_vip_ctrl_userpf/aclk] [get_bd_pins interconnect_axilite_user/ACLK] [get_bd_pins interconnect_axilite_user/M00_ACLK] [get_bd_pins interconnect_axilite_user/S00_ACLK] [get_bd_pins regslice_control_userpf/aclk]
  connect_bd_net -net aclk_pcie_1 -boundary_type lower [get_bd_pins aclk_pcie]
  connect_bd_net -net aresetn_ctrl_1 [get_bd_pins aresetn_ctrl] [get_bd_pins axi_vip_ctrl_userpf/aresetn] [get_bd_pins interconnect_axilite_user/ARESETN] [get_bd_pins interconnect_axilite_user/M00_ARESETN] [get_bd_pins interconnect_axilite_user/S00_ARESETN] [get_bd_pins regslice_control_userpf/aresetn]
  connect_bd_net -net aresetn_kernel_1 -boundary_type lower [get_bd_pins aresetn_kernel]
  connect_bd_net -net aresetn_pcie_1 -boundary_type lower [get_bd_pins aresetn_pcie]
  connect_bd_net -net kernel_clk_1_1 -boundary_type lower [get_bd_pins kernel_clk_1]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: SLR0
proc create_hier_cell_SLR0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_SLR0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_sdx_memory

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_ctrl_user

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_data


  # Create pins
  create_bd_pin -dir I -type rst M01_ARESETN
  create_bd_pin -dir I -type clk aclk_ctrl
  create_bd_pin -dir I -type clk aclk_pcie
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn_ctrl
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn_kernel
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn_kernel2
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn_pcie
  create_bd_pin -dir I -from 31 -to 0 gpio_io_i
  create_bd_pin -dir I -type clk kernel_clk_1
  create_bd_pin -dir I -type clk kernel_clk_2

  # Create instance: axi_gpio_null, and set properties
  set axi_gpio_null [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_null ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
 ] $axi_gpio_null

  # Create instance: axi_vip_ctrl_userpf, and set properties
  set axi_vip_ctrl_userpf [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.1 axi_vip_ctrl_userpf ]

  # Create instance: interconnect_axilite_user, and set properties
  set interconnect_axilite_user [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 interconnect_axilite_user ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_HAS_REGSLICE {4} \
   CONFIG.M04_HAS_REGSLICE {4} \
   CONFIG.M05_HAS_REGSLICE {4} \
   CONFIG.M06_HAS_REGSLICE {4} \
   CONFIG.M07_HAS_REGSLICE {4} \
   CONFIG.M08_HAS_REGSLICE {4} \
   CONFIG.M09_HAS_REGSLICE {4} \
   CONFIG.M10_HAS_REGSLICE {4} \
   CONFIG.M11_HAS_REGSLICE {4} \
   CONFIG.M12_HAS_REGSLICE {4} \
   CONFIG.M13_HAS_REGSLICE {4} \
   CONFIG.M14_HAS_REGSLICE {4} \
   CONFIG.M15_HAS_REGSLICE {4} \
   CONFIG.M16_HAS_REGSLICE {4} \
   CONFIG.M17_HAS_REGSLICE {4} \
   CONFIG.M18_HAS_REGSLICE {4} \
   CONFIG.M19_HAS_REGSLICE {4} \
   CONFIG.M20_HAS_REGSLICE {4} \
   CONFIG.M21_HAS_REGSLICE {4} \
   CONFIG.M22_HAS_REGSLICE {4} \
   CONFIG.M23_HAS_REGSLICE {4} \
   CONFIG.M24_HAS_REGSLICE {4} \
   CONFIG.M25_HAS_REGSLICE {4} \
   CONFIG.M26_HAS_REGSLICE {4} \
   CONFIG.M27_HAS_REGSLICE {4} \
   CONFIG.M28_HAS_REGSLICE {4} \
   CONFIG.M29_HAS_REGSLICE {4} \
   CONFIG.M30_HAS_REGSLICE {4} \
   CONFIG.M31_HAS_REGSLICE {4} \
   CONFIG.M32_HAS_REGSLICE {4} \
   CONFIG.M33_HAS_REGSLICE {4} \
   CONFIG.M34_HAS_REGSLICE {4} \
   CONFIG.M35_HAS_REGSLICE {4} \
   CONFIG.M36_HAS_REGSLICE {4} \
   CONFIG.M37_HAS_REGSLICE {4} \
   CONFIG.M38_HAS_REGSLICE {4} \
   CONFIG.M39_HAS_REGSLICE {4} \
   CONFIG.M40_HAS_REGSLICE {4} \
   CONFIG.M41_HAS_REGSLICE {4} \
   CONFIG.M42_HAS_REGSLICE {4} \
   CONFIG.M43_HAS_REGSLICE {4} \
   CONFIG.M44_HAS_REGSLICE {4} \
   CONFIG.M45_HAS_REGSLICE {4} \
   CONFIG.M46_HAS_REGSLICE {4} \
   CONFIG.M47_HAS_REGSLICE {4} \
   CONFIG.M48_HAS_REGSLICE {4} \
   CONFIG.M49_HAS_REGSLICE {4} \
   CONFIG.M50_HAS_REGSLICE {4} \
   CONFIG.M51_HAS_REGSLICE {4} \
   CONFIG.M52_HAS_REGSLICE {4} \
   CONFIG.M53_HAS_REGSLICE {4} \
   CONFIG.M54_HAS_REGSLICE {4} \
   CONFIG.M55_HAS_REGSLICE {4} \
   CONFIG.M56_HAS_REGSLICE {4} \
   CONFIG.M57_HAS_REGSLICE {4} \
   CONFIG.M58_HAS_REGSLICE {4} \
   CONFIG.M59_HAS_REGSLICE {4} \
   CONFIG.M60_HAS_REGSLICE {4} \
   CONFIG.M61_HAS_REGSLICE {4} \
   CONFIG.M62_HAS_REGSLICE {4} \
   CONFIG.M63_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {3} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.SLR_ASSIGNMENTS {SLR0} \
 ] $interconnect_axilite_user

  # Create instance: regslice_control_userpf, and set properties
  set regslice_control_userpf [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 regslice_control_userpf ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {25} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.REG_R {7} \
   CONFIG.REG_W {7} \
   CONFIG.SLR_ASSIGNMENTS {SLR0} \
 ] $regslice_control_userpf

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M01_AXI] [get_bd_intf_pins interconnect_axilite_user/M01_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M02_AXI] [get_bd_intf_pins interconnect_axilite_user/M02_AXI]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins interconnect_axilite_user/S00_AXI] [get_bd_intf_pins regslice_control_userpf/M_AXI]
  connect_bd_intf_net -intf_net axi_vip_ctrl_userpf_M_AXI [get_bd_intf_pins axi_vip_ctrl_userpf/M_AXI] [get_bd_intf_pins regslice_control_userpf/S_AXI]
  connect_bd_intf_net -intf_net interconnect_axilite_user_M00_AXI [get_bd_intf_pins axi_gpio_null/S_AXI] [get_bd_intf_pins interconnect_axilite_user/M00_AXI]
  connect_bd_intf_net -intf_net s_axi_ctrl_user_1 [get_bd_intf_pins s_axi_ctrl_user] [get_bd_intf_pins axi_vip_ctrl_userpf/S_AXI]

  # Create port connections
  connect_bd_net -net M01_ARESETN_1 [get_bd_pins M01_ARESETN] [get_bd_pins interconnect_axilite_user/M01_ARESETN] [get_bd_pins interconnect_axilite_user/M02_ARESETN]
  connect_bd_net -net aclk_ctrl_1 [get_bd_pins aclk_ctrl] [get_bd_pins axi_gpio_null/s_axi_aclk] [get_bd_pins axi_vip_ctrl_userpf/aclk] [get_bd_pins interconnect_axilite_user/ACLK] [get_bd_pins interconnect_axilite_user/M00_ACLK] [get_bd_pins interconnect_axilite_user/S00_ACLK] [get_bd_pins regslice_control_userpf/aclk]
  connect_bd_net -net aclk_pcie_1 -boundary_type lower [get_bd_pins aclk_pcie]
  connect_bd_net -net aresetn_ctrl_1 [get_bd_pins aresetn_ctrl] [get_bd_pins axi_gpio_null/s_axi_aresetn] [get_bd_pins axi_vip_ctrl_userpf/aresetn] [get_bd_pins interconnect_axilite_user/ARESETN] [get_bd_pins interconnect_axilite_user/M00_ARESETN] [get_bd_pins interconnect_axilite_user/S00_ARESETN] [get_bd_pins regslice_control_userpf/aresetn]
  connect_bd_net -net aresetn_kernel_1 -boundary_type lower [get_bd_pins aresetn_kernel]
  connect_bd_net -net aresetn_pcie_1 -boundary_type lower [get_bd_pins aresetn_pcie]
  connect_bd_net -net gpio_io_i_1 [get_bd_pins gpio_io_i] [get_bd_pins axi_gpio_null/gpio_io_i]
  connect_bd_net -net kernel_clk_1_1 [get_bd_pins kernel_clk_1] [get_bd_pins interconnect_axilite_user/M01_ACLK] [get_bd_pins interconnect_axilite_user/M02_ACLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set BLP_S_AXI_CTRL_MGMT_00 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 -portmaps { \
   ARADDR { physical_name BLP_S_AXI_CTRL_MGMT_00_araddr direction I left 24 right 0 } \
   ARPROT { physical_name BLP_S_AXI_CTRL_MGMT_00_arprot direction I left 2 right 0 } \
   ARREADY { physical_name BLP_S_AXI_CTRL_MGMT_00_arready direction O } \
   ARVALID { physical_name BLP_S_AXI_CTRL_MGMT_00_arvalid direction I } \
   AWADDR { physical_name BLP_S_AXI_CTRL_MGMT_00_awaddr direction I left 24 right 0 } \
   AWPROT { physical_name BLP_S_AXI_CTRL_MGMT_00_awprot direction I left 2 right 0 } \
   AWREADY { physical_name BLP_S_AXI_CTRL_MGMT_00_awready direction O } \
   AWVALID { physical_name BLP_S_AXI_CTRL_MGMT_00_awvalid direction I } \
   BREADY { physical_name BLP_S_AXI_CTRL_MGMT_00_bready direction I } \
   BRESP { physical_name BLP_S_AXI_CTRL_MGMT_00_bresp direction O left 1 right 0 } \
   BVALID { physical_name BLP_S_AXI_CTRL_MGMT_00_bvalid direction O } \
   RDATA { physical_name BLP_S_AXI_CTRL_MGMT_00_rdata direction O left 31 right 0 } \
   RREADY { physical_name BLP_S_AXI_CTRL_MGMT_00_rready direction I } \
   RRESP { physical_name BLP_S_AXI_CTRL_MGMT_00_rresp direction O left 1 right 0 } \
   RVALID { physical_name BLP_S_AXI_CTRL_MGMT_00_rvalid direction O } \
   WDATA { physical_name BLP_S_AXI_CTRL_MGMT_00_wdata direction I left 31 right 0 } \
   WREADY { physical_name BLP_S_AXI_CTRL_MGMT_00_wready direction O } \
   WSTRB { physical_name BLP_S_AXI_CTRL_MGMT_00_wstrb direction I left 3 right 0 } \
   WVALID { physical_name BLP_S_AXI_CTRL_MGMT_00_wvalid direction I } \
   } \
  BLP_S_AXI_CTRL_MGMT_00 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {25} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.CLK_DOMAIN {cd_ctrl_00} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.FREQ_HZ {50000000} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.MAX_BURST_LENGTH {1} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PHASE {0} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $BLP_S_AXI_CTRL_MGMT_00

  set BLP_S_AXI_CTRL_MGMT_01 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 -portmaps { \
   ARADDR { physical_name BLP_S_AXI_CTRL_MGMT_01_araddr direction I left 24 right 0 } \
   ARPROT { physical_name BLP_S_AXI_CTRL_MGMT_01_arprot direction I left 2 right 0 } \
   ARREADY { physical_name BLP_S_AXI_CTRL_MGMT_01_arready direction O } \
   ARVALID { physical_name BLP_S_AXI_CTRL_MGMT_01_arvalid direction I } \
   AWADDR { physical_name BLP_S_AXI_CTRL_MGMT_01_awaddr direction I left 24 right 0 } \
   AWPROT { physical_name BLP_S_AXI_CTRL_MGMT_01_awprot direction I left 2 right 0 } \
   AWREADY { physical_name BLP_S_AXI_CTRL_MGMT_01_awready direction O } \
   AWVALID { physical_name BLP_S_AXI_CTRL_MGMT_01_awvalid direction I } \
   BREADY { physical_name BLP_S_AXI_CTRL_MGMT_01_bready direction I } \
   BRESP { physical_name BLP_S_AXI_CTRL_MGMT_01_bresp direction O left 1 right 0 } \
   BVALID { physical_name BLP_S_AXI_CTRL_MGMT_01_bvalid direction O } \
   RDATA { physical_name BLP_S_AXI_CTRL_MGMT_01_rdata direction O left 31 right 0 } \
   RREADY { physical_name BLP_S_AXI_CTRL_MGMT_01_rready direction I } \
   RRESP { physical_name BLP_S_AXI_CTRL_MGMT_01_rresp direction O left 1 right 0 } \
   RVALID { physical_name BLP_S_AXI_CTRL_MGMT_01_rvalid direction O } \
   WDATA { physical_name BLP_S_AXI_CTRL_MGMT_01_wdata direction I left 31 right 0 } \
   WREADY { physical_name BLP_S_AXI_CTRL_MGMT_01_wready direction O } \
   WSTRB { physical_name BLP_S_AXI_CTRL_MGMT_01_wstrb direction I left 3 right 0 } \
   WVALID { physical_name BLP_S_AXI_CTRL_MGMT_01_wvalid direction I } \
   } \
  BLP_S_AXI_CTRL_MGMT_01 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {25} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.CLK_DOMAIN {cd_ctrl_00} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.FREQ_HZ {50000000} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.MAX_BURST_LENGTH {1} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PHASE {0} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $BLP_S_AXI_CTRL_MGMT_01

  set BLP_S_AXI_CTRL_USER_00 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 -portmaps { \
   ARADDR { physical_name BLP_S_AXI_CTRL_USER_00_araddr direction I left 24 right 0 } \
   ARPROT { physical_name BLP_S_AXI_CTRL_USER_00_arprot direction I left 2 right 0 } \
   ARREADY { physical_name BLP_S_AXI_CTRL_USER_00_arready direction O } \
   ARVALID { physical_name BLP_S_AXI_CTRL_USER_00_arvalid direction I } \
   AWADDR { physical_name BLP_S_AXI_CTRL_USER_00_awaddr direction I left 24 right 0 } \
   AWPROT { physical_name BLP_S_AXI_CTRL_USER_00_awprot direction I left 2 right 0 } \
   AWREADY { physical_name BLP_S_AXI_CTRL_USER_00_awready direction O } \
   AWVALID { physical_name BLP_S_AXI_CTRL_USER_00_awvalid direction I } \
   BREADY { physical_name BLP_S_AXI_CTRL_USER_00_bready direction I } \
   BRESP { physical_name BLP_S_AXI_CTRL_USER_00_bresp direction O left 1 right 0 } \
   BVALID { physical_name BLP_S_AXI_CTRL_USER_00_bvalid direction O } \
   RDATA { physical_name BLP_S_AXI_CTRL_USER_00_rdata direction O left 31 right 0 } \
   RREADY { physical_name BLP_S_AXI_CTRL_USER_00_rready direction I } \
   RRESP { physical_name BLP_S_AXI_CTRL_USER_00_rresp direction O left 1 right 0 } \
   RVALID { physical_name BLP_S_AXI_CTRL_USER_00_rvalid direction O } \
   WDATA { physical_name BLP_S_AXI_CTRL_USER_00_wdata direction I left 31 right 0 } \
   WREADY { physical_name BLP_S_AXI_CTRL_USER_00_wready direction O } \
   WSTRB { physical_name BLP_S_AXI_CTRL_USER_00_wstrb direction I left 3 right 0 } \
   WVALID { physical_name BLP_S_AXI_CTRL_USER_00_wvalid direction I } \
   } \
  BLP_S_AXI_CTRL_USER_00 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {25} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.CLK_DOMAIN {cd_ctrl_00} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.FREQ_HZ {50000000} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.MAX_BURST_LENGTH {1} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PHASE {0} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $BLP_S_AXI_CTRL_USER_00

  set BLP_S_AXI_CTRL_USER_01 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 -portmaps { \
   ARADDR { physical_name BLP_S_AXI_CTRL_USER_01_araddr direction I left 24 right 0 } \
   ARPROT { physical_name BLP_S_AXI_CTRL_USER_01_arprot direction I left 2 right 0 } \
   ARREADY { physical_name BLP_S_AXI_CTRL_USER_01_arready direction O } \
   ARVALID { physical_name BLP_S_AXI_CTRL_USER_01_arvalid direction I } \
   AWADDR { physical_name BLP_S_AXI_CTRL_USER_01_awaddr direction I left 24 right 0 } \
   AWPROT { physical_name BLP_S_AXI_CTRL_USER_01_awprot direction I left 2 right 0 } \
   AWREADY { physical_name BLP_S_AXI_CTRL_USER_01_awready direction O } \
   AWVALID { physical_name BLP_S_AXI_CTRL_USER_01_awvalid direction I } \
   BREADY { physical_name BLP_S_AXI_CTRL_USER_01_bready direction I } \
   BRESP { physical_name BLP_S_AXI_CTRL_USER_01_bresp direction O left 1 right 0 } \
   BVALID { physical_name BLP_S_AXI_CTRL_USER_01_bvalid direction O } \
   RDATA { physical_name BLP_S_AXI_CTRL_USER_01_rdata direction O left 31 right 0 } \
   RREADY { physical_name BLP_S_AXI_CTRL_USER_01_rready direction I } \
   RRESP { physical_name BLP_S_AXI_CTRL_USER_01_rresp direction O left 1 right 0 } \
   RVALID { physical_name BLP_S_AXI_CTRL_USER_01_rvalid direction O } \
   WDATA { physical_name BLP_S_AXI_CTRL_USER_01_wdata direction I left 31 right 0 } \
   WREADY { physical_name BLP_S_AXI_CTRL_USER_01_wready direction O } \
   WSTRB { physical_name BLP_S_AXI_CTRL_USER_01_wstrb direction I left 3 right 0 } \
   WVALID { physical_name BLP_S_AXI_CTRL_USER_01_wvalid direction I } \
   } \
  BLP_S_AXI_CTRL_USER_01 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {25} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.CLK_DOMAIN {cd_ctrl_00} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.FREQ_HZ {50000000} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.MAX_BURST_LENGTH {1} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PHASE {0} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $BLP_S_AXI_CTRL_USER_01

  set BLP_S_AXI_CTRL_USER_02 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 -portmaps { \
   ARADDR { physical_name BLP_S_AXI_CTRL_USER_02_araddr direction I left 24 right 0 } \
   ARPROT { physical_name BLP_S_AXI_CTRL_USER_02_arprot direction I left 2 right 0 } \
   ARREADY { physical_name BLP_S_AXI_CTRL_USER_02_arready direction O } \
   ARVALID { physical_name BLP_S_AXI_CTRL_USER_02_arvalid direction I } \
   AWADDR { physical_name BLP_S_AXI_CTRL_USER_02_awaddr direction I left 24 right 0 } \
   AWPROT { physical_name BLP_S_AXI_CTRL_USER_02_awprot direction I left 2 right 0 } \
   AWREADY { physical_name BLP_S_AXI_CTRL_USER_02_awready direction O } \
   AWVALID { physical_name BLP_S_AXI_CTRL_USER_02_awvalid direction I } \
   BREADY { physical_name BLP_S_AXI_CTRL_USER_02_bready direction I } \
   BRESP { physical_name BLP_S_AXI_CTRL_USER_02_bresp direction O left 1 right 0 } \
   BVALID { physical_name BLP_S_AXI_CTRL_USER_02_bvalid direction O } \
   RDATA { physical_name BLP_S_AXI_CTRL_USER_02_rdata direction O left 31 right 0 } \
   RREADY { physical_name BLP_S_AXI_CTRL_USER_02_rready direction I } \
   RRESP { physical_name BLP_S_AXI_CTRL_USER_02_rresp direction O left 1 right 0 } \
   RVALID { physical_name BLP_S_AXI_CTRL_USER_02_rvalid direction O } \
   WDATA { physical_name BLP_S_AXI_CTRL_USER_02_wdata direction I left 31 right 0 } \
   WREADY { physical_name BLP_S_AXI_CTRL_USER_02_wready direction O } \
   WSTRB { physical_name BLP_S_AXI_CTRL_USER_02_wstrb direction I left 3 right 0 } \
   WVALID { physical_name BLP_S_AXI_CTRL_USER_02_wvalid direction I } \
   } \
  BLP_S_AXI_CTRL_USER_02 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {25} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.CLK_DOMAIN {cd_ctrl_00} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.FREQ_HZ {50000000} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.MAX_BURST_LENGTH {1} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PHASE {0} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $BLP_S_AXI_CTRL_USER_02

  set BLP_S_AXI_DATA_H2C_00 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 -portmaps { \
   ARADDR { physical_name BLP_S_AXI_DATA_H2C_00_araddr direction I left 38 right 0 } \
   ARBURST { physical_name BLP_S_AXI_DATA_H2C_00_arburst direction I left 1 right 0 } \
   ARCACHE { physical_name BLP_S_AXI_DATA_H2C_00_arcache direction I left 3 right 0 } \
   ARID { physical_name BLP_S_AXI_DATA_H2C_00_arid direction I left 1 right 0 } \
   ARLEN { physical_name BLP_S_AXI_DATA_H2C_00_arlen direction I left 7 right 0 } \
   ARLOCK { physical_name BLP_S_AXI_DATA_H2C_00_arlock direction I left 0 right 0 } \
   ARPROT { physical_name BLP_S_AXI_DATA_H2C_00_arprot direction I left 2 right 0 } \
   ARREADY { physical_name BLP_S_AXI_DATA_H2C_00_arready direction O } \
   ARVALID { physical_name BLP_S_AXI_DATA_H2C_00_arvalid direction I } \
   AWADDR { physical_name BLP_S_AXI_DATA_H2C_00_awaddr direction I left 38 right 0 } \
   AWBURST { physical_name BLP_S_AXI_DATA_H2C_00_awburst direction I left 1 right 0 } \
   AWCACHE { physical_name BLP_S_AXI_DATA_H2C_00_awcache direction I left 3 right 0 } \
   AWID { physical_name BLP_S_AXI_DATA_H2C_00_awid direction I left 1 right 0 } \
   AWLEN { physical_name BLP_S_AXI_DATA_H2C_00_awlen direction I left 7 right 0 } \
   AWLOCK { physical_name BLP_S_AXI_DATA_H2C_00_awlock direction I left 0 right 0 } \
   AWPROT { physical_name BLP_S_AXI_DATA_H2C_00_awprot direction I left 2 right 0 } \
   AWREADY { physical_name BLP_S_AXI_DATA_H2C_00_awready direction O } \
   AWVALID { physical_name BLP_S_AXI_DATA_H2C_00_awvalid direction I } \
   BID { physical_name BLP_S_AXI_DATA_H2C_00_bid direction O left 1 right 0 } \
   BREADY { physical_name BLP_S_AXI_DATA_H2C_00_bready direction I } \
   BRESP { physical_name BLP_S_AXI_DATA_H2C_00_bresp direction O left 1 right 0 } \
   BVALID { physical_name BLP_S_AXI_DATA_H2C_00_bvalid direction O } \
   RDATA { physical_name BLP_S_AXI_DATA_H2C_00_rdata direction O left 511 right 0 } \
   RID { physical_name BLP_S_AXI_DATA_H2C_00_rid direction O left 1 right 0 } \
   RLAST { physical_name BLP_S_AXI_DATA_H2C_00_rlast direction O } \
   RREADY { physical_name BLP_S_AXI_DATA_H2C_00_rready direction I } \
   RRESP { physical_name BLP_S_AXI_DATA_H2C_00_rresp direction O left 1 right 0 } \
   RVALID { physical_name BLP_S_AXI_DATA_H2C_00_rvalid direction O } \
   WDATA { physical_name BLP_S_AXI_DATA_H2C_00_wdata direction I left 511 right 0 } \
   WLAST { physical_name BLP_S_AXI_DATA_H2C_00_wlast direction I } \
   WREADY { physical_name BLP_S_AXI_DATA_H2C_00_wready direction O } \
   WSTRB { physical_name BLP_S_AXI_DATA_H2C_00_wstrb direction I left 63 right 0 } \
   WVALID { physical_name BLP_S_AXI_DATA_H2C_00_wvalid direction I } \
   } \
  BLP_S_AXI_DATA_H2C_00 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {39} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.CLK_DOMAIN {cd_pcie_00} \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.FREQ_HZ {250000000} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {1} \
   CONFIG.HAS_LOCK {1} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {2} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {16} \
   CONFIG.NUM_READ_THREADS {2} \
   CONFIG.NUM_WRITE_OUTSTANDING {16} \
   CONFIG.NUM_WRITE_THREADS {2} \
   CONFIG.PHASE {0} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $BLP_S_AXI_DATA_H2C_00

  set io_clk_qsfp_refclka_00 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 -board_intf qsfp_refclk0 io_clk_qsfp_refclka_00 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {161132813} \
   ] $io_clk_qsfp_refclka_00
  set_property HDL_ATTRIBUTE.BOARD_INTERFACE {qsfp_refclk0} [get_bd_intf_ports io_clk_qsfp_refclka_00]

  set io_clk_qsfp_refclkb_00 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 -board_intf qsfp_refclk1 io_clk_qsfp_refclkb_00 ]
  set_property HDL_ATTRIBUTE.BOARD_INTERFACE {qsfp_refclk1} [get_bd_intf_ports io_clk_qsfp_refclkb_00]


  # Create ports
  set blp_m_data_hbm_temp_00 [ create_bd_port -dir O -from 6 -to 0 -type data blp_m_data_hbm_temp_00 ]
  set blp_m_data_hbm_temp_01 [ create_bd_port -dir O -from 6 -to 0 -type data blp_m_data_hbm_temp_01 ]
  set blp_m_data_memory_calib_complete_00 [ create_bd_port -dir O -from 0 -to 0 -type data blp_m_data_memory_calib_complete_00 ]
  set blp_m_irq_cu_00 [ create_bd_port -dir O -from 127 -to 0 -type intr blp_m_irq_cu_00 ]
  set blp_m_irq_hbm_cattrip_00 [ create_bd_port -dir O -from 0 -to 0 -type intr blp_m_irq_hbm_cattrip_00 ]
  set blp_s_aclk_ctrl_00 [ create_bd_port -dir I -type clk -freq_hz 50000000 blp_s_aclk_ctrl_00 ]
  set_property -dict [ list \
   CONFIG.CLK_DOMAIN {cd_ctrl_00} \
   CONFIG.PHASE {0} \
 ] $blp_s_aclk_ctrl_00
  set blp_s_aclk_freerun_ref_00 [ create_bd_port -dir I -type clk -freq_hz 100000000 blp_s_aclk_freerun_ref_00 ]
  set_property -dict [ list \
   CONFIG.CLK_DOMAIN {cd_freerun_ref_00} \
   CONFIG.PHASE {0} \
 ] $blp_s_aclk_freerun_ref_00
  set blp_s_aclk_pcie_00 [ create_bd_port -dir I -type clk -freq_hz 250000000 blp_s_aclk_pcie_00 ]
  set_property -dict [ list \
   CONFIG.CLK_DOMAIN {cd_pcie_00} \
   CONFIG.PHASE {0} \
 ] $blp_s_aclk_pcie_00
  set blp_s_aresetn_ctrl_00 [ create_bd_port -dir I -from 0 -to 0 -type rst blp_s_aresetn_ctrl_00 ]
  set blp_s_aresetn_pcie_00 [ create_bd_port -dir I -from 0 -to 0 -type rst blp_s_aresetn_pcie_00 ]
  set blp_s_data_satellite_ctrl_data_00 [ create_bd_port -dir I -from 1 -to 0 -type data blp_s_data_satellite_ctrl_data_00 ]
  set clk_kernel2_in [ create_bd_port -dir I -type clk -freq_hz 500000000 clk_kernel2_in ]
  set clk_kernel2_out [ create_bd_port -dir O -type clk clk_kernel2_out ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {500000000} \
 ] $clk_kernel2_out
  set clk_kernel_in [ create_bd_port -dir I -type clk -freq_hz 300000000 clk_kernel_in ]
  set clk_kernel_out [ create_bd_port -dir O -type clk clk_kernel_out ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {300000000} \
 ] $clk_kernel_out
  set hbm_aclk_in [ create_bd_port -dir I -type clk -freq_hz 450000000 hbm_aclk_in ]
  set hbm_aclk_out [ create_bd_port -dir O -type clk hbm_aclk_out ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {450000000} \
 ] $hbm_aclk_out
  set io_gt_qsfp_00_grx_n [ create_bd_port -dir I -from 0 -to 3 io_gt_qsfp_00_grx_n ]
  set io_gt_qsfp_00_grx_p [ create_bd_port -dir I -from 0 -to 3 io_gt_qsfp_00_grx_p ]
  set io_gt_qsfp_00_gtx_n [ create_bd_port -dir O -from 3 -to 0 io_gt_qsfp_00_gtx_n ]
  set io_gt_qsfp_00_gtx_p [ create_bd_port -dir O -from 3 -to 0 io_gt_qsfp_00_gtx_p ]

  # Create instance: SLR0
  create_hier_cell_SLR0 [current_bd_instance .] SLR0

  # Create instance: SLR1
  create_hier_cell_SLR1 [current_bd_instance .] SLR1

  # Create instance: System_DPA
  create_hier_cell_System_DPA [current_bd_instance .] System_DPA

  # Create instance: aurora_64b66b_0, and set properties
  set aurora_64b66b_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_64b66b:12.0 aurora_64b66b_0 ]
  set_property -dict [ list \
   CONFIG.CHANNEL_ENABLE {X0Y28} \
   CONFIG.C_AURORA_LANES {1} \
   CONFIG.C_GT_LOC_2 {X} \
   CONFIG.C_GT_LOC_3 {X} \
   CONFIG.C_GT_LOC_4 {X} \
   CONFIG.C_LINE_RATE {25.78125} \
   CONFIG.C_REFCLK_FREQUENCY {161.1328125} \
   CONFIG.C_REFCLK_SOURCE {MGTREFCLK0_of_Quad_X0Y7} \
   CONFIG.C_START_LANE {X0Y28} \
   CONFIG.C_START_QUAD {Quad_X0Y7} \
   CONFIG.C_UCOLUMN_USED {left} \
   CONFIG.C_USER_K {false} \
   CONFIG.C_USE_BYTESWAP {false} \
   CONFIG.SINGLEEND_GTREFCLK {true} \
   CONFIG.SupportLevel {1} \
   CONFIG.crc_mode {false} \
   CONFIG.drp_mode {Disabled} \
   CONFIG.flow_mode {None} \
   CONFIG.interface_mode {Streaming} \
 ] $aurora_64b66b_0

  # Create instance: aurora_64b66b_1, and set properties
  set aurora_64b66b_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_64b66b:12.0 aurora_64b66b_1 ]
  set_property -dict [ list \
   CONFIG.CHANNEL_ENABLE {X0Y29} \
   CONFIG.C_AURORA_LANES {1} \
   CONFIG.C_GT_LOC_2 {X} \
   CONFIG.C_GT_LOC_3 {X} \
   CONFIG.C_LINE_RATE {25.78125} \
   CONFIG.C_REFCLK_FREQUENCY {161.1328125} \
   CONFIG.C_REFCLK_SOURCE {MGTREFCLK0_of_Quad_X0Y7} \
   CONFIG.C_START_LANE {X0Y29} \
   CONFIG.C_START_QUAD {Quad_X0Y7} \
   CONFIG.C_UCOLUMN_USED {left} \
   CONFIG.drp_mode {Disabled} \
   CONFIG.interface_mode {Streaming} \
 ] $aurora_64b66b_1

  # Create instance: aurora_64b66b_2, and set properties
  set aurora_64b66b_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_64b66b:12.0 aurora_64b66b_2 ]
  set_property -dict [ list \
   CONFIG.CHANNEL_ENABLE {X0Y30} \
   CONFIG.C_LINE_RATE {25.78125} \
   CONFIG.C_REFCLK_FREQUENCY {161.1328125} \
   CONFIG.C_REFCLK_SOURCE {MGTREFCLK0_of_Quad_X0Y7} \
   CONFIG.C_START_LANE {X0Y30} \
   CONFIG.C_START_QUAD {Quad_X0Y7} \
   CONFIG.C_UCOLUMN_USED {left} \
   CONFIG.drp_mode {Disabled} \
   CONFIG.interface_mode {Streaming} \
 ] $aurora_64b66b_2

  # Create instance: aurora_64b66b_3, and set properties
  set aurora_64b66b_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_64b66b:12.0 aurora_64b66b_3 ]
  set_property -dict [ list \
   CONFIG.CHANNEL_ENABLE {X0Y31} \
   CONFIG.C_LINE_RATE {25.78125} \
   CONFIG.C_REFCLK_FREQUENCY {161.1328125} \
   CONFIG.C_REFCLK_SOURCE {MGTREFCLK0_of_Quad_X0Y7} \
   CONFIG.C_START_LANE {X0Y31} \
   CONFIG.C_START_QUAD {Quad_X0Y7} \
   CONFIG.C_UCOLUMN_USED {left} \
   CONFIG.drp_mode {Disabled} \
   CONFIG.interface_mode {Streaming} \
 ] $aurora_64b66b_3

  # Create instance: axi_data_sc, and set properties
  set axi_data_sc [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_data_sc ]
  set_property -dict [ list \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {1} \
 ] $axi_data_sc

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
 ] $axi_gpio_0

  # Create instance: axi_vip_data, and set properties
  set axi_vip_data [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.1 axi_vip_data ]
  set_property HDL_ATTRIBUTE.DPA_TRACE_MASTER {true} [get_bd_intf_pins /axi_vip_data/M_AXI]

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {4} \
 ] $axis_broadcaster_0

  # Create instance: axis_clock_converter_inbound, and set properties
  set axis_clock_converter_inbound [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_inbound ]
  set_property -dict [ list \
   CONFIG.HAS_TLAST {1} \
   CONFIG.TDATA_NUM_BYTES {32} \
 ] $axis_clock_converter_inbound

  # Create instance: axis_clock_converter_outbound, and set properties
  set axis_clock_converter_outbound [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_outbound ]
  set_property -dict [ list \
   CONFIG.HAS_TLAST {1} \
   CONFIG.TDATA_NUM_BYTES {32} \
 ] $axis_clock_converter_outbound

  # Create instance: axis_combiner_0, and set properties
  set axis_combiner_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0 ]
  set_property -dict [ list \
   CONFIG.NUM_SI {4} \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_combiner_0

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_data_fifo_5

  # Create instance: axis_data_fifo_6, and set properties
  set axis_data_fifo_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_6 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_data_fifo_6

  # Create instance: axis_data_fifo_7, and set properties
  set axis_data_fifo_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_7 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_data_fifo_7

  # Create instance: axis_data_fifo_8, and set properties
  set axis_data_fifo_8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_8 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_data_fifo_8

  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]
  set_property -dict [ list \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_register_slice_0

  # Create instance: axis_register_slice_1, and set properties
  set axis_register_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_1 ]
  set_property -dict [ list \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_register_slice_1

  # Create instance: axis_register_slice_2, and set properties
  set axis_register_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_2 ]
  set_property -dict [ list \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_register_slice_2

  # Create instance: axis_register_slice_3, and set properties
  set axis_register_slice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_3 ]
  set_property -dict [ list \
   CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_register_slice_3

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {8} \
   CONFIG.S_TDATA_NUM_BYTES {32} \
   CONFIG.TDATA_REMAP {tdata[63:0]} \
 ] $axis_subset_converter_0

  # Create instance: axis_subset_converter_1, and set properties
  set axis_subset_converter_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_1 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {8} \
   CONFIG.S_TDATA_NUM_BYTES {32} \
   CONFIG.TDATA_REMAP {tdata[127:64]} \
 ] $axis_subset_converter_1

  # Create instance: axis_subset_converter_2, and set properties
  set axis_subset_converter_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_2 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {8} \
   CONFIG.S_TDATA_NUM_BYTES {32} \
   CONFIG.TDATA_REMAP {tdata[191:128]} \
 ] $axis_subset_converter_2

  # Create instance: axis_subset_converter_3, and set properties
  set axis_subset_converter_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_3 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {8} \
   CONFIG.S_TDATA_NUM_BYTES {32} \
   CONFIG.TDATA_REMAP {tdata[255:192]} \
 ] $axis_subset_converter_3

  # Create instance: axis_switch_1, and set properties
  set axis_switch_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_1 ]
  set_property -dict [ list \
   CONFIG.ARB_ON_MAX_XFERS {256} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.TDATA_NUM_BYTES {32} \
 ] $axis_switch_1

  # Create instance: debug_bridge_xsdbm, and set properties
  set debug_bridge_xsdbm [ create_bd_cell -type ip -vlnv xilinx.com:ip:debug_bridge:3.0 debug_bridge_xsdbm ]
  set_property -dict [ list \
   CONFIG.C_DEBUG_MODE {1} \
   CONFIG.C_DESIGN_TYPE {1} \
   CONFIG.C_ENABLE_CLK_DIVIDER {false} \
 ] $debug_bridge_xsdbm

  # Create instance: hmss_0, and set properties
  set hmss_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:hbm_memory_subsystem:1.0 hmss_0 ]
  set_property -dict [ list \
   CONFIG.ADVANCED_PROPERTIES {NULL NULL HBM_PORT_PROHIBIT {S30_AXI S31_AXI} HBM_STAGED_CALIBRATION true} \
   CONFIG.DISABLE_HBM_REF_CLK_BUFG {true} \
   CONFIG.NUM_SI {2} \
   CONFIG.NUM_SI_ARESETN {2} \
   CONFIG.NUM_SI_CLKS {2} \
   CONFIG.S00_MEM {HBM_MEM00 HBM_MEM01} \
   CONFIG.S00_SLR {SLR0} \
   CONFIG.S01_MEM {HBM_MEM01} \
   CONFIG.S01_RA {0} \
 ] $hmss_0

  # Create instance: ii_level0_wire, and set properties
  set ii_level0_wire [ create_bd_cell -type ip -vlnv xilinx.com:ip:ii_level0_wire:1.0 ii_level0_wire ]

  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_0 ]
  set_property -dict [ list \
   CONFIG.ALL_PROBE_SAME_MU_CNT {2} \
   CONFIG.C_DATA_DEPTH {4096} \
   CONFIG.C_ENABLE_ILA_AXI_MON {false} \
   CONFIG.C_MONITOR_TYPE {Native} \
   CONFIG.C_NUM_OF_PROBES {1} \
   CONFIG.C_PROBE0_MU_CNT {2} \
   CONFIG.C_PROBE0_WIDTH {32} \
 ] $ila_0

  # Create instance: interrupt_concat
  create_hier_cell_interrupt_concat [current_bd_instance .] interrupt_concat

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: proc_sys_reset_ctrl_slr0, and set properties
  set proc_sys_reset_ctrl_slr0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_ctrl_slr0 ]

  # Create instance: proc_sys_reset_ctrl_slr1, and set properties
  set proc_sys_reset_ctrl_slr1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_ctrl_slr1 ]

  # Create instance: proc_sys_reset_kernel2_slr0, and set properties
  set proc_sys_reset_kernel2_slr0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_kernel2_slr0 ]

  # Create instance: proc_sys_reset_kernel2_slr1, and set properties
  set proc_sys_reset_kernel2_slr1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_kernel2_slr1 ]

  # Create instance: proc_sys_reset_kernel_slr0, and set properties
  set proc_sys_reset_kernel_slr0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_kernel_slr0 ]

  # Create instance: proc_sys_reset_kernel_slr1, and set properties
  set proc_sys_reset_kernel_slr1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_kernel_slr1 ]

  # Create instance: satellite_gpio_slice_1, and set properties
  set satellite_gpio_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 satellite_gpio_slice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {2} \
   CONFIG.DOUT_WIDTH {1} \
 ] $satellite_gpio_slice_1

  # Create instance: simple_hGradient, and set properties
  set simple_hGradient [ create_bd_cell -type ip -vlnv xilinx.com:hls:simple_hGradient:1.0 simple_hGradient ]
  set_property HDL_ATTRIBUTE.DPA_MONITOR {true} [get_bd_cells simple_hGradient]
  set_property HDL_ATTRIBUTE.DPA_MONITOR {true} [get_bd_intf_pins /simple_hGradient/out_r]

  # Create instance: str2mem, and set properties
  set str2mem [ create_bd_cell -type ip -vlnv xilinx.com:hls:str2mem:1.0 str2mem ]
  set_property HDL_ATTRIBUTE.DPA_MONITOR {true} [get_bd_cells str2mem]
  set_property HDL_ATTRIBUTE.DPA_MONITOR {true} [get_bd_intf_pins /str2mem/in_r]
  set_property HDL_ATTRIBUTE.DPA_MONITOR {true} [get_bd_intf_pins /str2mem/m_axi_aximm1]

  # Create instance: ulp_ucs, and set properties
  set ulp_ucs [ create_bd_cell -type ip -vlnv xilinx.com:ip:shell_ucs_subsystem:2.0 ulp_ucs ]
  set_property -dict [ list \
   CONFIG.HAS_HBM_CLK {3} \
   CONFIG.NUM_SLR {2} \
 ] $ulp_ucs

  # Create instance: user_debug_bridge, and set properties
  set user_debug_bridge [ create_bd_cell -type ip -vlnv xilinx.com:ip:debug_bridge:3.0 user_debug_bridge ]
  set_property -dict [ list \
   CONFIG.C_DEBUG_MODE {2} \
   CONFIG.C_DESIGN_TYPE {1} \
   CONFIG.C_ENABLE_CLK_DIVIDER {false} \
   CONFIG.C_NUM_BS_MASTER {1} \
 ] $user_debug_bridge

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_0 ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $util_ds_buf_0

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_0

  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_1

  # Create instance: util_vector_logic_2, and set properties
  set util_vector_logic_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_2 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_2

  # Create instance: util_vector_logic_3, and set properties
  set util_vector_logic_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_3 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_3

  # Create instance: util_vector_logic_4, and set properties
  set util_vector_logic_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_4 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_4

  # Create instance: util_vector_logic_5, and set properties
  set util_vector_logic_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_5 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_5

  # Create instance: util_vector_logic_6, and set properties
  set util_vector_logic_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_6 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_6

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.IN5_WIDTH {4} \
   CONFIG.NUM_PORTS {29} \
 ] $xlconcat_0

  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_1 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {1} \
   CONFIG.IN1_WIDTH {1} \
   CONFIG.IN2_WIDTH {1} \
   CONFIG.IN3_WIDTH {1} \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_1

  # Create instance: xlconcat_2, and set properties
  set xlconcat_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_2 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {1} \
   CONFIG.IN1_WIDTH {1} \
   CONFIG.IN2_WIDTH {1} \
   CONFIG.IN3_WIDTH {1} \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_2

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {1} \
 ] $xlconstant_0

  # Create instance: xlconstant_high, and set properties
  set xlconstant_high [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_high ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
 ] $xlconstant_high

  # Create instance: xlconstant_low, and set properties
  set xlconstant_low [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_low ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_low

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {3} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {3} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_1

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2 ]

  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_3

  # Create instance: xlslice_4, and set properties
  set xlslice_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_4 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_4

  # Create instance: xlslice_5, and set properties
  set xlslice_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_5 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_5

  # Create instance: xlslice_6, and set properties
  set xlslice_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_6 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_6

  # Create instance: xlslice_9, and set properties
  set xlslice_9 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_9 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_9

  # Create instance: xlslice_10, and set properties
  set xlslice_10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_10 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_10

  # Create interface connections
  connect_bd_intf_net -intf_net BLP_S_AXI_CTRL_MGMT_00_1 [get_bd_intf_ports BLP_S_AXI_CTRL_MGMT_00] [get_bd_intf_pins ii_level0_wire/BLP_S_AXI_CTRL_MGMT_00]
  connect_bd_intf_net -intf_net BLP_S_AXI_CTRL_MGMT_01_1 [get_bd_intf_ports BLP_S_AXI_CTRL_MGMT_01] [get_bd_intf_pins ii_level0_wire/BLP_S_AXI_CTRL_MGMT_01]
  connect_bd_intf_net -intf_net BLP_S_AXI_CTRL_USER_00_1 [get_bd_intf_ports BLP_S_AXI_CTRL_USER_00] [get_bd_intf_pins ii_level0_wire/BLP_S_AXI_CTRL_USER_00]
  connect_bd_intf_net -intf_net BLP_S_AXI_CTRL_USER_01_1 [get_bd_intf_ports BLP_S_AXI_CTRL_USER_01] [get_bd_intf_pins ii_level0_wire/BLP_S_AXI_CTRL_USER_01]
  connect_bd_intf_net -intf_net BLP_S_AXI_CTRL_USER_02_1 [get_bd_intf_ports BLP_S_AXI_CTRL_USER_02] [get_bd_intf_pins ii_level0_wire/BLP_S_AXI_CTRL_USER_02]
  connect_bd_intf_net -intf_net BLP_S_AXI_DATA_H2C_00_1 [get_bd_intf_ports BLP_S_AXI_DATA_H2C_00] [get_bd_intf_pins ii_level0_wire/BLP_S_AXI_DATA_H2C_00]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins SLR1/M00_AXI] [get_bd_intf_pins System_DPA/S00_AXI]
  connect_bd_intf_net -intf_net SLR0_M01_AXI [get_bd_intf_pins SLR0/M01_AXI] [get_bd_intf_pins simple_hGradient/s_axi_control]
connect_bd_intf_net -intf_net [get_bd_intf_nets SLR0_M01_AXI] [get_bd_intf_pins SLR0/M01_AXI] [get_bd_intf_pins System_DPA/S_AXI_MON]
  connect_bd_intf_net -intf_net SLR0_M02_AXI [get_bd_intf_pins SLR0/M02_AXI] [get_bd_intf_pins str2mem/s_axi_control]
connect_bd_intf_net -intf_net [get_bd_intf_nets SLR0_M02_AXI] [get_bd_intf_pins SLR0/M02_AXI] [get_bd_intf_pins System_DPA/MON_S_AXI]
  connect_bd_intf_net -intf_net aurora_64b66b_0_USER_DATA_M_AXIS_RX [get_bd_intf_pins aurora_64b66b_0/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axis_register_slice_3/S_AXIS]
  connect_bd_intf_net -intf_net aurora_64b66b_1_USER_DATA_M_AXIS_RX [get_bd_intf_pins aurora_64b66b_1/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axis_register_slice_0/S_AXIS]
  connect_bd_intf_net -intf_net aurora_64b66b_2_USER_DATA_M_AXIS_RX [get_bd_intf_pins aurora_64b66b_2/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axis_register_slice_1/S_AXIS]
  connect_bd_intf_net -intf_net aurora_64b66b_3_USER_DATA_M_AXIS_RX [get_bd_intf_pins aurora_64b66b_3/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axis_register_slice_2/S_AXIS]
  connect_bd_intf_net -intf_net axi_data_sc_M00_AXI [get_bd_intf_pins axi_data_sc/M00_AXI] [get_bd_intf_pins hmss_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_data_sc_M01_AXI [get_bd_intf_pins SLR0/s_axi_data] [get_bd_intf_pins axi_data_sc/M01_AXI]
  connect_bd_intf_net -intf_net axi_data_sc_M03_AXI [get_bd_intf_pins System_DPA/S_AXI] [get_bd_intf_pins axi_data_sc/M03_AXI]
  connect_bd_intf_net -intf_net axi_vip_data_M_AXI [get_bd_intf_pins axi_data_sc/S00_AXI] [get_bd_intf_pins axi_vip_data/M_AXI]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins axis_subset_converter_1/S_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M02_AXIS [get_bd_intf_pins axis_broadcaster_0/M02_AXIS] [get_bd_intf_pins axis_subset_converter_2/S_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M03_AXIS [get_bd_intf_pins axis_broadcaster_0/M03_AXIS] [get_bd_intf_pins axis_subset_converter_3/S_AXIS]
  connect_bd_intf_net -intf_net axis_clock_converter_inbound_M_AXIS [get_bd_intf_pins axis_clock_converter_inbound/M_AXIS] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_clock_converter_outbound_M_AXIS [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins axis_clock_converter_outbound/M_AXIS]
  connect_bd_intf_net -intf_net axis_combiner_0_M_AXIS [get_bd_intf_pins axis_clock_converter_inbound/S_AXIS] [get_bd_intf_pins axis_combiner_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins axis_switch_1/S00_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins axis_combiner_0/S01_AXIS] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins axis_combiner_0/S02_AXIS] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins axis_combiner_0/S03_AXIS] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins axis_combiner_0/S00_AXIS] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins axis_data_fifo_1/S_AXIS] [get_bd_intf_pins axis_register_slice_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_register_slice_1_M_AXIS [get_bd_intf_pins axis_data_fifo_2/S_AXIS] [get_bd_intf_pins axis_register_slice_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_register_slice_2_M_AXIS [get_bd_intf_pins axis_data_fifo_3/S_AXIS] [get_bd_intf_pins axis_register_slice_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_register_slice_3_M_AXIS [get_bd_intf_pins axis_data_fifo_4/S_AXIS] [get_bd_intf_pins axis_register_slice_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_data_fifo_5/S_AXIS] [get_bd_intf_pins axis_subset_converter_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_1_M_AXIS [get_bd_intf_pins axis_data_fifo_6/S_AXIS] [get_bd_intf_pins axis_subset_converter_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_2_M_AXIS [get_bd_intf_pins axis_data_fifo_7/S_AXIS] [get_bd_intf_pins axis_subset_converter_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_3_M_AXIS [get_bd_intf_pins axis_data_fifo_8/S_AXIS] [get_bd_intf_pins axis_subset_converter_3/M_AXIS]
  connect_bd_intf_net -intf_net ii_level0_wire_ULP_M_AXI_CTRL_MGMT_00 [get_bd_intf_pins hmss_0/S_AXI_CTRL] [get_bd_intf_pins ii_level0_wire/ULP_M_AXI_CTRL_MGMT_00]
  connect_bd_intf_net -intf_net ii_level0_wire_ULP_M_AXI_CTRL_MGMT_01 [get_bd_intf_pins ii_level0_wire/ULP_M_AXI_CTRL_MGMT_01] [get_bd_intf_pins ulp_ucs/s_axi_ctrl_mgmt]
  connect_bd_intf_net -intf_net ii_level0_wire_ULP_M_AXI_CTRL_USER_02 [get_bd_intf_pins ii_level0_wire/ULP_M_AXI_CTRL_USER_02] [get_bd_intf_pins user_debug_bridge/S_AXI]
  connect_bd_intf_net -intf_net ii_level0_wire_ULP_M_AXI_DATA_H2C_00 [get_bd_intf_pins axi_vip_data/S_AXI] [get_bd_intf_pins ii_level0_wire/ULP_M_AXI_DATA_H2C_00]
  connect_bd_intf_net -intf_net io_clk_qsfp_refclka_00_1 [get_bd_intf_ports io_clk_qsfp_refclka_00] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
  connect_bd_intf_net -intf_net s_axi_ctrl_user_1 [get_bd_intf_pins SLR0/s_axi_ctrl_user] [get_bd_intf_pins ii_level0_wire/ULP_M_AXI_CTRL_USER_00]
  connect_bd_intf_net -intf_net s_axi_ctrl_user_2 [get_bd_intf_pins SLR1/s_axi_ctrl_user] [get_bd_intf_pins ii_level0_wire/ULP_M_AXI_CTRL_USER_01]
  connect_bd_intf_net -intf_net s_axi_data_1 [get_bd_intf_pins SLR1/s_axi_data] [get_bd_intf_pins axi_data_sc/M02_AXI]
  connect_bd_intf_net -intf_net simple_hGradient_out_r [get_bd_intf_pins axis_switch_1/M00_AXIS] [get_bd_intf_pins str2mem/in_r]
connect_bd_intf_net -intf_net [get_bd_intf_nets simple_hGradient_out_r] [get_bd_intf_pins System_DPA/MON_AXIS1] [get_bd_intf_pins axis_switch_1/M00_AXIS]
  connect_bd_intf_net -intf_net simple_hGradient_out_r1 [get_bd_intf_pins axis_clock_converter_outbound/S_AXIS] [get_bd_intf_pins simple_hGradient/out_r]
connect_bd_intf_net -intf_net [get_bd_intf_nets simple_hGradient_out_r1] [get_bd_intf_pins System_DPA/MON_AXIS] [get_bd_intf_pins axis_clock_converter_outbound/S_AXIS]
  connect_bd_intf_net -intf_net str2mem_m_axi_aximm1 [get_bd_intf_pins hmss_0/S01_AXI] [get_bd_intf_pins str2mem/m_axi_aximm1]
connect_bd_intf_net -intf_net [get_bd_intf_nets str2mem_m_axi_aximm1] [get_bd_intf_pins System_DPA/MON_M_AXI] [get_bd_intf_pins hmss_0/S01_AXI]
  connect_bd_intf_net -intf_net user_debug_bridge_m0_bscan [get_bd_intf_pins debug_bridge_xsdbm/S_BSCAN] [get_bd_intf_pins user_debug_bridge/m0_bscan]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins aurora_64b66b_1/m_axi_rx_tvalid] [get_bd_pins axis_register_slice_0/s_axis_tvalid]
  connect_bd_net -net aurora_64b66b_0_channel_up [get_bd_pins aurora_64b66b_0/channel_up] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net aurora_64b66b_0_gt_pll_lock [get_bd_pins aurora_64b66b_0/gt_pll_lock] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net aurora_64b66b_0_gt_qpllclk_quad1_out [get_bd_pins aurora_64b66b_0/gt_qpllclk_quad1_out] [get_bd_pins aurora_64b66b_1/gt_qpllclk_quad1_in] [get_bd_pins aurora_64b66b_2/gt_qpllclk_quad1_in] [get_bd_pins aurora_64b66b_3/gt_qpllclk_quad1_in]
  connect_bd_net -net aurora_64b66b_0_gt_qplllock_quad1_out [get_bd_pins aurora_64b66b_0/gt_qplllock_quad1_out] [get_bd_pins aurora_64b66b_1/gt_qplllock_quad1_in] [get_bd_pins aurora_64b66b_2/gt_qplllock_quad1_in] [get_bd_pins aurora_64b66b_3/gt_qplllock_quad1_in]
  connect_bd_net -net aurora_64b66b_0_gt_qpllrefclk_quad1_out [get_bd_pins aurora_64b66b_0/gt_qpllrefclk_quad1_out] [get_bd_pins aurora_64b66b_1/gt_qpllrefclk_quad1_in] [get_bd_pins aurora_64b66b_2/gt_qpllrefclk_quad1_in] [get_bd_pins aurora_64b66b_3/gt_qpllrefclk_quad1_in]
  connect_bd_net -net aurora_64b66b_0_gt_qpllrefclklost_quad1_out [get_bd_pins aurora_64b66b_0/gt_qpllrefclklost_quad1_out] [get_bd_pins aurora_64b66b_1/gt_qpllrefclklost_quad1] [get_bd_pins aurora_64b66b_2/gt_qpllrefclklost_quad1] [get_bd_pins aurora_64b66b_3/gt_qpllrefclklost_quad1]
  connect_bd_net -net aurora_64b66b_0_hard_err [get_bd_pins aurora_64b66b_0/hard_err] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net aurora_64b66b_0_lane_up [get_bd_pins aurora_64b66b_0/lane_up] [get_bd_pins xlconcat_0/In5]
  connect_bd_net -net aurora_64b66b_0_mmcm_not_locked_out [get_bd_pins aurora_64b66b_0/mmcm_not_locked_out] [get_bd_pins xlconcat_0/In6]
  connect_bd_net -net aurora_64b66b_0_s_axi_tx_tready [get_bd_pins aurora_64b66b_0/s_axi_tx_tready] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net aurora_64b66b_0_soft_err [get_bd_pins aurora_64b66b_0/soft_err] [get_bd_pins xlconcat_0/In7]
  connect_bd_net -net aurora_64b66b_0_sync_clk_out [get_bd_pins aurora_64b66b_0/sync_clk_out] [get_bd_pins aurora_64b66b_1/sync_clk] [get_bd_pins aurora_64b66b_2/sync_clk] [get_bd_pins aurora_64b66b_3/sync_clk]
  connect_bd_net -net aurora_64b66b_0_txn [get_bd_pins aurora_64b66b_0/txn] [get_bd_pins xlconcat_1/In3]
  connect_bd_net -net aurora_64b66b_0_txp [get_bd_pins aurora_64b66b_0/txp] [get_bd_pins xlconcat_2/In3]
  connect_bd_net -net aurora_64b66b_0_user_clk_out [get_bd_pins aurora_64b66b_0/user_clk_out] [get_bd_pins aurora_64b66b_1/user_clk] [get_bd_pins aurora_64b66b_2/user_clk] [get_bd_pins aurora_64b66b_3/user_clk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_clock_converter_inbound/s_axis_aclk] [get_bd_pins axis_clock_converter_outbound/m_axis_aclk] [get_bd_pins axis_combiner_0/aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk] [get_bd_pins axis_data_fifo_6/s_axis_aclk] [get_bd_pins axis_data_fifo_7/s_axis_aclk] [get_bd_pins axis_data_fifo_8/s_axis_aclk] [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins axis_register_slice_1/aclk] [get_bd_pins axis_register_slice_2/aclk] [get_bd_pins axis_register_slice_3/aclk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins axis_subset_converter_1/aclk] [get_bd_pins axis_subset_converter_2/aclk] [get_bd_pins axis_subset_converter_3/aclk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
  connect_bd_net -net aurora_64b66b_1_channel_up [get_bd_pins aurora_64b66b_1/channel_up] [get_bd_pins xlconcat_0/In10]
  connect_bd_net -net aurora_64b66b_1_gt_pll_lock [get_bd_pins aurora_64b66b_1/gt_pll_lock] [get_bd_pins xlconcat_0/In11]
  connect_bd_net -net aurora_64b66b_1_gt_to_common_qpllreset_out [get_bd_pins aurora_64b66b_1/gt_to_common_qpllreset_out] [get_bd_pins xlconcat_0/In12]
  connect_bd_net -net aurora_64b66b_1_hard_err [get_bd_pins aurora_64b66b_1/hard_err] [get_bd_pins xlconcat_0/In13]
  connect_bd_net -net aurora_64b66b_1_lane_up [get_bd_pins aurora_64b66b_1/lane_up] [get_bd_pins xlconcat_0/In14]
  connect_bd_net -net aurora_64b66b_1_s_axi_tx_tready [get_bd_pins aurora_64b66b_1/s_axi_tx_tready] [get_bd_pins util_vector_logic_0/Op2]
  connect_bd_net -net aurora_64b66b_1_soft_err [get_bd_pins aurora_64b66b_1/soft_err] [get_bd_pins xlconcat_0/In15]
  connect_bd_net -net aurora_64b66b_1_txn [get_bd_pins aurora_64b66b_1/txn] [get_bd_pins xlconcat_1/In2]
  connect_bd_net -net aurora_64b66b_1_txp [get_bd_pins aurora_64b66b_1/txp] [get_bd_pins xlconcat_2/In2]
  connect_bd_net -net aurora_64b66b_2_channel_up [get_bd_pins aurora_64b66b_2/channel_up] [get_bd_pins xlconcat_0/In16]
  connect_bd_net -net aurora_64b66b_2_gt_pll_lock [get_bd_pins aurora_64b66b_2/gt_pll_lock] [get_bd_pins xlconcat_0/In17]
  connect_bd_net -net aurora_64b66b_2_gt_to_common_qpllreset_out [get_bd_pins aurora_64b66b_2/gt_to_common_qpllreset_out] [get_bd_pins xlconcat_0/In18]
  connect_bd_net -net aurora_64b66b_2_hard_err [get_bd_pins aurora_64b66b_2/hard_err] [get_bd_pins xlconcat_0/In19]
  connect_bd_net -net aurora_64b66b_2_lane_up [get_bd_pins aurora_64b66b_2/lane_up] [get_bd_pins xlconcat_0/In20]
  connect_bd_net -net aurora_64b66b_2_s_axi_tx_tready [get_bd_pins aurora_64b66b_2/s_axi_tx_tready] [get_bd_pins util_vector_logic_3/Op1]
  connect_bd_net -net aurora_64b66b_2_soft_err [get_bd_pins aurora_64b66b_2/soft_err] [get_bd_pins xlconcat_0/In21]
  connect_bd_net -net aurora_64b66b_2_txn [get_bd_pins aurora_64b66b_2/txn] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net aurora_64b66b_2_txp [get_bd_pins aurora_64b66b_2/txp] [get_bd_pins xlconcat_2/In1]
  connect_bd_net -net aurora_64b66b_3_channel_up [get_bd_pins aurora_64b66b_3/channel_up] [get_bd_pins xlconcat_0/In22]
  connect_bd_net -net aurora_64b66b_3_gt_pll_lock [get_bd_pins aurora_64b66b_3/gt_pll_lock] [get_bd_pins xlconcat_0/In23]
  connect_bd_net -net aurora_64b66b_3_gt_to_common_qpllreset_out [get_bd_pins aurora_64b66b_3/gt_to_common_qpllreset_out] [get_bd_pins xlconcat_0/In24]
  connect_bd_net -net aurora_64b66b_3_hard_err [get_bd_pins aurora_64b66b_3/hard_err] [get_bd_pins xlconcat_0/In25]
  connect_bd_net -net aurora_64b66b_3_lane_up [get_bd_pins aurora_64b66b_3/lane_up] [get_bd_pins xlconcat_0/In26]
  connect_bd_net -net aurora_64b66b_3_s_axi_tx_tready [get_bd_pins aurora_64b66b_3/s_axi_tx_tready] [get_bd_pins util_vector_logic_3/Op2]
  connect_bd_net -net aurora_64b66b_3_soft_err [get_bd_pins aurora_64b66b_3/soft_err] [get_bd_pins xlconcat_0/In27]
  connect_bd_net -net aurora_64b66b_3_txn [get_bd_pins aurora_64b66b_3/txn] [get_bd_pins xlconcat_1/In0]
  connect_bd_net -net aurora_64b66b_3_txp [get_bd_pins aurora_64b66b_3/txp] [get_bd_pins xlconcat_2/In0]
  connect_bd_net -net axis_data_fifo_5_m_axis_tdata [get_bd_pins aurora_64b66b_0/s_axi_tx_tdata] [get_bd_pins axis_data_fifo_5/m_axis_tdata]
  connect_bd_net -net axis_data_fifo_5_m_axis_tvalid [get_bd_pins axis_data_fifo_5/m_axis_tvalid] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net axis_data_fifo_6_m_axis_tdata [get_bd_pins aurora_64b66b_1/s_axi_tx_tdata] [get_bd_pins axis_data_fifo_6/m_axis_tdata]
  connect_bd_net -net axis_data_fifo_6_m_axis_tvalid [get_bd_pins axis_data_fifo_6/m_axis_tvalid] [get_bd_pins util_vector_logic_1/Op2]
  connect_bd_net -net axis_data_fifo_7_m_axis_tdata [get_bd_pins aurora_64b66b_2/s_axi_tx_tdata] [get_bd_pins axis_data_fifo_7/m_axis_tdata]
  connect_bd_net -net axis_data_fifo_7_m_axis_tvalid [get_bd_pins axis_data_fifo_7/m_axis_tvalid] [get_bd_pins util_vector_logic_5/Op1]
  connect_bd_net -net axis_data_fifo_8_m_axis_tdata [get_bd_pins aurora_64b66b_3/s_axi_tx_tdata] [get_bd_pins axis_data_fifo_8/m_axis_tdata]
  connect_bd_net -net axis_data_fifo_8_m_axis_tvalid [get_bd_pins axis_data_fifo_8/m_axis_tvalid] [get_bd_pins util_vector_logic_5/Op2]
  connect_bd_net -net blp_s_aclk_ctrl_00_1 [get_bd_ports blp_s_aclk_ctrl_00] [get_bd_pins ii_level0_wire/blp_s_aclk_ctrl_00]
  connect_bd_net -net blp_s_aclk_freerun_ref_00_1 [get_bd_ports blp_s_aclk_freerun_ref_00] [get_bd_pins ii_level0_wire/blp_s_aclk_freerun_ref_00]
  connect_bd_net -net blp_s_aclk_pcie_00_1 [get_bd_ports blp_s_aclk_pcie_00] [get_bd_pins ii_level0_wire/blp_s_aclk_pcie_00]
  connect_bd_net -net blp_s_aresetn_ctrl_00_1 [get_bd_ports blp_s_aresetn_ctrl_00] [get_bd_pins ii_level0_wire/blp_s_aresetn_ctrl_00]
  connect_bd_net -net blp_s_aresetn_pcie_00_1 [get_bd_ports blp_s_aresetn_pcie_00] [get_bd_pins ii_level0_wire/blp_s_aresetn_pcie_00]
  connect_bd_net -net blp_s_data_satellite_ctrl_data_00_1 [get_bd_ports blp_s_data_satellite_ctrl_data_00] [get_bd_pins ii_level0_wire/blp_s_data_satellite_ctrl_data_00]
  connect_bd_net -net clk_kernel2_in_1 [get_bd_ports clk_kernel2_in] [get_bd_pins SLR0/kernel_clk_2] [get_bd_pins SLR1/kernel_clk_2] [get_bd_pins proc_sys_reset_kernel2_slr0/slowest_sync_clk] [get_bd_pins proc_sys_reset_kernel2_slr1/slowest_sync_clk]
  connect_bd_net -net clk_kernel_in_1 [get_bd_ports clk_kernel_in] [get_bd_pins SLR0/kernel_clk_1] [get_bd_pins SLR1/kernel_clk_1] [get_bd_pins System_DPA/clk_kernel_in] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axis_clock_converter_inbound/m_axis_aclk] [get_bd_pins axis_clock_converter_outbound/s_axis_aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_1/aclk] [get_bd_pins hmss_0/aclk1] [get_bd_pins ila_0/clk] [get_bd_pins proc_sys_reset_kernel_slr0/slowest_sync_clk] [get_bd_pins proc_sys_reset_kernel_slr1/slowest_sync_clk] [get_bd_pins simple_hGradient/ap_clk] [get_bd_pins str2mem/ap_clk]
  connect_bd_net -net hbm_aclk_in_1 [get_bd_ports hbm_aclk_in] [get_bd_pins hmss_0/hbm_aclk]
  connect_bd_net -net hmss_0_DRAM_0_STAT_TEMP [get_bd_pins hmss_0/DRAM_0_STAT_TEMP] [get_bd_pins ii_level0_wire/ulp_s_data_hbm_temp_00]
  connect_bd_net -net hmss_0_DRAM_1_STAT_TEMP [get_bd_pins hmss_0/DRAM_1_STAT_TEMP] [get_bd_pins ii_level0_wire/ulp_s_data_hbm_temp_01]
  connect_bd_net -net hmss_0_DRAM_STAT_CATTRIP [get_bd_pins hmss_0/DRAM_STAT_CATTRIP] [get_bd_pins ii_level0_wire/ulp_s_irq_hbm_cattrip_00]
  connect_bd_net -net hmss_0_hbm_mc_init_seq_complete [get_bd_pins hmss_0/hbm_mc_init_seq_complete] [get_bd_pins ii_level0_wire/ulp_s_data_memory_calib_complete_00]
  connect_bd_net -net ii_level0_wire_blp_m_data_hbm_temp_00 [get_bd_ports blp_m_data_hbm_temp_00] [get_bd_pins ii_level0_wire/blp_m_data_hbm_temp_00]
  connect_bd_net -net ii_level0_wire_blp_m_data_hbm_temp_01 [get_bd_ports blp_m_data_hbm_temp_01] [get_bd_pins ii_level0_wire/blp_m_data_hbm_temp_01]
  connect_bd_net -net ii_level0_wire_blp_m_data_memory_calib_complete_00 [get_bd_ports blp_m_data_memory_calib_complete_00] [get_bd_pins ii_level0_wire/blp_m_data_memory_calib_complete_00]
  connect_bd_net -net ii_level0_wire_blp_m_irq_cu_00 [get_bd_ports blp_m_irq_cu_00] [get_bd_pins ii_level0_wire/blp_m_irq_cu_00]
  connect_bd_net -net ii_level0_wire_blp_m_irq_hbm_cattrip_00 [get_bd_ports blp_m_irq_hbm_cattrip_00] [get_bd_pins ii_level0_wire/blp_m_irq_hbm_cattrip_00]
  connect_bd_net -net ii_level0_wire_ulp_m_aclk_ctrl_00 [get_bd_pins SLR0/aclk_ctrl] [get_bd_pins SLR1/aclk_ctrl] [get_bd_pins System_DPA/S00_ACLK] [get_bd_pins debug_bridge_xsdbm/clk] [get_bd_pins hmss_0/ctrl_aclk] [get_bd_pins ii_level0_wire/ulp_m_aclk_ctrl_00] [get_bd_pins proc_sys_reset_ctrl_slr0/slowest_sync_clk] [get_bd_pins proc_sys_reset_ctrl_slr1/slowest_sync_clk] [get_bd_pins ulp_ucs/aclk_ctrl] [get_bd_pins user_debug_bridge/s_axi_aclk]
  connect_bd_net -net ii_level0_wire_ulp_m_aclk_freerun_ref_00 [get_bd_pins aurora_64b66b_0/init_clk] [get_bd_pins aurora_64b66b_1/init_clk] [get_bd_pins aurora_64b66b_2/init_clk] [get_bd_pins aurora_64b66b_3/init_clk] [get_bd_pins hmss_0/hbm_ref_clk] [get_bd_pins ii_level0_wire/ulp_m_aclk_freerun_ref_00] [get_bd_pins ulp_ucs/freerun_refclk] [get_bd_pins ulp_ucs/hbm_refclk]
  connect_bd_net -net ii_level0_wire_ulp_m_aclk_pcie_00 [get_bd_pins SLR0/aclk_pcie] [get_bd_pins SLR1/aclk_pcie] [get_bd_pins System_DPA/s_axi_aclk] [get_bd_pins axi_data_sc/aclk] [get_bd_pins axi_vip_data/aclk] [get_bd_pins hmss_0/aclk] [get_bd_pins ii_level0_wire/ulp_m_aclk_pcie_00] [get_bd_pins ulp_ucs/aclk_pcie]
  connect_bd_net -net ii_level0_wire_ulp_m_aresetn_ctrl_00 [get_bd_pins ii_level0_wire/ulp_m_aresetn_ctrl_00] [get_bd_pins ulp_ucs/aresetn_ctrl] [get_bd_pins user_debug_bridge/s_axi_aresetn]
  connect_bd_net -net ii_level0_wire_ulp_m_aresetn_pcie_00 [get_bd_pins ii_level0_wire/ulp_m_aresetn_pcie_00] [get_bd_pins ulp_ucs/aresetn_pcie]
  connect_bd_net -net ii_level0_wire_ulp_m_data_satellite_ctrl_data_00 [get_bd_pins ii_level0_wire/ulp_m_data_satellite_ctrl_data_00] [get_bd_pins satellite_gpio_slice_1/Din]
  connect_bd_net -net interrupt_concat_xlconcat_interrupt_dout [get_bd_pins ii_level0_wire/ulp_s_irq_cu_00] [get_bd_pins interrupt_concat/xlconcat_interrupt_dout]
  connect_bd_net -net io_gt_qsfp_00_grx_n_1 [get_bd_ports io_gt_qsfp_00_grx_n] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_10/Din] [get_bd_pins xlslice_3/Din] [get_bd_pins xlslice_5/Din]
  connect_bd_net -net io_gt_qsfp_00_grx_p_1 [get_bd_ports io_gt_qsfp_00_grx_p] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_4/Din] [get_bd_pins xlslice_6/Din] [get_bd_pins xlslice_9/Din]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_clock_converter_inbound/s_axis_aresetn] [get_bd_pins axis_clock_converter_outbound/m_axis_aresetn] [get_bd_pins axis_combiner_0/aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn] [get_bd_pins axis_data_fifo_6/s_axis_aresetn] [get_bd_pins axis_data_fifo_7/s_axis_aresetn] [get_bd_pins axis_data_fifo_8/s_axis_aresetn] [get_bd_pins axis_register_slice_0/aresetn] [get_bd_pins axis_register_slice_1/aresetn] [get_bd_pins axis_register_slice_2/aresetn] [get_bd_pins axis_register_slice_3/aresetn] [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins axis_subset_converter_1/aresetn] [get_bd_pins axis_subset_converter_2/aresetn] [get_bd_pins axis_subset_converter_3/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net proc_sys_reset_0_peripheral_reset [get_bd_pins aurora_64b66b_0/reset_pb] [get_bd_pins aurora_64b66b_1/reset_pb] [get_bd_pins aurora_64b66b_2/reset_pb] [get_bd_pins aurora_64b66b_3/reset_pb] [get_bd_pins proc_sys_reset_0/peripheral_reset]
  connect_bd_net -net proc_sys_reset_ctrl_slr0_peripheral_aresetn [get_bd_pins SLR0/aresetn_ctrl] [get_bd_pins hmss_0/ctrl_aresetn] [get_bd_pins proc_sys_reset_ctrl_slr0/peripheral_aresetn]
  connect_bd_net -net proc_sys_reset_ctrl_slr1_peripheral_aresetn [get_bd_pins SLR1/aresetn_ctrl] [get_bd_pins System_DPA/S00_ARESETN] [get_bd_pins proc_sys_reset_ctrl_slr1/peripheral_aresetn]
  connect_bd_net -net proc_sys_reset_kernel2_slr0_peripheral_aresetn [get_bd_pins SLR0/aresetn_kernel2] [get_bd_pins proc_sys_reset_kernel2_slr0/peripheral_aresetn]
  connect_bd_net -net proc_sys_reset_kernel2_slr1_peripheral_aresetn [get_bd_pins SLR1/aresetn_kernel2] [get_bd_pins proc_sys_reset_kernel2_slr1/peripheral_aresetn]
  connect_bd_net -net proc_sys_reset_kernel_slr0_interconnect_aresetn [get_bd_pins SLR0/M01_ARESETN] [get_bd_pins proc_sys_reset_kernel_slr0/interconnect_aresetn]
  connect_bd_net -net proc_sys_reset_kernel_slr0_peripheral_aresetn [get_bd_pins SLR0/aresetn_kernel] [get_bd_pins System_DPA/trace_rst] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axis_clock_converter_inbound/m_axis_aresetn] [get_bd_pins axis_clock_converter_outbound/s_axis_aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_1/aresetn] [get_bd_pins hmss_0/aresetn1] [get_bd_pins proc_sys_reset_kernel_slr0/peripheral_aresetn] [get_bd_pins simple_hGradient/ap_rst_n] [get_bd_pins str2mem/ap_rst_n]
  connect_bd_net -net proc_sys_reset_kernel_slr1_peripheral_aresetn [get_bd_pins SLR1/aresetn_kernel] [get_bd_pins proc_sys_reset_kernel_slr1/peripheral_aresetn]
  connect_bd_net -net satellite_gpio_slice_1_Dout [get_bd_pins satellite_gpio_slice_1/Dout] [get_bd_pins ulp_ucs/shutdown_clocks]
  connect_bd_net -net simple_hGradient_interrupt [get_bd_pins interrupt_concat/In0] [get_bd_pins simple_hGradient/interrupt]
  connect_bd_net -net str2mem_interrupt [get_bd_pins interrupt_concat/In1] [get_bd_pins str2mem/interrupt]
  connect_bd_net -net ulp_ucs_aresetn_ctrl_slr0 [get_bd_pins proc_sys_reset_ctrl_slr0/ext_reset_in] [get_bd_pins ulp_ucs/aresetn_ctrl_slr0]
  connect_bd_net -net ulp_ucs_aresetn_ctrl_slr1 [get_bd_pins proc_sys_reset_ctrl_slr1/ext_reset_in] [get_bd_pins ulp_ucs/aresetn_ctrl_slr1]
  connect_bd_net -net ulp_ucs_aresetn_kernel2_slr0 [get_bd_pins proc_sys_reset_kernel2_slr0/ext_reset_in] [get_bd_pins ulp_ucs/aresetn_kernel2_slr0]
  connect_bd_net -net ulp_ucs_aresetn_kernel2_slr1 [get_bd_pins proc_sys_reset_kernel2_slr1/ext_reset_in] [get_bd_pins ulp_ucs/aresetn_kernel2_slr1]
  connect_bd_net -net ulp_ucs_aresetn_kernel_slr0 [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins proc_sys_reset_kernel_slr0/ext_reset_in] [get_bd_pins ulp_ucs/aresetn_kernel_slr0]
  connect_bd_net -net ulp_ucs_aresetn_kernel_slr1 [get_bd_pins proc_sys_reset_kernel_slr1/ext_reset_in] [get_bd_pins ulp_ucs/aresetn_kernel_slr1]
  connect_bd_net -net ulp_ucs_aresetn_pcie_slr0 [get_bd_pins SLR0/aresetn_pcie] [get_bd_pins System_DPA/s_axi_aresetn] [get_bd_pins axi_data_sc/aresetn] [get_bd_pins axi_vip_data/aresetn] [get_bd_pins hmss_0/aresetn] [get_bd_pins ulp_ucs/aresetn_pcie_slr0]
  connect_bd_net -net ulp_ucs_aresetn_pcie_slr1 [get_bd_pins SLR1/aresetn_pcie] [get_bd_pins ulp_ucs/aresetn_pcie_slr1]
  connect_bd_net -net ulp_ucs_clk_kernel [get_bd_ports clk_kernel_out] [get_bd_pins ulp_ucs/clk_kernel]
  connect_bd_net -net ulp_ucs_clk_kernel2 [get_bd_ports clk_kernel2_out] [get_bd_pins ulp_ucs/clk_kernel2]
  connect_bd_net -net ulp_ucs_hbm_aclk [get_bd_ports hbm_aclk_out] [get_bd_pins ulp_ucs/hbm_aclk]
  connect_bd_net -net ulp_ucs_hbm_aresetn [get_bd_pins hmss_0/hbm_aresetn] [get_bd_pins ulp_ucs/hbm_aresetn]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins aurora_64b66b_0/refclk1_in] [get_bd_pins aurora_64b66b_1/refclk1_in] [get_bd_pins aurora_64b66b_2/refclk1_in] [get_bd_pins aurora_64b66b_3/refclk1_in] [get_bd_pins util_ds_buf_0/IBUF_OUT]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins axis_data_fifo_5/m_axis_tready] [get_bd_pins axis_data_fifo_6/m_axis_tready] [get_bd_pins axis_data_fifo_7/m_axis_tready] [get_bd_pins axis_data_fifo_8/m_axis_tready] [get_bd_pins util_vector_logic_4/Res] [get_bd_pins util_vector_logic_6/Op1]
  connect_bd_net -net util_vector_logic_0_Res1 [get_bd_pins util_vector_logic_0/Res] [get_bd_pins util_vector_logic_4/Op2] [get_bd_pins xlconcat_0/In8]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins util_vector_logic_1/Res] [get_bd_pins util_vector_logic_2/Op2]
  connect_bd_net -net util_vector_logic_2_Res [get_bd_pins aurora_64b66b_0/s_axi_tx_tvalid] [get_bd_pins aurora_64b66b_1/s_axi_tx_tvalid] [get_bd_pins aurora_64b66b_2/s_axi_tx_tvalid] [get_bd_pins aurora_64b66b_3/s_axi_tx_tvalid] [get_bd_pins util_vector_logic_6/Res]
  connect_bd_net -net util_vector_logic_2_Res1 [get_bd_pins util_vector_logic_2/Res] [get_bd_pins util_vector_logic_6/Op2]
  connect_bd_net -net util_vector_logic_3_Res [get_bd_pins util_vector_logic_3/Res] [get_bd_pins util_vector_logic_4/Op1] [get_bd_pins xlconcat_0/In28]
  connect_bd_net -net util_vector_logic_5_Res [get_bd_pins util_vector_logic_2/Op1] [get_bd_pins util_vector_logic_5/Res]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins SLR0/gpio_io_i] [get_bd_pins axi_gpio_0/gpio_io_i] [get_bd_pins ila_0/probe0] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconcat_1_dout [get_bd_ports io_gt_qsfp_00_gtx_n] [get_bd_pins xlconcat_1/dout]
  connect_bd_net -net xlconcat_2_dout [get_bd_ports io_gt_qsfp_00_gtx_p] [get_bd_pins xlconcat_2/dout]
  connect_bd_net -net xlconstant_high_dout [get_bd_pins xlconcat_0/In9] [get_bd_pins xlconstant_high/dout]
  connect_bd_net -net xlconstant_low_dout [get_bd_pins aurora_64b66b_0/pma_init] [get_bd_pins aurora_64b66b_1/pma_init] [get_bd_pins aurora_64b66b_2/pma_init] [get_bd_pins aurora_64b66b_3/pma_init] [get_bd_pins xlconstant_low/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins aurora_64b66b_0/rxp] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_10_Dout [get_bd_pins aurora_64b66b_1/rxn] [get_bd_pins xlslice_10/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins aurora_64b66b_0/rxn] [get_bd_pins xlslice_1/Dout]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins aurora_64b66b_2/rxn] [get_bd_pins xlslice_3/Dout]
  connect_bd_net -net xlslice_4_Dout [get_bd_pins aurora_64b66b_2/rxp] [get_bd_pins xlslice_4/Dout]
  connect_bd_net -net xlslice_5_Dout [get_bd_pins aurora_64b66b_3/rxn] [get_bd_pins xlslice_5/Dout]
  connect_bd_net -net xlslice_6_Dout [get_bd_pins aurora_64b66b_3/rxp] [get_bd_pins xlslice_6/Dout]
  connect_bd_net -net xlslice_9_Dout [get_bd_pins aurora_64b66b_1/rxp] [get_bd_pins xlslice_9/Dout]

  # Create address segments
  assign_bd_address -offset 0x017FF000 -range 0x00001000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_user_00] [get_bd_addr_segs SLR0/axi_gpio_null/S_AXI/Reg] -force
  assign_bd_address -offset 0x01800000 -range 0x00001000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_user_01] [get_bd_addr_segs System_DPA/dpa_fifo/S_AXI/Mem0] -force
  assign_bd_address -offset 0x000201420000 -range 0x00002000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs System_DPA/dpa_fifo/S_AXI_FULL/Mem1] -force
  assign_bd_address -offset 0x01810000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_user_01] [get_bd_addr_segs System_DPA/dpa_hub/S_AXI/reg0] -force
  assign_bd_address -offset 0x01820000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_user_01] [get_bd_addr_segs System_DPA/dpa_mon0/S_AXI/reg0] -force
  assign_bd_address -offset 0x01830000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_user_01] [get_bd_addr_segs System_DPA/dpa_mon1/S_AXI/reg0] -force
  assign_bd_address -offset 0x01840000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_user_01] [get_bd_addr_segs System_DPA/dpa_mon2/S_AXI/reg0] -force
  assign_bd_address -offset 0x01850000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_user_01] [get_bd_addr_segs System_DPA/dpa_mon3/S_AXI/reg0] -force
  assign_bd_address -offset 0x01860000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_user_01] [get_bd_addr_segs System_DPA/dpa_mon4/S_AXI/reg0] -force
  assign_bd_address -offset 0x00800000 -range 0x00400000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_mgmt_00] [get_bd_addr_segs hmss_0/S_AXI_CTRL/HBM_CTRL00] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM03] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM04] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM05] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM06] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM07] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM15] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM16] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM17] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM18] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM19] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM20] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM21] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM22] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM23] -force
  assign_bd_address -offset 0x000180000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM24] -force
  assign_bd_address -offset 0x000190000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM25] -force
  assign_bd_address -offset 0x0001A0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM26] -force
  assign_bd_address -offset 0x0001B0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM27] -force
  assign_bd_address -offset 0x0001C0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM28] -force
  assign_bd_address -offset 0x0001D0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM29] -force
  assign_bd_address -offset 0x0001E0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM30] -force
  assign_bd_address -offset 0x0001F0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_data_h2c_00] [get_bd_addr_segs hmss_0/S00_AXI/HBM_MEM31] -force
  assign_bd_address -offset 0x01400000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_user_00] [get_bd_addr_segs simple_hGradient/s_axi_control/Reg] -force
  assign_bd_address -offset 0x01410000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_user_00] [get_bd_addr_segs str2mem/s_axi_control/Reg] -force
  assign_bd_address -offset 0x01000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_mgmt_01] [get_bd_addr_segs ulp_ucs/s_axi_ctrl_mgmt/Reg] -force
  assign_bd_address -offset 0x01200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ii_level0_wire/ulp_m_axi_ctrl_user_02] [get_bd_addr_segs user_debug_bridge/S_AXI/REG] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces str2mem/Data_m_axi_aximm1] [get_bd_addr_segs hmss_0/S01_AXI/HBM_MEM01] -force
  assign_bd_address -offset 0x00000000 -range 0x000400000000 -target_address_space [get_bd_addr_spaces BLP_S_AXI_DATA_H2C_00] [get_bd_addr_segs ii_level0_wire/blp_s_axi_data_h2c_00/DDR4_MEM_00] -force
  assign_bd_address -offset 0x00800000 -range 0x00800000 -target_address_space [get_bd_addr_spaces BLP_S_AXI_CTRL_MGMT_00] [get_bd_addr_segs ii_level0_wire/blp_s_axi_ctrl_mgmt_00/UNKNOWN_SEGMENTS_00] -force
  assign_bd_address -offset 0x01000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces BLP_S_AXI_CTRL_MGMT_01] [get_bd_addr_segs ii_level0_wire/blp_s_axi_ctrl_mgmt_01/UNKNOWN_SEGMENTS_00] -force
  assign_bd_address -offset 0x01400000 -range 0x00400000 -target_address_space [get_bd_addr_spaces BLP_S_AXI_CTRL_USER_00] [get_bd_addr_segs ii_level0_wire/blp_s_axi_ctrl_user_00/UNKNOWN_SEGMENTS_00] -force
  assign_bd_address -offset 0x01800000 -range 0x00400000 -target_address_space [get_bd_addr_spaces BLP_S_AXI_CTRL_USER_01] [get_bd_addr_segs ii_level0_wire/blp_s_axi_ctrl_user_01/UNKNOWN_SEGMENTS_00] -force
  assign_bd_address -offset 0x01200000 -range 0x00200000 -target_address_space [get_bd_addr_spaces BLP_S_AXI_CTRL_USER_02] [get_bd_addr_segs ii_level0_wire/blp_s_axi_ctrl_user_02/UNKNOWN_SEGMENTS_00] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  # Create PFM attributes
  set_property PFM_NAME {xilinx.com:xd:xilinx_u50_xdma_201920_3:201920.3} [get_files [current_bd_design].bd]
  set_property PFM.CLOCK {blp_s_aclk_ctrl {id "2" is_default "false" proc_sys_reset "proc_sys_reset_ctrl_slr0" status "fixed"}  blp_s_aclk_ctrl {id "2" is_default "false" proc_sys_reset "proc_sys_reset_ctrl_slr1" status "fixed"} } [get_bd_ports /blp_s_aclk_ctrl_00]
  set_property PFM.CLOCK {clk_kernel2 {id "1" is_default "false" proc_sys_reset "proc_sys_reset_kernel2_slr0" status "scalable"}  clk_kernel2 {id "1" is_default "false" proc_sys_reset "proc_sys_reset_kernel2_slr1" status "scalable"} } [get_bd_ports /clk_kernel2_in]
  set_property PFM.CLOCK {clk_kernel {id "0" is_default "true" proc_sys_reset "proc_sys_reset_kernel_slr0" status "scalable"}  clk_kernel {id "0" is_default "true" proc_sys_reset "proc_sys_reset_kernel_slr1" status "scalable"} } [get_bd_ports /clk_kernel_in]
  set_property PFM.MEMSS {HBM {  HBM_MEM00 "auto preferred"  HBM_MEM01 "auto true"  HBM_MEM02 "auto true"  HBM_MEM03 "auto true"  HBM_MEM04 "auto true"  HBM_MEM05 "auto true"  HBM_MEM06 "auto true"  HBM_MEM07 "auto true"  HBM_MEM08 "auto true"  HBM_MEM09 "auto true"  HBM_MEM10 "auto true"  HBM_MEM11 "auto true"  HBM_MEM12 "auto true"  HBM_MEM13 "auto true"  HBM_MEM14 "auto true"  HBM_MEM15 "auto true"  HBM_MEM16 "auto true"  HBM_MEM17 "auto true"  HBM_MEM18 "auto true"  HBM_MEM19 "auto true"  HBM_MEM20 "auto true"  HBM_MEM21 "auto true"  HBM_MEM22 "auto true"  HBM_MEM23 "auto true"  HBM_MEM24 "auto true"  HBM_MEM25 "auto true"  HBM_MEM26 "auto true"  HBM_MEM27 "auto true"  HBM_MEM28 "auto true"  HBM_MEM29 "auto true"  HBM_MEM30 "auto true"  HBM_MEM31 "auto true"  } } [get_bd_cells /hmss_0]
  set_property PFM.AXI_PORT {M01_AXI {memport "M_AXI_GP"} M02_AXI {memport "M_AXI_GP"} M03_AXI {memport "M_AXI_GP"} M04_AXI {memport "M_AXI_GP"} M05_AXI {memport "M_AXI_GP"} M06_AXI {memport "M_AXI_GP"} M07_AXI {memport "M_AXI_GP"} M08_AXI {memport "M_AXI_GP"} M09_AXI {memport "M_AXI_GP"} M10_AXI {memport "M_AXI_GP"} M11_AXI {memport "M_AXI_GP"} M12_AXI {memport "M_AXI_GP"} M13_AXI {memport "M_AXI_GP"} M14_AXI {memport "M_AXI_GP"} M15_AXI {memport "M_AXI_GP"} M16_AXI {memport "M_AXI_GP"} M17_AXI {memport "M_AXI_GP"} M18_AXI {memport "M_AXI_GP"} M19_AXI {memport "M_AXI_GP"} M20_AXI {memport "M_AXI_GP"} M21_AXI {memport "M_AXI_GP"} M22_AXI {memport "M_AXI_GP"} M23_AXI {memport "M_AXI_GP"} M24_AXI {memport "M_AXI_GP"} M25_AXI {memport "M_AXI_GP"} M26_AXI {memport "M_AXI_GP"} M27_AXI {memport "M_AXI_GP"} M28_AXI {memport "M_AXI_GP"} M29_AXI {memport "M_AXI_GP"} M30_AXI {memport "M_AXI_GP"}} [get_bd_cells /SLR0/interconnect_axilite_user]
  set_property PFM.AXI_PORT {M01_AXI {memport "M_AXI_GP"} M02_AXI {memport "M_AXI_GP"} M03_AXI {memport "M_AXI_GP"} M04_AXI {memport "M_AXI_GP"} M05_AXI {memport "M_AXI_GP"} M06_AXI {memport "M_AXI_GP"} M07_AXI {memport "M_AXI_GP"} M08_AXI {memport "M_AXI_GP"} M09_AXI {memport "M_AXI_GP"} M10_AXI {memport "M_AXI_GP"} M11_AXI {memport "M_AXI_GP"} M12_AXI {memport "M_AXI_GP"} M13_AXI {memport "M_AXI_GP"} M14_AXI {memport "M_AXI_GP"} M15_AXI {memport "M_AXI_GP"} M16_AXI {memport "M_AXI_GP"} M17_AXI {memport "M_AXI_GP"} M18_AXI {memport "M_AXI_GP"} M19_AXI {memport "M_AXI_GP"} M20_AXI {memport "M_AXI_GP"} M21_AXI {memport "M_AXI_GP"} M22_AXI {memport "M_AXI_GP"} M23_AXI {memport "M_AXI_GP"} M24_AXI {memport "M_AXI_GP"} M25_AXI {memport "M_AXI_GP"} M26_AXI {memport "M_AXI_GP"} M27_AXI {memport "M_AXI_GP"} M28_AXI {memport "M_AXI_GP"} M29_AXI {memport "M_AXI_GP"} M30_AXI {memport "M_AXI_GP"} M31_AXI {memport "M_AXI_GP"} M32_AXI {memport "M_AXI_GP"} M33_AXI {memport "M_AXI_GP"} M34_AXI {memport "M_AXI_GP"} M35_AXI {memport "M_AXI_GP"} M36_AXI {memport "M_AXI_GP"} M37_AXI {memport "M_AXI_GP"} M38_AXI {memport "M_AXI_GP"} M39_AXI {memport "M_AXI_GP"} M40_AXI {memport "M_AXI_GP"} M41_AXI {memport "M_AXI_GP"} M42_AXI {memport "M_AXI_GP"} M43_AXI {memport "M_AXI_GP"} M44_AXI {memport "M_AXI_GP"} M45_AXI {memport "M_AXI_GP"} M46_AXI {memport "M_AXI_GP"} M47_AXI {memport "M_AXI_GP"} M48_AXI {memport "M_AXI_GP"} M49_AXI {memport "M_AXI_GP"} M50_AXI {memport "M_AXI_GP"} M51_AXI {memport "M_AXI_GP"} M52_AXI {memport "M_AXI_GP"} M53_AXI {memport "M_AXI_GP"} M54_AXI {memport "M_AXI_GP"} M55_AXI {memport "M_AXI_GP"} M56_AXI {memport "M_AXI_GP"} M57_AXI {memport "M_AXI_GP"} M58_AXI {memport "M_AXI_GP"} M59_AXI {memport "M_AXI_GP"} M60_AXI {memport "M_AXI_GP"} M61_AXI {memport "M_AXI_GP"} M62_AXI {memport "M_AXI_GP"}} [get_bd_cells /SLR1/interconnect_axilite_user]


  validate_bd_design

  set_property HDL_ATTRIBUTE.LOCKED {true} [get_bd_intf_ports BLP_S_AXI_CTRL_MGMT_00]
  set_property HDL_ATTRIBUTE.LOCKED {true} [get_bd_intf_ports BLP_S_AXI_CTRL_MGMT_01]
  set_property HDL_ATTRIBUTE.LOCKED {true} [get_bd_intf_ports BLP_S_AXI_CTRL_USER_00]
  set_property HDL_ATTRIBUTE.LOCKED {true} [get_bd_intf_ports BLP_S_AXI_CTRL_USER_01]
  set_property HDL_ATTRIBUTE.LOCKED {true} [get_bd_intf_ports BLP_S_AXI_CTRL_USER_02]
  set_property HDL_ATTRIBUTE.LOCKED {true} [get_bd_intf_ports BLP_S_AXI_DATA_H2C_00]
  set_property HDL_ATTRIBUTE.LOCKED {true} [get_bd_intf_ports io_clk_qsfp_refclka_00]
  set_property HDL_ATTRIBUTE.LOCKED {true} [get_bd_intf_ports io_clk_qsfp_refclkb_00]

  # The first validate above is to propagate values prior to the set command(s)
  # above. Need second validate call to ensure design is validated.
  validate_bd_design

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


