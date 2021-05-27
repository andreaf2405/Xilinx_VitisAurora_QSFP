# Xilinx_VitisAurora_QSFP
Vitis Example project for adding an Aurora core connected to the QSFP interface of Alveo U50


Two example projects I was experimenting on are added to the repository, one for the 1-lane Aurora core and the second for the 4-lane Aurora core. 

The Aurora core is inserted using the TCL hook "post_create_bd.tcl" in each design, whose use is specified in the config file. Also connections between kernels are rearranged accordingly.

The designs need a looback module to be inserted in the QSFP cage or need that the loopback option in the Aurora/GT is enabled, in order for the application to run. 
A first kernel is in charge of generating a "horizontal gradient" frame - whose size can be specified through Int arguments in the host application. The data is streamed into the Aurora core TX and is looped back onto the RX side, which is then connected to a second kernel that streams the data into the HBM memory.

Later, the frame is transferred to the host memory and an integrity check is run. (!the integrity check could fail as it has not been double-checked, normally image was visually verified)

Through PCIe XVC is possible to check the ILA probes that are also instatiated in the design by the TCL hook --> ISSUE: 4-lane "CHANNEL UP" signal is never coming up.
Seems that is a multi-lane Aurora IP issue somehow related to Vitis - it works when using Vivado.

