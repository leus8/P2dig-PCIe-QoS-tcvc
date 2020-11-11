`include "Main.v"
`include "VC0.v"
`include "VC1.v"
`include "D0.v"
`include "D1.v"
`include "fifo_main_pop.v"
`include "pop_delay_vc0.v"
`include "demux_dest.v"
`include "demux_vc_id.v"
`include "mux.v"
`include "fifo.v"
`include "fifo16.v"

module interconnect (

    // basic I-O (probador)
    input clk,
    input reset_L,
    input Main_wr,
    input [(BW-1):0] Main_data_in,
    input D0_rd,
    input D1_rd,
    output [(BW-1):0] D0_data_out,
    output [(BW-1):0] D1_data_out,

    // FIFO: main
    output Main_error_output,
    output Main_empty,
	output Main_full,

    // FIFO: VC0
    output VC0_error_output,
    output VC0_empty,

    // FIFO: VC1
    output VC1_error_output,
    output VC1_empty,

    // FIFO: D0
    output D0_error_output,
    output D0_empty,

    // FIFO: D1
    output D1_error_output,
    output D1_empty
);

	// PARAMS
    parameter BW=6;
    parameter BW4 = 6;
    parameter BW16 = 6;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		D0_almost_empty;	// From f_d0 of D0.v
    wire		D0_almost_full;		// From f_d0 of D0.v
    wire [BW-1:0]	D0_data_in;		// From d_dest of demux_dest.v
    wire		D0_full;		// From f_d0 of D0.v
    wire		D0_wr;			// From d_dest of demux_dest.v
    wire		D1_almost_empty;	// From f_d1 of D1.v
    wire		D1_almost_full;		// From f_d1 of D1.v
    wire [BW-1:0]	D1_data_in;		// From d_dest of demux_dest.v
    wire		D1_full;		// From f_d1 of D1.v
    wire		D1_wr;			// From d_dest of demux_dest.v
    wire		Main_almost_empty;	// From f_main of Main.v
    wire		Main_almost_full;	// From f_main of Main.v
    wire [(BW4-1):0]	Main_data_out;		// From f_main of Main.v
    wire		Main_rd;		// From pop_main of fifo_main_pop.v
    wire		VC0_almost_empty;	// From f_vc0 of VC0.v
    wire		VC0_almost_full;	// From f_vc0 of VC0.v
    wire [(BW16-1):0]	VC0_data_out;		// From f_vc0 of VC0.v
    wire		VC0_full;		// From f_vc0 of VC0.v
    wire		VC0_rd;			// From pop_vc0 of pop_delay_vc0.v
    wire		VC1_almost_empty;	// From f_vc1 of VC1.v
    wire		VC1_almost_full;	// From f_vc1 of VC1.v
    wire [(BW16-1):0]	VC1_data_out;		// From f_vc1 of VC1.v
    wire		VC1_full;		// From f_vc1 of VC1.v
    wire		VC1_rd;			// From pop_vc0 of pop_delay_vc0.v
    wire [BW-1:0]	data_in_vc0;		// From d_vcid of demux_vc_id.v
    wire [BW-1:0]	data_in_vc1;		// From d_vcid of demux_vc_id.v
    wire [5:0]		demux_dest_data_in;	// From mux1 of mux.v
    wire		demux_dest_valid_in;	// From mux1 of mux.v
    wire [5:0]		demux_vcid_in;		// From pop_main of fifo_main_pop.v
    wire		demux_vcid_valid_in;	// From pop_main of fifo_main_pop.v
    wire		valid_in_vc0;		// From d_vcid of demux_vc_id.v
    wire		valid_in_vc1;		// From d_vcid of demux_vc_id.v
    wire		vc0_delay;		// From pop_vc0 of pop_delay_vc0.v
    // End of automatics


    Main f_main(/*AUTOINST*/
		// Outputs
		.Main_data_out		(Main_data_out[(BW4-1):0]),
		.Main_error_output	(Main_error_output),
		.Main_full		(Main_full),
		.Main_empty		(Main_empty),
		.Main_almost_full	(Main_almost_full),
		.Main_almost_empty	(Main_almost_empty),
		// Inputs
		.clk			(clk),
		.reset_L		(reset_L),
		.Main_wr		(Main_wr),
		.Main_data_in		(Main_data_in[(BW4-1):0]),
		.Main_rd		(Main_rd));

    fifo_main_pop pop_main(/*AUTOINST*/
			   // Outputs
			   .demux_vcid_in	(demux_vcid_in[5:0]),
			   .demux_vcid_valid_in	(demux_vcid_valid_in),
			   .Main_rd		(Main_rd),
			   // Inputs
			   .clk			(clk),
			   .VC0_almost_full	(VC0_almost_full),
			   .reset_L		(reset_L),
			   .VC1_almost_full	(VC1_almost_full),
			   .Main_empty		(Main_empty),
			   .Main_data_out	(Main_data_out[5:0]));

    demux_vc_id d_vcid(/*AUTOINST*/
		       // Outputs
		       .data_in_vc0	(data_in_vc0[BW-1:0]),
		       .valid_in_vc0	(valid_in_vc0),
		       .data_in_vc1	(data_in_vc1[BW-1:0]),
		       .valid_in_vc1	(valid_in_vc1),
		       // Inputs
		       .clk		(clk),
		       .reset_L		(reset_L),
		       .demux_vcid_valid_in(demux_vcid_valid_in),
		       .demux_vcid_in	(demux_vcid_in[BW-1:0]));

    VC0 f_vc0(/*AUTOINST*/
	      // Outputs
	      .VC0_data_out		(VC0_data_out[(BW16-1):0]),
	      .VC0_error_output		(VC0_error_output),
	      .VC0_full			(VC0_full),
	      .VC0_empty		(VC0_empty),
	      .VC0_almost_full		(VC0_almost_full),
	      .VC0_almost_empty		(VC0_almost_empty),
	      // Inputs
	      .clk			(clk),
	      .reset_L			(reset_L),
	      .valid_in_vc0		(valid_in_vc0),
	      .data_in_vc0		(data_in_vc0[(BW16-1):0]),
	      .VC0_rd			(VC0_rd));

    VC1 f_vc1(/*AUTOINST*/
	      // Outputs
	      .VC1_data_out		(VC1_data_out[(BW16-1):0]),
	      .VC1_error_output		(VC1_error_output),
	      .VC1_full			(VC1_full),
	      .VC1_empty		(VC1_empty),
	      .VC1_almost_full		(VC1_almost_full),
	      .VC1_almost_empty		(VC1_almost_empty),
	      // Inputs
	      .clk			(clk),
	      .reset_L			(reset_L),
	      .valid_in_vc1		(valid_in_vc1),
	      .data_in_vc1		(data_in_vc1[(BW16-1):0]),
	      .VC1_rd			(VC1_rd));

    pop_delay_vc0 pop_vc0(/*AUTOINST*/
			  // Outputs
			  .vc0_delay		(vc0_delay),
			  .VC0_rd		(VC0_rd),
			  .VC1_rd		(VC1_rd),
			  // Inputs
			  .clk			(clk),
			  .reset_L		(reset_L),
			  .D0_full		(D0_full),
			  .D1_full		(D1_full),
			  .VC0_empty		(VC0_empty),
			  .VC1_empty		(VC1_empty));

    mux mux1(/*AUTOINST*/
	     // Outputs
	     .demux_dest_valid_in	(demux_dest_valid_in),
	     .demux_dest_data_in	(demux_dest_data_in[5:0]),
	     // Inputs
	     .clk			(clk),
	     .reset_L			(reset_L),
	     .vc0_delay			(vc0_delay),
	     .VC0_data_out		(VC0_data_out[5:0]),
	     .VC0_rd			(VC0_rd),
	     .VC1_data_out		(VC1_data_out[5:0]),
	     .VC1_rd			(VC1_rd));

	demux_dest d_dest(/*AUTOINST*/
			  // Outputs
			  .D0_data_in		(D0_data_in[BW-1:0]),
			  .D0_wr		(D0_wr),
			  .D1_data_in		(D1_data_in[BW-1:0]),
			  .D1_wr		(D1_wr),
			  // Inputs
			  .clk			(clk),
			  .reset_L		(reset_L),
			  .demux_dest_valid_in	(demux_dest_valid_in),
			  .demux_dest_data_in	(demux_dest_data_in[BW-1:0]));

    D0 f_d0(/*AUTOINST*/
	    // Outputs
	    .D0_data_out		(D0_data_out[(BW4-1):0]),
	    .D0_error_output		(D0_error_output),
	    .D0_full			(D0_full),
	    .D0_empty			(D0_empty),
	    .D0_almost_full		(D0_almost_full),
	    .D0_almost_empty		(D0_almost_empty),
	    // Inputs
	    .clk			(clk),
	    .reset_L			(reset_L),
	    .D0_wr			(D0_wr),
	    .D0_data_in			(D0_data_in[(BW4-1):0]),
	    .D0_rd			(D0_rd));

    D1 f_d1(/*AUTOINST*/
	    // Outputs
	    .D1_data_out		(D1_data_out[(BW4-1):0]),
	    .D1_error_output		(D1_error_output),
	    .D1_full			(D1_full),
	    .D1_empty			(D1_empty),
	    .D1_almost_full		(D1_almost_full),
	    .D1_almost_empty		(D1_almost_empty),
	    // Inputs
	    .clk			(clk),
	    .reset_L			(reset_L),
	    .D1_wr			(D1_wr),
	    .D1_data_in			(D1_data_in[(BW4-1):0]),
	    .D1_rd			(D1_rd));

    

    

endmodule
