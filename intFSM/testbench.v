`timescale 1ns/100ps

`include "Modulo.v"

`include "probador.v"

module testbench;

    // PARAMS
    parameter BW=6;
	parameter LEN4=4;
	parameter LEN16=16;

	/*AUTOWIRE*/
	// Beginning of automatic wires (for undeclared instantiated-module outputs)
	wire [(BW-1):0]	D0_data_out;		// From md of Modulo.v
	wire		D0_empty;		// From md of Modulo.v
	wire		D0_error_output;	// From md of Modulo.v
	wire		D0_rd;			// From prb of probador.v
	wire [(BW-1):0]	D1_data_out;		// From md of Modulo.v
	wire		D1_empty;		// From md of Modulo.v
	wire		D1_error_output;	// From md of Modulo.v
	wire		D1_rd;			// From prb of probador.v
	wire [(BW-1):0]	Main_data_in;		// From prb of probador.v
	wire		Main_full;		// From md of Modulo.v
	wire		Main_wr;		// From prb of probador.v
	wire [7:0]	UmbralesDs_HIGH;	// From prb of probador.v
	wire [7:0]	UmbralesDs_LOW;		// From prb of probador.v
	wire [3:0]	UmbralesMFs_HIGH;	// From prb of probador.v
	wire [3:0]	UmbralesMFs_LOW;	// From prb of probador.v
	wire [31:0]	UmbralesVCs_HIGH;	// From prb of probador.v
	wire [31:0]	UmbralesVCs_LOW;	// From prb of probador.v
	wire		active_out_cond;	// From md of Modulo.v
	wire		clk;			// From prb of probador.v
	wire [4:0]	error_full_cond;	// From md of Modulo.v
	wire		error_out_cond;		// From md of Modulo.v
	wire		idle_out_cond;		// From md of Modulo.v
	wire		init;			// From prb of probador.v
	wire		reset_L;		// From prb of probador.v
	// End of automatics

    Modulo md (/*AUTOINST*/
	       // Outputs
	       .D0_data_out		(D0_data_out[(BW-1):0]),
	       .D1_data_out		(D1_data_out[(BW-1):0]),
	       .error_out_cond		(error_out_cond),
	       .active_out_cond		(active_out_cond),
	       .idle_out_cond		(idle_out_cond),
	       .D0_empty		(D0_empty),
	       .D0_error_output		(D0_error_output),
	       .D1_empty		(D1_empty),
	       .D1_error_output		(D1_error_output),
	       .Main_full		(Main_full),
	       .error_full_cond		(error_full_cond[4:0]),
	       // Inputs
	       .clk			(clk),
	       .reset_L			(reset_L),
	       .Main_wr			(Main_wr),
	       .Main_data_in		(Main_data_in[(BW-1):0]),
	       .D0_rd			(D0_rd),
	       .D1_rd			(D1_rd),
	       .init			(init),
	       .UmbralesMFs_HIGH	(UmbralesMFs_HIGH[3:0]),
	       .UmbralesMFs_LOW		(UmbralesMFs_LOW[3:0]),
	       .UmbralesVCs_HIGH	(UmbralesVCs_HIGH[31:0]),
	       .UmbralesVCs_LOW		(UmbralesVCs_LOW[31:0]),
	       .UmbralesDs_HIGH		(UmbralesDs_HIGH[7:0]),
	       .UmbralesDs_LOW		(UmbralesDs_LOW[7:0]));

    probador prb(/*AUTOINST*/
		 // Outputs
		 .reset_L		(reset_L),
		 .clk			(clk),
		 .Main_wr		(Main_wr),
		 .D0_rd			(D0_rd),
		 .D1_rd			(D1_rd),
		 .init			(init),
		 .Main_data_in		(Main_data_in[(BW-1):0]),
		 .UmbralesMFs_HIGH	(UmbralesMFs_HIGH[3:0]),
		 .UmbralesMFs_LOW	(UmbralesMFs_LOW[3:0]),
		 .UmbralesVCs_HIGH	(UmbralesVCs_HIGH[31:0]),
		 .UmbralesVCs_LOW	(UmbralesVCs_LOW[31:0]),
		 .UmbralesDs_HIGH	(UmbralesDs_HIGH[7:0]),
		 .UmbralesDs_LOW	(UmbralesDs_LOW[7:0]),
		 // Inputs
		 .Main_full		(Main_full),
		 .VC0_empty		(VC0_empty),
		 .VC0_error_output	(VC0_error_output),
		 .D0_empty		(D0_empty),
		 .D0_error_output	(D0_error_output),
		 .D1_empty		(D1_empty),
		 .D1_error_output	(D1_error_output),
		 .D0_data_out		(D0_data_out[(BW-1):0]),
		 .D1_data_out		(D1_data_out[(BW-1):0]),
		 .error_out_cond	(error_out_cond),
		 .active_out_cond	(active_out_cond),
		 .idle_out_cond		(idle_out_cond),
		 .error_full_cond	(error_full_cond[4:0]));


endmodule
