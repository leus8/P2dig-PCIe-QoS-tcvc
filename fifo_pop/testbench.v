`timescale 1ns/100ps

`include "probador.v"

`include "cmos_cells.v"

`include "fifo_main_pop.v"
`include "fifo_main_pop_estr.v"

module testbench;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		clk;			// From prb of probador.v
    wire [5:0]		data_in;		// From prb of probador.v
    wire [5:0]		data_in_estr;		// From prb of probador.v
    wire [5:0]		data_out;		// From pop of fifo_main_pop.v
    wire		fifo_main_empty;	// From prb of probador.v
    wire		fifo_main_empty_estr;	// From prb of probador.v
    wire		fifo_rd;		// From pop of fifo_main_pop.v
    wire		reset_L;		// From prb of probador.v
    wire		valid_in;		// From pop of fifo_main_pop.v
    wire		vc0_full;		// From prb of probador.v
    wire		vc0_full_estr;		// From prb of probador.v
    wire		vc1_full;		// From prb of probador.v
    wire		vc1_full_estr;		// From prb of probador.v
    // End of automatics

    // Estructurales
    wire [5:0] data_out_estr;
    wire fifo_rd_estr;
    wire valid_in_estr;

    fifo_main_pop pop (/*AUTOINST*/
		       // Outputs
		       .data_out	(data_out[5:0]),
		       .valid_in	(valid_in),
		       .fifo_rd		(fifo_rd),
		       // Inputs
		       .clk		(clk),
		       .vc0_full	(vc0_full),
		       .reset_L		(reset_L),
		       .vc1_full	(vc1_full),
		       .fifo_main_empty	(fifo_main_empty),
		       .data_in		(data_in[5:0]));

    fifo_main_pop_estr pop_estr (
				 // Outputs
				 .data_out		(data_out_estr[5:0]),
				 .fifo_rd		(fifo_rd_estr),
				 .valid_in		(valid_in_estr),
				 // Inputs
				 .clk			(clk),
				 .data_in		(data_in_estr[5:0]),
				 .fifo_main_empty	(fifo_main_empty_estr),
				 .reset_L		(reset_L),
				 .vc0_full		(vc0_full_estr),
				 .vc1_full		(vc1_full_estr));

    probador prb (/*AUTOINST*/
		  // Outputs
		  .clk			(clk),
		  .data_in		(data_in[5:0]),
		  .reset_L		(reset_L),
		  .vc0_full		(vc0_full),
		  .vc1_full		(vc1_full),
		  .fifo_main_empty	(fifo_main_empty),
		  .data_in_estr		(data_in_estr[5:0]),
		  .vc0_full_estr	(vc0_full_estr),
		  .vc1_full_estr	(vc1_full_estr),
		  .fifo_main_empty_estr	(fifo_main_empty_estr));


endmodule
