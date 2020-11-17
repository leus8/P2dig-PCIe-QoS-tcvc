//`include "fifo.v"
module Main_cond #(
parameter		BW=6,	// Byte/data width
parameter [5:0]	LEN4=4,
parameter TOL = 1)
    (
	input				clk, reset_L,
	input				Main_wr,
	input	 [(BW-1):0]	Main_data_in,
	input				Main_rd,
	input 	[(LEN4-1):0]	UmbralMF_LOW,
	input 	[(LEN4-1):0] UmbralMF_HIGH,
	output	[(BW-1):0]	Main_data_out,
	output  			Main_error_output,
	output   				Main_full,
	output   				Main_empty,
	output   				Main_almost_full,
	output   				Main_almost_empty);

fifo_cond #(.BW(BW), .LEN(LEN4), .TOL(TOL)) Main  (
	 // Outputs
	 .fifo_data_out			(Main_data_out[(BW-1):0]),
	 .error_output			(Main_error_output),
	 .fifo_full			(Main_full),
	 .fifo_empty			(Main_empty),
	 .fifo_almost_full		(Main_almost_full),
	 .fifo_almost_empty		(Main_almost_empty),
	 // Inputs
	 .clk				(clk),
	 .reset_L			(reset_L),
	 .fifo_wr			(Main_wr),
	 .umbral_bajo		(UmbralMF_LOW[(LEN4-1):0]),
	 .umbral_alto		(UmbralMF_HIGH[(LEN4-1):0]),
	 .fifo_data_in		(Main_data_in[(BW-1):0]),
	 .fifo_rd			(Main_rd)) ;

endmodule
