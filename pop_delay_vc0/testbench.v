`timescale 1ns/100ps

`include "probador.v"

`include "cmos_cells.v"

`include "pop_delay_vc0.v"
`include "pop_delay_vc0_estr.v"

module testbench;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		clk;			// From prb of probador.v
    wire		d0_full;		// From prb of probador.v
    wire		d0_full_estr;		// From prb of probador.v
    wire		d1_full;		// From prb of probador.v
    wire		d1_full_estr;		// From prb of probador.v
    wire		reset_L;		// From prb of probador.v
    wire		vc0_delay;		// From pop_vc0 of pop_delay_vc0.v
    wire		vc0_empty;		// From prb of probador.v
    wire		vc0_empty_estr;		// From prb of probador.v
    wire		vc0_read;		// From pop_vc0 of pop_delay_vc0.v
    wire		vc1_empty;		// From prb of probador.v
    wire		vc1_empty_estr;		// From prb of probador.v
    wire		vc1_read;		// From pop_vc0 of pop_delay_vc0.v
    // End of automatics

    // Estructurales
    wire vc0_delay_estr;
    wire vc0_read_estr;
    wire vc1_read_estr;

    pop_delay_vc0 pop_vc0 (/*AUTOINST*/
			   // Outputs
			   .vc0_delay		(vc0_delay),
			   .vc0_read		(vc0_read),
			   .vc1_read		(vc1_read),
			   // Inputs
			   .clk			(clk),
			   .reset_L		(reset_L),
			   .d0_full		(d0_full),
			   .d1_full		(d1_full),
			   .vc0_empty		(vc0_empty),
			   .vc1_empty		(vc1_empty));

    pop_delay_vc0_estr pop_vc0_estr (
				     // Outputs
				     .vc0_delay		(vc0_delay_estr),
				     .vc0_read		(vc0_read_estr),
				     .vc1_read		(vc1_read_estr),
				     // Inputs
				     .clk		(clk),
				     .d0_full		(d0_full_estr),
				     .d1_full		(d1_full_estr),
				     .reset_L		(reset_L),
				     .vc0_empty		(vc0_empty_estr),
				     .vc1_empty		(vc1_empty_estr));


    probador prb (/*AUTOINST*/
		  // Outputs
		  .clk			(clk),
		  .reset_L		(reset_L),
		  .d0_full		(d0_full),
		  .d1_full		(d1_full),
		  .vc0_empty		(vc0_empty),
		  .vc1_empty		(vc1_empty),
		  .d0_full_estr		(d0_full_estr),
		  .d1_full_estr		(d1_full_estr),
		  .vc0_empty_estr	(vc0_empty_estr),
		  .vc1_empty_estr	(vc1_empty_estr));

endmodule
