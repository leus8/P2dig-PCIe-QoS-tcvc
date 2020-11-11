//`include "fifo.v"
module D1 #(
parameter		BW=6,	// Byte/data width
parameter [5:0]	LEN4=4,
parameter TOL = 1)
    (
	input				clk, reset_L,
	input				D1_wr,
	input	 [(BW-1):0]	D1_data_in,
	input				D1_rd,
	input [(LEN4-1):0] UmbralD1_LOW,
	input [(LEN4-1):0] UmbralD1_HIGH,
	output	[(BW-1):0]	D1_data_out,
	output  			D1_error_output,
	output   				D1_full,
	output   				D1_empty,
	output   				D1_almost_full,
	output   				D1_almost_empty);

fifo #(.BW(BW), .LEN(LEN4), .TOL(TOL)) D1  (
	 // Outputs
	 .fifo_data_out			(D1_data_out[(BW-1):0]),
	 .error_output			(D1_error_output),
	 .fifo_full			(D1_full),
	 .fifo_empty			(D1_empty),
	 .fifo_almost_full		(D1_almost_full),
	 .fifo_almost_empty		(D1_almost_empty),
	 // Inputs
	 .clk				(clk),
	 .reset_L			(reset_L),
	 .fifo_wr			(D1_wr),
	 .umbral_bajo		(UmbralD1_LOW[(LEN4-1):0]),
	 .umbral_alto		(UmbralD1_HIGH[(LEN4-1):0]),
	 .fifo_data_in			(D1_data_in[(BW-1):0]),
	 .fifo_rd			(D1_rd)) ;

endmodule
