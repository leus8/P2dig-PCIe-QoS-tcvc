`timescale 1ns / 100ps

`include "fifo.v"
//`include "fifo_estr.v"

//`include "cmos_cells.v"

`include "probador.v"


module testbench;

    //PARAMS
    parameter BW=4;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		clk;			// From prb of probador.v
    wire		error_output;		// From fifo_cond of fifo.v
    wire		fifo_almost_empty;	// From fifo_cond of fifo.v
    wire		fifo_almost_full;	// From fifo_cond of fifo.v
    wire [(BW-1):0]	fifo_data_in;		// From prb of probador.v
    wire [(BW-1):0]	fifo_data_out;		// From fifo_cond of fifo.v
    wire		fifo_empty;		// From fifo_cond of fifo.v
    wire		fifo_full;		// From fifo_cond of fifo.v
    wire		fifo_rd;		// From prb of probador.v
    wire		fifo_wr;		// From prb of probador.v
    wire		reset_L;		// From prb of probador.v
    // End of automatics

    fifo fifo_cond(/*AUTOINST*/
		   // Outputs
		   .fifo_data_out	(fifo_data_out[(BW-1):0]),
		   .error_output	(error_output),
		   .fifo_full		(fifo_full),
		   .fifo_empty		(fifo_empty),
		   .fifo_almost_full	(fifo_almost_full),
		   .fifo_almost_empty	(fifo_almost_empty),
		   // Inputs
		   .clk			(clk),
		   .reset_L		(reset_L),
		   .fifo_wr		(fifo_wr),
		   .fifo_data_in	(fifo_data_in[(BW-1):0]),
		   .fifo_rd		(fifo_rd));

    probador prb(/*AUTOINST*/
		 // Outputs
		 .reset_L		(reset_L),
		 .clk			(clk),
		 .fifo_wr		(fifo_wr),
		 .fifo_rd		(fifo_rd),
		 .fifo_data_in		(fifo_data_in[(BW-1):0]),
		 // Inputs
		 .fifo_data_out		(fifo_data_out[(BW-1):0]),
		 .error_output		(error_output),
		 .error_output_estr	(error_output_estr),
		 .fifo_full		(fifo_full),
		 .fifo_empty		(fifo_empty),
		 .fifo_full_estr	(fifo_full_estr),
		 .fifo_empty_estr	(fifo_empty_estr),
		 .fifo_almost_full	(fifo_almost_full),
		 .fifo_almost_empty	(fifo_almost_empty),
		 .fifo_almost_full_estr	(fifo_almost_full_estr),
		 .fifo_almost_empty_estr(fifo_almost_empty_estr));

endmodule
