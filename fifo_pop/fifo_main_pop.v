module fifo_main_pop (
    input clk,
    input vc0_full,
    input reset_L,
    input vc1_full,
    input fifo_main_empty,
    input [5:0] data_in,
    output reg [5:0] data_out,
    output reg valid_in,
    output reg fifo_rd
);

    reg [5:0] data_out_recordar;
    reg valid_in_recordar;
    reg fifo_rd_recordar;

    always @(*) begin
        if (!(vc0_full || vc1_full) && !(fifo_main_empty)) begin
            data_out_recordar = data_in;
            valid_in_recordar = 1; 
            fifo_rd_recordar = 1;
        end else begin
            data_out_recordar = 0;
            valid_in_recordar = 0; 
            fifo_rd_recordar = 0;
        end
    end

    always @(posedge clk) begin
        if (reset_L == 1) begin
            if(!(vc0_full || vc1_full) && !(fifo_main_empty)) begin
                data_out <= data_out_recordar;
                valid_in <= valid_in_recordar;
                fifo_rd <= fifo_rd_recordar;
            end else begin
                data_out <= 0;
                valid_in <= 0;
                fifo_rd <= 0;
            end
        end else begin
            data_out <= 0;
            valid_in <= 0;
            fifo_rd <= 0;
        end
    end

endmodule