`timescale 1ns/100ps

`include "probador.v"

`include "fifo_main_pop.v"

module testbench;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		clk;			// From prb of probador.v
    wire [5:0]		data_in;		// From prb of probador.v
    wire [5:0]		data_out;		// From pop of fifo_main_pop.v
    wire		fifo_main_empty;	// From prb of probador.v
    wire		fifo_rd;		// From pop of fifo_main_pop.v
    wire		reset_L;		// From prb of probador.v
    wire		valid_in;		// From pop of fifo_main_pop.v
    wire		vc0_full;		// From prb of probador.v
    wire		vc1_full;		// From prb of probador.v
    // End of automatics

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

    probador prb (/*AUTOINST*/
		  // Outputs
		  .clk			(clk),
		  .data_in		(data_in[5:0]),
		  .reset_L		(reset_L),
		  .vc0_full		(vc0_full),
		  .vc1_full		(vc1_full),
		  .fifo_main_empty	(fifo_main_empty));


endmodule
