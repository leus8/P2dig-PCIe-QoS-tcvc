`timescale 1ns/100ps

`include "probador.v"

`include "cmos_cells.v"

`include "demux_dest.v"
`include "demux_dest_estr.v"

module testbench;

    //PARAMS
    parameter BW=6;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		clk;			// From prb of probador.v
    wire [5:0]		data_in;		// From prb of probador.v
    wire [BW-1:0]	data_in_d0;		// From d_dest of demux_dest.v
    wire [BW-1:0]	data_in_d1;		// From d_dest of demux_dest.v
    wire [5:0]		data_in_estr;		// From prb of probador.v
    wire		reset_L;		// From prb of probador.v
    wire		valid_in;		// From prb of probador.v
    wire		valid_in_d0;		// From d_dest of demux_dest.v
    wire		valid_in_d1;		// From d_dest of demux_dest.v
    wire		valid_in_estr;		// From prb of probador.v
    // End of automatics

    // Estructurales
    wire [BW-1:0]	data_in_d0_estr;
    wire [BW-1:0]	data_in_d1_estr;
    wire		    valid_in_d0_estr;
    wire		    valid_in_d1_estr;


    demux_dest d_dest (/*AUTOINST*/
		       // Outputs
		       .data_in_d0	(data_in_d0[BW-1:0]),
		       .valid_in_d0	(valid_in_d0),
		       .data_in_d1	(data_in_d1[BW-1:0]),
		       .valid_in_d1	(valid_in_d1),
		       // Inputs
		       .clk		(clk),
		       .reset_L		(reset_L),
		       .valid_in	(valid_in),
		       .data_in		(data_in[BW-1:0]));

    demux_dest_estr d_dest_estr (
				   // Outputs
				   .data_in_d0		(data_in_d0_estr[5:0]),
				   .data_in_d1		(data_in_d1_estr[5:0]),
				   .valid_in_d0	(valid_in_d0_estr),
				   .valid_in_d1	(valid_in_d1_estr),
				   // Inputs
				   .clk			(clk),
				   .data_in		(data_in_estr[5:0]),
				   .reset_L		(reset_L),
				   .valid_in		(valid_in_estr));

    probador prb (/*AUTOINST*/
		  // Outputs
		  .clk			(clk),
		  .data_in		(data_in[5:0]),
		  .reset_L		(reset_L),
		  .valid_in		(valid_in),
		  .data_in_estr		(data_in_estr[5:0]),
		  .valid_in_estr	(valid_in_estr));

endmodule
