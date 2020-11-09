`include "fifo.v"
module VC1 #(
parameter		BW16=16,	// Byte/data width
parameter [3:0]	LEN=6,
parameter TOL = 1)
    (
	input				clk, reset_L,
	input				VC1_wr,
	input	 [(BW16-1):0]	VC1_data_in,
	input				VC1_rd,
	output	[(BW16-1):0]	VC1_data_out,
	output  			error_output,
	output   				VC1_full,
	output   				VC1_empty,
	output   				VC1_almost_full,
	output   				VC1_almost_empty);

fifo #(.BW(BW16), .LEN(LEN), .TOL(TOL)) VC1  (
	 // Outputs
	 .fifo_data_out			(VC1_data_out[(BW16-1):0]),
	 .error_output			(error_output),
	 .fifo_full			(VC1_full),
	 .fifo_empty			(VC1_empty),
	 .fifo_almost_full		(VC1_almost_full),
	 .fifo_almost_empty		(VC1_almost_empty),
	 // Inputs
	 .clk				(clk),
	 .reset_L			(reset_L),
	 .fifo_wr			(VC1_wr),
	 .fifo_data_in			(VC1_data_in[(BW16-1):0]),
	 .fifo_rd			(VC1_rd)) ;

endmodule
