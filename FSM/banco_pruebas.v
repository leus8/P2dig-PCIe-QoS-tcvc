`timescale 1ns / 100ps
`include "probador.v"
`include "maquina_estados_cond.v"
`include "maquina_estados_estr.v"
`include "./cells/cmos_cells.v"

module banco_pruebas;

/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire [4:0]		FIFO_EMPTIES;		// From probador of probador.v
wire [4:0]		FIFO_ERRORS;		// From probador of probador.v
wire			UmbralD0_cond;		// From maq_cond of maquina_estados_cond.v
wire			UmbralD0_estr;		// From maq_estr of maquina_estados_estr.v
wire			UmbralD1_cond;		// From maq_cond of maquina_estados_cond.v
wire			UmbralD1_estr;		// From maq_estr of maquina_estados_estr.v
wire			UmbralMF_cond;		// From maq_cond of maquina_estados_cond.v
wire			UmbralMF_estr;		// From maq_estr of maquina_estados_estr.v
wire			UmbralV0_cond;		// From maq_cond of maquina_estados_cond.v
wire			UmbralV0_estr;		// From maq_estr of maquina_estados_estr.v
wire			UmbralV1_cond;		// From maq_cond of maquina_estados_cond.v
wire			UmbralV1_estr;		// From maq_estr of maquina_estados_estr.v
wire [1:0]		UmbralesDs;		// From probador of probador.v
wire			UmbralesMFs;		// From probador of probador.v
wire [1:0]		UmbralesVCs;		// From probador of probador.v
wire			active_out_cond;	// From maq_cond of maquina_estados_cond.v
wire			active_out_estr;	// From maq_estr of maquina_estados_estr.v
wire			clk;			// From probador of probador.v
wire			error_out_cond;		// From maq_cond of maquina_estados_cond.v
wire			error_out_estr;		// From maq_estr of maquina_estados_estr.v
wire			idle_out_cond;		// From maq_cond of maquina_estados_cond.v
wire			idle_out_estr;		// From maq_estr of maquina_estados_estr.v
wire			init;			// From probador of probador.v
wire			reset;			// From probador of probador.v
// End of automatics

maquina_estados_cond maq_cond(/*AUTOINST*/
			      // Outputs
			      .error_out_cond	(error_out_cond),
			      .active_out_cond	(active_out_cond),
			      .idle_out_cond	(idle_out_cond),
			      .UmbralMF_cond	(UmbralMF_cond),
			      .UmbralV0_cond	(UmbralV0_cond),
			      .UmbralV1_cond	(UmbralV1_cond),
			      .UmbralD0_cond	(UmbralD0_cond),
			      .UmbralD1_cond	(UmbralD1_cond),
			      // Inputs
			      .clk		(clk),
			      .init		(init),
			      .UmbralesMFs	(UmbralesMFs),
			      .UmbralesVCs	(UmbralesVCs[1:0]),
			      .UmbralesDs	(UmbralesDs[1:0]),
			      .reset		(reset),
			      .FIFO_EMPTIES	(FIFO_EMPTIES[4:0]),
			      .FIFO_ERRORS	(FIFO_ERRORS[4:0]));




maquina_estados_estr maq_estr(/*AUTOINST*/
			      // Outputs
			      .UmbralD0_estr	(UmbralD0_estr),
			      .UmbralD1_estr	(UmbralD1_estr),
			      .UmbralMF_estr	(UmbralMF_estr),
			      .UmbralV0_estr	(UmbralV0_estr),
			      .UmbralV1_estr	(UmbralV1_estr),
			      .active_out_estr	(active_out_estr),
			      .error_out_estr	(error_out_estr),
			      .idle_out_estr	(idle_out_estr),
			      // Inputs
			      .FIFO_EMPTIES	(FIFO_EMPTIES[4:0]),
			      .FIFO_ERRORS	(FIFO_ERRORS[4:0]),
			      .UmbralesDs	(UmbralesDs[1:0]),
			      .UmbralesMFs	(UmbralesMFs),
			      .UmbralesVCs	(UmbralesVCs[1:0]),
			      .clk		(clk),
			      .init		(init),
			      .reset		(reset));

probador probador(/*AUTOINST*/
		  // Outputs
		  .clk			(clk),
		  .reset		(reset),
		  .init			(init),
		  .UmbralesMFs		(UmbralesMFs),
		  .UmbralesVCs		(UmbralesVCs[1:0]),
		  .UmbralesDs		(UmbralesDs[1:0]),
		  .FIFO_EMPTIES		(FIFO_EMPTIES[4:0]),
		  .FIFO_ERRORS		(FIFO_ERRORS[4:0]),
		  // Inputs
		  .error_out_cond	(error_out_cond),
		  .active_out_cond	(active_out_cond),
		  .idle_out_cond	(idle_out_cond),
		  .UmbralMF_cond	(UmbralMF_cond),
		  .UmbralV0_cond	(UmbralV0_cond),
		  .UmbralV1_cond	(UmbralV1_cond),
		  .UmbralD0_cond	(UmbralD0_cond),
		  .UmbralD1_cond	(UmbralD1_cond),
		  .error_out_estr	(error_out_estr),
		  .active_out_estr	(active_out_estr),
		  .idle_out_estr	(idle_out_estr),
		  .UmbralMF_estr	(UmbralMF_estr),
		  .UmbralV0_estr	(UmbralV0_estr),
		  .UmbralV1_estr	(UmbralV1_estr),
		  .UmbralD0_estr	(UmbralD0_estr),
		  .UmbralD1_estr	(UmbralD1_estr));

endmodule
