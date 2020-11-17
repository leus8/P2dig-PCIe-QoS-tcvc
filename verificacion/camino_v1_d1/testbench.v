`timescale 1ns/100ps

`include "Modulo_cond.v"
`include "Modulo_estr.v"

`include "cmos_cells.v"

`include "probador.v"

module testbench;

    // PARAMS
    parameter BW=6;
	parameter LEN4=4;
	parameter LEN16=16;

	/*AUTOWIRE*/
	// Beginning of automatic wires (for undeclared instantiated-module outputs)
	wire		active_out_estr;	// From md_str of Modulo_estr.v
	// End of automatics
	// Beginning of automatic wires (for undeclared instantiated-module outputs)
	wire [(BW-1):0]	D0_data_out;		// From md_cond of Modulo_cond.v, ..., Couldn't Merge
	wire		D0_empty;		// From md_cond of Modulo_cond.v, ...
	wire		D0_error_output;	// From md_cond of Modulo_cond.v, ...
	wire		D0_rd;			// From prb of probador.v
	wire [(BW-1):0]	D1_data_out;		// From md_cond of Modulo_cond.v, ..., Couldn't Merge
	wire		D1_empty;		// From md_cond of Modulo_cond.v, ...
	wire		D1_error_output;	// From md_cond of Modulo_cond.v, ...
	wire		D1_rd;			// From prb of probador.v
	wire [(BW-1):0]	Main_data_in;		// From prb of probador.v
	wire		Main_full;		// From md_cond of Modulo_cond.v, ...
	wire		Main_wr;		// From prb of probador.v
	wire [7:0]	UmbralesDs_HIGH;	// From prb of probador.v
	wire [7:0]	UmbralesDs_LOW;		// From prb of probador.v
	wire [3:0]	UmbralesMFs_HIGH;	// From prb of probador.v
	wire [3:0]	UmbralesMFs_LOW;	// From prb of probador.v
	wire [31:0]	UmbralesVCs_HIGH;	// From prb of probador.v
	wire [31:0]	UmbralesVCs_LOW;	// From prb of probador.v
	wire		active_out;		// From md_cond of Modulo_cond.v, ...
	wire		clk;			// From prb of probador.v
	wire [4:0]	error_full;		// From md_cond of Modulo_cond.v, ...
	wire		error_out;		// From md_cond of Modulo_cond.v, ...
	wire		idle_out;		// From md_cond of Modulo_cond.v, ...
	wire		init;			// From prb of probador.v
	wire		reset_L;		// From prb of probador.v
	// End oftomatics
	wire [5:0] D0_data_out_estr;
	wire D0_empty_estr;
	wire D0_error_output_estr;
	wire [5:0] D1_data_out_estr;
	wire D1_empty_estr;
	wire D1_error_output_estr;
	wire Main_full_estr;
	wire active_ou_estrt;
	wire [4:0] error_full_estr;
	wire error_out_estr;
	wire idle_out_estr;

    Modulo_cond md_cond (/*AUTOINST*/
			 // Outputs
			 .D0_data_out		(D0_data_out[(BW-1):0]),
			 .D1_data_out		(D1_data_out[(BW-1):0]),
			 .error_out		(error_out),
			 .active_out		(active_out),
			 .idle_out		(idle_out),
			 .D0_empty		(D0_empty),
			 .D0_error_output	(D0_error_output),
			 .D1_empty		(D1_empty),
			 .D1_error_output	(D1_error_output),
			 .Main_full		(Main_full),
			 .error_full		(error_full[4:0]),
			 // Inputs
			 .clk			(clk),
			 .reset_L		(reset_L),
			 .Main_wr		(Main_wr),
			 .Main_data_in		(Main_data_in[(BW-1):0]),
			 .D0_rd			(D0_rd),
			 .D1_rd			(D1_rd),
			 .init			(init),
			 .UmbralesMFs_HIGH	(UmbralesMFs_HIGH[3:0]),
			 .UmbralesMFs_LOW	(UmbralesMFs_LOW[3:0]),
			 .UmbralesVCs_HIGH	(UmbralesVCs_HIGH[31:0]),
			 .UmbralesVCs_LOW	(UmbralesVCs_LOW[31:0]),
			 .UmbralesDs_HIGH	(UmbralesDs_HIGH[7:0]),
			 .UmbralesDs_LOW	(UmbralesDs_LOW[7:0]));
	Modulo_estr md_str (
			    // Outputs
			    .D0_data_out	(D0_data_out_estr[5:0]),
			    .D0_empty		(D0_empty_estr),
			    .D0_error_output	(D0_error_output_estr),
			    .D1_data_out	(D1_data_out_estr[5:0]),
			    .D1_empty		(D1_empty_estr),
			    .D1_error_output	(D1_error_output_estr),
			    .Main_full		(Main_full_estr),
			    .active_out		(active_out_estr),
			    .error_full		(error_full_estr[4:0]),
			    .error_out		(error_out_estr),
			    .idle_out		(idle_out_estr),
				/*AUTOINST*/
			    // Inputs
			    .D0_rd		(D0_rd),
			    .D1_rd		(D1_rd),
			    .Main_data_in	(Main_data_in[5:0]),
			    .Main_wr		(Main_wr),
			    .UmbralesDs_HIGH	(UmbralesDs_HIGH[7:0]),
			    .UmbralesDs_LOW	(UmbralesDs_LOW[7:0]),
			    .UmbralesMFs_HIGH	(UmbralesMFs_HIGH[3:0]),
			    .UmbralesMFs_LOW	(UmbralesMFs_LOW[3:0]),
			    .UmbralesVCs_HIGH	(UmbralesVCs_HIGH[31:0]),
			    .UmbralesVCs_LOW	(UmbralesVCs_LOW[31:0]),
			    .clk		(clk),
			    .init		(init),
			    .reset_L		(reset_L));
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
		 .Main_full_estr	(Main_full_estr),
		 .D0_empty		(D0_empty),
		 .D0_error_output	(D0_error_output),
		 .D0_empty_estr		(D0_empty_estr),
		 .D0_error_output_estr	(D0_error_output_estr),
		 .D1_empty		(D1_empty),
		 .D1_error_output	(D1_error_output),
		 .D1_empty_estr		(D1_empty_estr),
		 .D1_error_output_estr	(D1_error_output_estr),
		 .D0_data_out		(D0_data_out[(BW-1):0]),
		 .D1_data_out		(D1_data_out[(BW-1):0]),
		 .D0_data_out_estr	(D0_data_out_estr[(BW-1):0]),
		 .D1_data_out_estr	(D1_data_out_estr[(BW-1):0]),
		 .error_out		(error_out),
		 .active_out		(active_out),
		 .idle_out		(idle_out),
		 .error_full		(error_full[4:0]),
		 .error_out_estr	(error_out_estr),
		 .active_out_estr	(active_out_estr),
		 .idle_out_estr		(idle_out_estr),
		 .error_full_estr	(error_full_estr[4:0]));


endmodule
