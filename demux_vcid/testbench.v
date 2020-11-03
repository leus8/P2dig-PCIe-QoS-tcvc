`timescale 1ns/100ps

`include "probador.v"

`include "cmos_cells.v"

`include "demux_vc_id.v"
`include "demux_vc_id_estr.v"

module testbench;

    //PARAMS
    parameter BW=6;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		clk;			// From prb of probador.v
    wire [5:0]		data_in;		// From prb of probador.v
    wire [5:0]		data_in_estr;		// From prb of probador.v
    wire [BW-1:0]	data_in_vc0;		// From d_vc_id of demux_vc_id.v
    wire [BW-1:0]	data_in_vc1;		// From d_vc_id of demux_vc_id.v
    wire		reset_L;		// From prb of probador.v
    wire		valid_in;		// From prb of probador.v
    wire		valid_in_estr;		// From prb of probador.v
    wire		valid_in_vc0;		// From d_vc_id of demux_vc_id.v
    wire		valid_in_vc1;		// From d_vc_id of demux_vc_id.v
    // End of automatics

    // Estructurales
    wire [BW-1:0]	data_in_vc0_estr;
    wire [BW-1:0]	data_in_vc1_estr;
    wire		    valid_in_vc0_estr;
    wire		    valid_in_vc1_estr;


    demux_vc_id d_vc_id (/*AUTOINST*/
			 // Outputs
			 .data_in_vc0		(data_in_vc0[BW-1:0]),
			 .valid_in_vc0		(valid_in_vc0),
			 .data_in_vc1		(data_in_vc1[BW-1:0]),
			 .valid_in_vc1		(valid_in_vc1),
			 // Inputs
			 .clk			(clk),
			 .reset_L		(reset_L),
			 .valid_in		(valid_in),
			 .data_in		(data_in[BW-1:0]));

    demux_vc_id_estr d_vc_id_estr (
				   // Outputs
				   .data_in_vc0		(data_in_vc0_estr[5:0]),
				   .data_in_vc1		(data_in_vc1_estr[5:0]),
				   .valid_in_vc0	(valid_in_vc0_estr),
				   .valid_in_vc1	(valid_in_vc1_estr),
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
