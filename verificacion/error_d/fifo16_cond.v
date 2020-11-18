module fifo16_cond #(
parameter		BW=6,	// Byte/data width
parameter [15:0]	LEN=16,
parameter TOL = 1)

(
	
	input	wire					clk, reset_L,
	input	wire					fifo_wr,
	input	wire [(BW-1):0]			fifo_data_in,
	input	wire					fifo_rd,
	input 	wire [(LEN-1):0]		umbral_bajo,
	input 	wire [(LEN-1):0]		umbral_alto,
	output	reg [(BW-1):0]			fifo_data_out,
	output  reg 					error_output,
	output   						fifo_full,
	output   						fifo_empty,
	output   						fifo_almost_full,
	output   						fifo_almost_empty);

	reg	[(LEN-1):0] rdaddr, wraddr, o_fill;
	reg	[(BW-1):0]	mem	[0:(LEN-1)];
	reg overrun, underrun;
	wire full, empty;
	wire [(LEN-1):0] nxtaddr;


	always @(posedge clk)
		if (fifo_wr)
			mem[wraddr] <= fifo_data_in;


	always @(*) begin
		fifo_data_out = 0;
		if (fifo_rd) begin
			fifo_data_out = mem[rdaddr];
		end
	end



	always @(posedge clk)
		if (~reset_L)
		begin
			wraddr <= 0;
			overrun  <= 0;
		end else if (fifo_wr)
		begin
			// Update the FIFO write address any time a write is made to
			// the FIFO and it's not FULL.
			//
			// OR any time a write is made to the FIFO at the same time a
			// read is made from the FIFO.
			if ((!full)||(fifo_rd)) begin
				if (wraddr == LEN-1) begin
					wraddr <=0;
				end else begin
					wraddr <= (wraddr + 1'b1);
				end
				overrun <= 0;
			end
			else
				overrun <= 1'b1;
		end


	always @(posedge clk)
		if (~reset_L)
		begin
			rdaddr <= 0;
			underrun <= 0;
		end else if (fifo_rd)
		begin
			// On any read request, increment the pointer if the FIFO isn't
			// empty--independent of whether a write operation is taking
			// place at the same time.
			if (!empty) begin
				if (rdaddr == LEN-1)begin
					rdaddr <= 0;
				end else begin
					rdaddr <= rdaddr + 1'b1;
				end
				underrun <= 0;
			end
			else
				// If a read is requested, but the FIFO was empty, set
				// an underrun error flag.
				underrun <= 1'b1;
		end


	always @(posedge clk) begin
		if (~reset_L)
		begin
			o_fill <= 0;
		end else casez({ fifo_wr, fifo_rd, !full, !empty })
		4'b01?1: o_fill <= o_fill - 1'b1;	// A successful read
		4'b101?: o_fill <= o_fill + 1'b1;	// A successful write
		4'b1110: o_fill <= o_fill + 1'b1;	// Successful write, failed read
		// 4'b11?1: Successful read *and* write -- no change
		default: o_fill <= o_fill;	// Default, no change
		endcase
	end
	
	always @(*)begin
		error_output = underrun | overrun;
	end

	assign	nxtaddr = wraddr + 1'b1;
	assign	full  = (o_fill == LEN);
	assign	empty = (o_fill == 0);
	assign  fifo_full = full;
	assign  fifo_empty = empty;
	assign 	fifo_almost_empty = (o_fill <= umbral_bajo);
	assign 	almost_full = (o_fill >= umbral_alto);
	assign 	fifo_almost_full = almost_full;

	
endmodule