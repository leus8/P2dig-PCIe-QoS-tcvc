//`include "fifo.v"
module VC1 #(
parameter		BW=6,	// Byte/data width
parameter [5:0]	LEN16=16,
parameter TOL = 1)
    (
	input				clk, reset_L,
	input				valid_in_vc1,
	input	 [(BW-1):0]	data_in_vc1,
	input				VC1_rd,
	input [(LEN16-1):0] UmbralV1_LOW_cond,
	input [(LEN16-1):0] UmbralV1_HIGH_cond,
	output	[(BW-1):0]	VC1_data_out,
	output  			VC1_error_output,
	output   				VC1_full,
	output   				VC1_empty,
	output   				VC1_almost_full,
	output   				VC1_almost_empty);

fifo16 #(.BW(BW), .LEN(LEN16), .TOL(TOL)) VC1  (
	 // Outputs
	 .fifo_data_out			(VC1_data_out[(BW-1):0]),
	 .error_output			(VC1_error_output),
	 .fifo_full			(VC1_full),
	 .fifo_empty			(VC1_empty),
	 .fifo_almost_full		(VC1_almost_full),
	 .fifo_almost_empty		(VC1_almost_empty),
	 // Inputs
	 .clk				(clk),
	 .reset_L			(reset_L),
	 .fifo_wr			(valid_in_vc1),
	 .umbral_bajo		(UmbralV1_LOW_cond[(LEN16-1):0]),
	 .umbral_alto		(UmbralV1_HIGH_cond[(LEN16-1):0]),
	 .fifo_data_in			(data_in_vc1[(BW-1):0]),
	 .fifo_rd			(VC1_rd)) ;

endmodule
