`include "Main.v"
`include "VC0.v"
`include "VC1.v"
`include "D0.v"
`include "D1.v"
`include "fifo_main_pop.v"
`include "pop_delay_vc0.v"
`include "demux_dest.v"
`include "demux_vc_id.v"
`include "mux.v"
`include "fifo.v"
`include "fifo16.v"
`include "maquina_estados.v"
`include "interconnect.v"

module Modulo (    
    input clk,
    input reset_L,
    input Main_wr,
    input [(BW-1):0] Main_data_in,
    input D0_rd,
    input D1_rd,
    output [(BW-1):0] D0_data_out,
    output [(BW-1):0] D1_data_out,
    input init,
    //MF
    input [3:0] UmbralesMFs_HIGH,
    input [3:0] UmbralesMFs_LOW,
    //VF
    input [31:0] UmbralesVCs_HIGH,
    input [31:0] UmbralesVCs_LOW,
    //DF
    input [7:0] UmbralesDs_HIGH,
    input [7:0] UmbralesDs_LOW,
    output error_out,
    output active_out,
    output idle_out,
	output D0_empty,
	output D0_error_output,
	output D1_empty,
	output D1_error_output,
	output Main_full,
    output [4:0] error_full);
    
    parameter BW=6;
	parameter LEN4=4;
	parameter LEN16=16;

	wire [4:0] FIFO_EMPTIES;
	wire [4:0] FIFO_ERRORS;
	wire [(LEN4-1):0] UmbralMF_HIGH;
	wire [(LEN4-1):0] UmbralMF_LOW;
	wire [(LEN16-1):0] UmbralV0_HIGH;
	wire [(LEN16-1):0] UmbralV0_LOW;
	wire [(LEN16-1):0] UmbralV1_HIGH;
	wire [(LEN16-1):0] UmbralV1_LOW;
	wire [(LEN4-1):0] UmbralD0_HIGH;
	wire [(LEN4-1):0] UmbralD0_LOW;
	wire [(LEN4-1):0] UmbralD1_HIGH;
	wire [(LEN4-1):0] UmbralD1_LOW;
 

	assign	FIFO_EMPTIES[0] = Main_empty;
	assign	FIFO_ERRORS[0] = Main_error_output;

	assign	FIFO_EMPTIES[1] = VC0_empty;
	assign	FIFO_ERRORS[1] = VC0_error_output;

	assign	FIFO_EMPTIES[2] = VC1_empty;
	assign	FIFO_ERRORS[2] = VC1_error_output;

	assign	FIFO_EMPTIES[3] = D0_empty;
	assign	FIFO_ERRORS[3] = D0_error_output;

	assign	FIFO_EMPTIES[4] = D1_empty;
	assign	FIFO_ERRORS[4] = D1_error_output;
	
	

interconnect intern0(
		     // Outputs
		     .D0_data_out	(D0_data_out[(BW-1):0]),
		     .D1_data_out	(D1_data_out[(BW-1):0]),
		     .Main_error_output	(Main_error_output),
		     .Main_empty	(Main_empty),
		     .Main_full		(Main_full),
		     .VC0_error_output	(VC0_error_output),
		     .VC0_empty		(VC0_empty),
		     .VC1_error_output	(VC1_error_output),
		     .VC1_empty		(VC1_empty),
		     .D0_error_output	(D0_error_output),
		     .D0_empty		(D0_empty),
		     .D1_error_output	(D1_error_output),
		     .D1_empty		(D1_empty),
		     // Inputs
		     .clk		(clk),
		     .reset_L		(reset_L),
		     .Main_wr		(Main_wr),
		     .Main_data_in	(Main_data_in[(BW-1):0]),
		     .D0_rd		(D0_rd),
		     .D1_rd		(D1_rd),
		     .UmbralMF_HIGH(UmbralMF_HIGH[(LEN4-1):0]),
		     .UmbralMF_LOW	(UmbralMF_LOW[(LEN4-1):0]),
		     .UmbralV0_HIGH(UmbralV0_HIGH[(LEN16-1):0]),
		     .UmbralV0_LOW	(UmbralV0_LOW[(LEN16-1):0]),
		     .UmbralV1_HIGH(UmbralV1_HIGH[(LEN16-1):0]),
		     .UmbralV1_LOW	(UmbralV1_LOW[(LEN16-1):0]),
		     .UmbralD0_LOW	(UmbralD0_LOW[(LEN4-1):0]),
		     .UmbralD0_HIGH(UmbralD0_HIGH[(LEN4-1):0]),
		     .UmbralD1_LOW	(UmbralD1_LOW[(LEN4-1):0]),
		     .UmbralD1_HIGH(UmbralD1_HIGH[(LEN4-1):0]));

maquina_estados maquina(
			     // Outputs
			     .error_out	(error_out),
			     .active_out	(active_out),
			     .idle_out	(idle_out),
			     .UmbralMF_HIGH(UmbralMF_HIGH[(LEN4-1):0]),
			     .UmbralMF_LOW	(UmbralMF_LOW[(LEN4-1):0]),
			     .UmbralV0_HIGH(UmbralV0_HIGH[(LEN16-1):0]),
			     .UmbralV0_LOW	(UmbralV0_LOW[(LEN16-1):0]),
			     .UmbralV1_HIGH(UmbralV1_HIGH[(LEN16-1):0]),
			     .UmbralV1_LOW	(UmbralV1_LOW[(LEN16-1):0]),
			     .UmbralD0_HIGH(UmbralD0_HIGH[(LEN4-1):0]),
			     .UmbralD0_LOW	(UmbralD0_LOW[(LEN4-1):0]),
			     .UmbralD1_HIGH(UmbralD1_HIGH[(LEN4-1):0]),
			     .UmbralD1_LOW	(UmbralD1_LOW[(LEN4-1):0]),
			     .error_full	(error_full[4:0]),
			     // Inputs
			     .clk		(clk),
			     .init		(init),
			     .UmbralesMFs_HIGH	(UmbralesMFs_HIGH[3:0]),
			     .UmbralesMFs_LOW	(UmbralesMFs_LOW[3:0]),
			     .UmbralesVCs_HIGH	(UmbralesVCs_HIGH[31:0]),
			     .UmbralesVCs_LOW	(UmbralesVCs_LOW[31:0]),
			     .UmbralesDs_HIGH	(UmbralesDs_HIGH[7:0]),
			     .UmbralesDs_LOW	(UmbralesDs_LOW[7:0]),
			     .reset_L		(reset_L),
			     .FIFO_EMPTIES	(FIFO_EMPTIES[4:0]),
			     .FIFO_ERRORS	(FIFO_ERRORS[4:0]));


endmodule
