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
wire [3:0]		UmbralD0_cond;		// From maq_cond of maquina_estados_cond.v
wire [3:0]		UmbralD0_estr;		// From maq_estr of maquina_estados_estr.v
wire [3:0]		UmbralD1_cond;		// From maq_cond of maquina_estados_cond.v
wire [3:0]		UmbralD1_estr;		// From maq_estr of maquina_estados_estr.v
wire [3:0]		UmbralMF_cond;		// From maq_cond of maquina_estados_cond.v
wire [3:0]		UmbralMF_estr;		// From maq_estr of maquina_estados_estr.v
wire [15:0]		UmbralV0_cond;		// From maq_cond of maquina_estados_cond.v
wire [15:0]		UmbralV0_estr;		// From maq_estr of maquina_estados_estr.v
wire [15:0]		UmbralV1_cond;		// From maq_cond of maquina_estados_cond.v
wire [15:0]		UmbralV1_estr;		// From maq_estr of maquina_estados_estr.v
wire [7:0]		UmbralesDs;		// From probador of probador.v
wire [3:0]		UmbralesMFs;		// From probador of probador.v
wire [31:0]		UmbralesVCs;		// From probador of probador.v
wire			active_out_cond;	// From maq_cond of maquina_estados_cond.v
wire			active_out_estr;	// From maq_estr of maquina_estados_estr.v
wire			clk;			// From probador of probador.v
wire [4:0]		error_full_cond;	// From maq_cond of maquina_estados_cond.v
wire [4:0]		error_full_estr;	// From maq_estr of maquina_estados_estr.v
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
			      .UmbralMF_cond	(UmbralMF_cond[3:0]),
			      .UmbralV0_cond	(UmbralV0_cond[15:0]),
			      .UmbralV1_cond	(UmbralV1_cond[15:0]),
			      .UmbralD0_cond	(UmbralD0_cond[3:0]),
			      .UmbralD1_cond	(UmbralD1_cond[3:0]),
			      .error_full_cond	(error_full_cond[4:0]),
			      // Inputs
			      .clk		(clk),
			      .init		(init),
			      .UmbralesMFs	(UmbralesMFs[3:0]),
			      .UmbralesVCs	(UmbralesVCs[31:0]),
			      .UmbralesDs	(UmbralesDs[7:0]),
			      .reset		(reset),
			      .FIFO_EMPTIES	(FIFO_EMPTIES[4:0]),
			      .FIFO_ERRORS	(FIFO_ERRORS[4:0]));




maquina_estados_estr maq_estr(/*AUTOINST*/
			      // Outputs
			      .UmbralD0_estr	(UmbralD0_estr[3:0]),
			      .UmbralD1_estr	(UmbralD1_estr[3:0]),
			      .UmbralMF_estr	(UmbralMF_estr[3:0]),
			      .UmbralV0_estr	(UmbralV0_estr[15:0]),
			      .UmbralV1_estr	(UmbralV1_estr[15:0]),
			      .active_out_estr	(active_out_estr),
			      .error_full_estr	(error_full_estr[4:0]),
			      .error_out_estr	(error_out_estr),
			      .idle_out_estr	(idle_out_estr),
			      // Inputs
			      .FIFO_EMPTIES	(FIFO_EMPTIES[4:0]),
			      .FIFO_ERRORS	(FIFO_ERRORS[4:0]),
			      .UmbralesDs	(UmbralesDs[7:0]),
			      .UmbralesMFs	(UmbralesMFs[3:0]),
			      .UmbralesVCs	(UmbralesVCs[31:0]),
			      .clk		(clk),
			      .init		(init),
			      .reset		(reset));

probador probador(/*AUTOINST*/
		  // Outputs
		  .clk			(clk),
		  .reset		(reset),
		  .init			(init),
		  .UmbralesMFs		(UmbralesMFs[3:0]),
		  .UmbralesVCs		(UmbralesVCs[31:0]),
		  .UmbralesDs		(UmbralesDs[7:0]),
		  .FIFO_EMPTIES		(FIFO_EMPTIES[4:0]),
		  .FIFO_ERRORS		(FIFO_ERRORS[4:0]),
		  // Inputs
		  .error_out_cond	(error_out_cond),
		  .active_out_cond	(active_out_cond),
		  .idle_out_cond	(idle_out_cond),
		  .UmbralMF_cond	(UmbralMF_cond[3:0]),
		  .UmbralV0_cond	(UmbralV0_cond[15:0]),
		  .UmbralV1_cond	(UmbralV1_cond[15:0]),
		  .UmbralD0_cond	(UmbralD0_cond[3:0]),
		  .UmbralD1_cond	(UmbralD1_cond[3:0]),
		  .error_full_cond	(error_full_cond[4:0]),
		  .error_out_estr	(error_out_estr),
		  .active_out_estr	(active_out_estr),
		  .idle_out_estr	(idle_out_estr),
		  .UmbralMF_estr	(UmbralMF_estr[3:0]),
		  .UmbralV0_estr	(UmbralV0_estr[15:0]),
		  .UmbralV1_estr	(UmbralV1_estr[15:0]),
		  .UmbralD0_estr	(UmbralD0_estr[3:0]),
		  .UmbralD1_estr	(UmbralD1_estr[3:0]),
		  .error_full_estr	(error_full_estr[4:0]));

endmodule
