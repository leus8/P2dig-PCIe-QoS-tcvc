`timescale 1ns / 100ps

`include "probador.v"

`include "cmos_cells.v"

`include "mux.v"
`include "mux_estr.v"

module testbench;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		clk;			// From prb of probador.v
    wire [5:0]		data_in0;		// From prb of probador.v
    wire [5:0]		data_in0_estr;		// From prb of probador.v
    wire [5:0]		data_in1;		// From prb of probador.v
    wire [5:0]		data_in1_estr;		// From prb of probador.v
    wire [5:0]		data_out;		// From m of mux.v
    wire		reset_L;		// From prb of probador.v
    wire		selector;		// From prb of probador.v
    wire		valid_in0;		// From prb of probador.v
    wire		valid_in0_estr;		// From prb of probador.v
    wire		valid_in1;		// From prb of probador.v
    wire		valid_in1_estr;		// From prb of probador.v
    wire		valid_out;		// From m of mux.v
    // End of automatics

    // Estructurales
    wire [5:0] data_out_estr;
    wire valid_out_estr;

    mux m (/*AUTOINST*/
	   // Outputs
	   .valid_out			(valid_out),
	   .data_out			(data_out[5:0]),
	   // Inputs
	   .clk				(clk),
	   .reset_L			(reset_L),
	   .selector			(selector),
	   .data_in0			(data_in0[5:0]),
	   .valid_in0			(valid_in0),
	   .data_in1			(data_in1[5:0]),
	   .valid_in1			(valid_in1));

    mux_estr m_estr (
		     // Outputs
		     .data_out		(data_out_estr[5:0]),
		     .valid_out		(valid_out_estr),
		     // Inputs
		     .clk		(clk),
		     .data_in0		(data_in0_estr[5:0]),
		     .data_in1		(data_in1_estr[5:0]),
		     .reset_L		(reset_L),
		     .selector		(selector),
		     .valid_in0		(valid_in0_estr),
		     .valid_in1		(valid_in1_estr));

    probador prb (/*AUTOINST*/
		  // Outputs
		  .data_in0		(data_in0[5:0]),
		  .data_in1		(data_in1[5:0]),
		  .valid_in0		(valid_in0),
		  .valid_in1		(valid_in1),
		  .selector		(selector),
		  .reset_L		(reset_L),
		  .clk			(clk),
		  .data_in0_estr	(data_in0_estr[5:0]),
		  .data_in1_estr	(data_in1_estr[5:0]),
		  .valid_in0_estr	(valid_in0_estr),
		  .valid_in1_estr	(valid_in1_estr));

endmodule
