module probador (
	output reg reset_L,
    output reg clk,
    output reg VC0_wr,
    output reg VC0_rd,
    output reg [(BW-1):0] VC0_data_in,
    input [(BW-1):0] VC0_data_out,
    input [(BW-1):0] VC0_estr_data_out,
    input error_output,
    input error_estr_output,
    input VC0_full,
    input VC0_empty,
    input VC0_estr_full,
    input VC0_almost_full,
    input VC0_estr_empty,
    input VC0_estr_almost_full,
    input VC0_estr_almost_empty);
    parameter	BW=16;	// Byte/data width

initial begin
    $dumpfile("./dump/memory.vcd");
    $dumpvars;

    VC0_wr<=0;
    VC0_rd<=0;
    VC0_data_in<=6'h00;
    reset_L<=0;
    @(posedge clk);
    @(posedge clk);
    reset_L<=1;
    @(posedge clk);

    VC0_data_in<=6'h0A;
    @(posedge clk);
    VC0_data_in<=6'h0B;
    @(posedge clk);
    VC0_data_in<=6'h0C;
    @(posedge clk);
    VC0_data_in<=6'h0D;
    @(posedge clk);
    VC0_data_in<=6'h0E;
    @(posedge clk);
    VC0_data_in<=6'h0F;
    @(posedge clk);
    VC0_data_in<=6'h09;
    @(posedge clk);
    VC0_data_in<=6'h00;
    @(posedge clk);

    VC0_rd<=1;
    repeat (7) begin
    @(posedge clk);
    end
    VC0_rd <=0;
    repeat (6) begin
    @(posedge clk);
    end
    VC0_rd <=1;
    repeat (6) begin
    @(posedge clk);
    end


    $finish;
end

    always @ (*) begin
        if (reset_L && ~VC0_full && VC0_data_in) begin
            VC0_wr <= 1;
            @(posedge clk);
        end
        else begin
            VC0_wr <= 0;
            @(posedge clk);
        end
    end

initial clk <= 0; 
always #8 clk <= ~clk;

endmodule