//`include "fifo.v"
module VC0 #(
parameter		BW16=6,	// Byte/data width
parameter [5:0]	LEN=16,
parameter TOL = 1)
    (
	input				clk, reset_L,
	input				valid_in_vc0,
	input	 [(BW16-1):0]	data_in_vc0,
	input				VC0_rd,
	output	[(BW16-1):0]	VC0_data_out,
	output  			VC0_error_output,
	output   				VC0_full,
	output   				VC0_empty,
	output   				VC0_almost_full,
	output   				VC0_almost_empty);

fifo16 #(.BW(BW16), .LEN(LEN), .TOL(TOL)) VC0  (
	 // Outputs
	 .fifo_data_out			(VC0_data_out[(BW16-1):0]),
	 .error_output			(VC0_error_output),
	 .fifo_full			(VC0_full),
	 .fifo_empty			(VC0_empty),
	 .fifo_almost_full		(VC0_almost_full),
	 .fifo_almost_empty		(VC0_almost_empty),
	 // Inputs
	 .clk				(clk),
	 .reset_L			(reset_L),
	 .fifo_wr			(valid_in_vc0),
	 .fifo_data_in			(data_in_vc0[(BW16-1):0]),
	 .fifo_rd			(VC0_rd)) ;

endmodule
