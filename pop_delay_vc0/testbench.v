`timescale 1ns/100ps

`include "probador.v"

`include "pop_delay_vc0.v"

module testbench;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		clk;			// From prb of probador.v
    wire		d0_full;		// From prb of probador.v
    wire		d1_full;		// From prb of probador.v
    wire		reset_L;		// From prb of probador.v
    wire		vc0_delay;		// From pop_vc0 of pop_delay_vc0.v
    wire		vc0_empty;		// From prb of probador.v
    wire		vc0_read;		// From pop_vc0 of pop_delay_vc0.v
    wire		vc1_empty;		// From prb of probador.v
    wire		vc1_read;		// From pop_vc0 of pop_delay_vc0.v
    // End of automatics

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


    probador prb (/*AUTOINST*/
		  // Outputs
		  .clk			(clk),
		  .reset_L		(reset_L),
		  .d0_full		(d0_full),
		  .d1_full		(d1_full),
		  .vc0_empty		(vc0_empty),
		  .vc1_empty		(vc1_empty));

endmodule
