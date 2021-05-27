`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2021 09:15:30 AM
// Design Name: 
// Module Name: Aurora_GT_intf
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Aurora_GT_intf

   (
    GT_SERIAL_RX_0_rxn,
    GT_SERIAL_RX_0_rxp,
    GT_SERIAL_TX_0_txn,
    GT_SERIAL_TX_0_txp,
    
    AuroraGT_rxn,
    AuroraGT_rxp,
    AuroraGT_txn,
    AuroraGT_txp,
    );

  (* X_INTERFACE_INFO = "xilinx.com:interface:gt_rtl:1.0 gt_serial_port GRX_P" *)
    input        [                             3:0] GT_SERIAL_RX_0_rxp;
    (* X_INTERFACE_INFO = "xilinx.com:interface:gt_rtl:1.0 gt_serial_port GRX_N" *)
	input        [                             3:0] GT_SERIAL_RX_0_rxn;
 (* X_INTERFACE_INFO = "xilinx.com:interface:gt_rtl:1.0 gt_serial_port GTX_P" *)
	output       [                             3:0] GT_SERIAL_TX_0_txp; 
	(* X_INTERFACE_INFO = "xilinx.com:interface:gt_rtl:1.0 gt_serial_port GTX_N" *)
	output       [                             3:0] GT_SERIAL_TX_0_txn;
	
//	(* X_INTERFACE_INFO = "xilinx.com:interface:gt_rtl:1.0 gt_tx GRX_N" *)
//    input        [                             0:0] AuroraGT_txn;
//    (* X_INTERFACE_INFO = "xilinx.com:interface:gt_rtl:1.0 gt_tx GRX_P" *)
//	input        [                             0:0] AuroraGT_txp;
//    (* X_INTERFACE_INFO = "xilinx.com:interface:gt_rtl:1.0 gt_rx GTX_N" *)
//	output       [                             0:0] AuroraGT_rxn; 
//	(* X_INTERFACE_INFO = "xilinx.com:interface:gt_rtl:1.0 gt_rx GTX_P" *)
//	output       [                             0:0] AuroraGT_rxp;
	
////		(* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 AuroraGT_tx V_N" *)
//    input        [                             0:0] AuroraGT_txn;
////    (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 AuroraGT_tx V_P" *)
//	input        [                             0:0] AuroraGT_txp;
////    (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 AuroraGT_rx V_N" *)
//	output       [                             0:0] AuroraGT_rxn; 
////	(* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 AuroraGT_rx V_P" *)
//	output       [                             0:0] AuroraGT_rxp;
	
	(* X_INTERFACE_INFO = "xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 AuroraGT_tx TXN" *)
    input        [                             1:0] AuroraGT_txn;
    (* X_INTERFACE_INFO = "xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 AuroraGT_tx TXP" *)
	input        [                             1:0] AuroraGT_txp;
    (* X_INTERFACE_INFO = "xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 AuroraGT_rx RXN" *)
	output       [                             1:0] AuroraGT_rxn; 
	(* X_INTERFACE_INFO = "xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 AuroraGT_rx RXP" *)
	output       [                             1:0] AuroraGT_rxp;
	
	
	genvar i;
	generate
	for(i=0 ; i < 2; i=i+1) begin
	   // assign AuroraGT_rxp[1-i] = GT_SERIAL_RX_0_rxp[i];
	   // assign AuroraGT_rxn[1-i] = GT_SERIAL_RX_0_rxn[i];
	   // assign GT_SERIAL_TX_0_txp[i] = AuroraGT_txp[1-i];
	   // assign GT_SERIAL_TX_0_txn[i] = AuroraGT_txn[1-i];
	   assign AuroraGT_rxp[i:i] = GT_SERIAL_RX_0_rxp[i:i];
	   assign AuroraGT_rxn[i:i] = GT_SERIAL_RX_0_rxn[i:i];
	   assign GT_SERIAL_TX_0_txp[i:i] = AuroraGT_txp[i:i];
	   assign GT_SERIAL_TX_0_txn[i:i] = AuroraGT_txn[i:i];
	   end
	endgenerate
	
//  input [0:0]GT_SERIAL_RX_0_rxn;
//  input [0:0]GT_SERIAL_RX_0_rxp;
//  output [0:0]GT_SERIAL_TX_0_txn;
//  output [0:0]GT_SERIAL_TX_0_txp;





endmodule
