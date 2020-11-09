`include "fifo.v"
module D1 #(
parameter		BW4=4,	// Byte/data width
parameter [3:0]	LEN=6,
parameter TOL = 1)
    (
	input				clk, reset_L,
	input				D1_wr,
	input	 [(BW4-1):0]	D1_data_in,
	input				D1_rd,
	output	[(BW4-1):0]	D1_data_out,
	output  			error_output,
	output   				D1_full,
	output   				D1_empty,
	output   				D1_almost_full,
	output   				D1_almost_empty);

fifo #(.BW(BW4), .LEN(LEN), .TOL(TOL)) D1  (
	 // Outputs
	 .fifo_data_out			(D1_data_out[(BW4-1):0]),
	 .error_output			(error_output),
	 .fifo_full			(D1_full),
	 .fifo_empty			(D1_empty),
	 .fifo_almost_full		(D1_almost_full),
	 .fifo_almost_empty		(D1_almost_empty),
	 // Inputs
	 .clk				(clk),
	 .reset_L			(reset_L),
	 .fifo_wr			(D1_wr),
	 .fifo_data_in			(D1_data_in[(BW4-1):0]),
	 .fifo_rd			(D1_rd)) ;

endmodule
