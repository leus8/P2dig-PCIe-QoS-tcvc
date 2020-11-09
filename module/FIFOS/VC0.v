`include "fifo.v"
module VC0 #(
parameter		BW16=16,	// Byte/data width
parameter [3:0]	LEN=6,
parameter TOL = 1)
    (
	input				clk, reset_L,
	input				VC0_wr,
	input	 [(BW16-1):0]	VC0_data_in,
	input				VC0_rd,
	output	[(BW16-1):0]	VC0_data_out,
	output  			error_output,
	output   				VC0_full,
	output   				VC0_empty,
	output   				VC0_almost_full,
	output   				VC0_almost_empty);

fifo #(.BW(BW16), .LEN(LEN), .TOL(TOL)) VC0  (
	 // Outputs
	 .fifo_data_out			(VC0_data_out[(BW16-1):0]),
	 .error_output			(error_output),
	 .fifo_full			(VC0_full),
	 .fifo_empty			(VC0_empty),
	 .fifo_almost_full		(VC0_almost_full),
	 .fifo_almost_empty		(VC0_almost_empty),
	 // Inputs
	 .clk				(clk),
	 .reset_L			(reset_L),
	 .fifo_wr			(VC0_wr),
	 .fifo_data_in			(VC0_data_in[(BW16-1):0]),
	 .fifo_rd			(VC0_rd)) ;

endmodule
