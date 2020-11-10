//`include "fifo.v"
module D0 #(
parameter		BW4=6,	// Byte/data width
parameter [5:0]	LEN=4,
parameter TOL = 1)
    (
	input				clk, reset_L,
	input				D0_wr,
	input	 [(BW4-1):0]	D0_data_in,
	input				D0_rd,
	output	[(BW4-1):0]	D0_data_out,
	output  			D0_error_output,
	output   				D0_full,
	output   				D0_empty,
	output   				D0_almost_full,
	output   				D0_almost_empty);

fifo #(.BW(BW4), .LEN(LEN), .TOL(TOL)) D0  (
	 // Outputs
	 .fifo_data_out			(D0_data_out[(BW4-1):0]),
	 .error_output			(D0_error_output),
	 .fifo_full			(D0_full),
	 .fifo_empty			(D0_empty),
	 .fifo_almost_full		(D0_almost_full),
	 .fifo_almost_empty		(D0_almost_empty),
	 // Inputs
	 .clk				(clk),
	 .reset_L			(reset_L),
	 .fifo_wr			(D0_wr),
	 .fifo_data_in			(D0_data_in[(BW4-1):0]),
	 .fifo_rd			(D0_rd)) ;

endmodule
