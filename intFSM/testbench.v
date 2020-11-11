`timescale 1ns/100ps

`include "Module.v"

`include "probador.v"

module testbench;

    // PARAMS
    parameter BW=6;
    parameter BW4 = 6;
    parameter BW16 = 6;

	/*AUTOWIRE*/
	// Beginning of automatic wires (for undeclared instantiated-module outputs)
	wire [(BW-1):0]	D0_data_out;		// From intc of interconnect.v
	wire		D0_empty;		// From intc of interconnect.v
	wire		D0_error_output;	// From intc of interconnect.v
	wire		D0_rd;			// From prb of probador.v
	wire [(BW-1):0]	D1_data_out;		// From intc of interconnect.v
	wire		D1_empty;		// From intc of interconnect.v
	wire		D1_error_output;	// From intc of interconnect.v
	wire		D1_rd;			// From prb of probador.v
	wire [(BW-1):0]	Main_data_in;		// From prb of probador.v
	wire		Main_empty;		// From intc of interconnect.v
	wire		Main_error_output;	// From intc of interconnect.v
	wire		Main_full;		// From intc of interconnect.v
	wire		Main_wr;		// From prb of probador.v
	wire		VC0_empty;		// From intc of interconnect.v
	wire		VC0_error_output;	// From intc of interconnect.v
	wire		VC1_empty;		// From intc of interconnect.v
	wire		VC1_error_output;	// From intc of interconnect.v
	wire		clk;			// From prb of probador.v
	wire		reset_L;		// From prb of probador.v
	// End of automatics

    interconnect intc(/*AUTOINST*/
		      // Outputs
		      .D0_data_out	(D0_data_out[(BW-1):0]),
		      .D1_data_out	(D1_data_out[(BW-1):0]),
		      .Main_error_output(Main_error_output),
		      .Main_empty	(Main_empty),
		      .Main_full	(Main_full),
		      .VC0_error_output	(VC0_error_output),
		      .VC0_empty	(VC0_empty),
		      .VC1_error_output	(VC1_error_output),
		      .VC1_empty	(VC1_empty),
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

    probador prb(/*AUTOINST*/
		 // Outputs
		 .reset_L		(reset_L),
		 .clk			(clk),
		 .Main_wr		(Main_wr),
		 .D0_rd			(D0_rd),
		 .D1_rd			(D1_rd),
		 .Main_data_in		(Main_data_in[(BW-1):0]),
		 // Inputs
		 .Main_full		(Main_full),
		 .Main_empty		(Main_empty),
		 .Main_error_output	(Main_error_output),
		 .VC0_empty		(VC0_empty),
		 .VC0_error_output	(VC0_error_output),
		 .VC1_empty		(VC1_empty),
		 .VC1_error_output	(VC1_error_output),
		 .D0_empty		(D0_empty),
		 .D0_error_output	(D0_error_output),
		 .D1_empty		(D1_empty),
		 .D1_error_output	(D1_error_output),
		 .D0_data_out		(D0_data_out[(BW-1):0]),
		 .D1_data_out		(D1_data_out[(BW-1):0]));


endmodule
