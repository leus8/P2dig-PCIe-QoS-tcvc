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
`include "maquina_estados_cond"
`include "interconnect"

module Module (    
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
    output reg error_out_cond,
    output reg active_out_cond,
    output reg idle_out_cond,
    output reg [4:0] error_full_cond);
    
    parameter BW=6;

interconnect intern0(/*AUTOINST*/
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
		     .D1_rd		(D1_rd));

maquina_estados_cond maquina(/*AUTOINST*/
			     // Outputs
			     .error_out_cond	(error_out_cond),
			     .active_out_cond	(active_out_cond),
			     .idle_out_cond	(idle_out_cond),
			     .UmbralMF_HIGH_cond(UmbralMF_HIGH_cond[3:0]),
			     .UmbralMF_LOW_cond	(UmbralMF_LOW_cond[3:0]),
			     .UmbralV0_HIGH_cond(UmbralV0_HIGH_cond[15:0]),
			     .UmbralV0_LOW_cond	(UmbralV0_LOW_cond[15:0]),
			     .UmbralV1_HIGH_cond(UmbralV1_HIGH_cond[15:0]),
			     .UmbralV1_LOW_cond	(UmbralV1_LOW_cond[15:0]),
			     .UmbralD0_HIGH_cond(UmbralD0_HIGH_cond[3:0]),
			     .UmbralD0_LOW_cond	(UmbralD0_LOW_cond[3:0]),
			     .UmbralD1_HIGH_cond(UmbralD1_HIGH_cond[3:0]),
			     .UmbralD1_LOW_cond	(UmbralD1_LOW_cond[3:0]),
			     .error_full_cond	(error_full_cond[4:0]),
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
