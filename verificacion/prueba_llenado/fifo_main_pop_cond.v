module fifo_main_pop_cond (
    input clk,
    input VC0_almost_full,
    input reset_L,
    input VC1_almost_full,
    input Main_empty,
    input [5:0] Main_data_out,
    output reg [5:0] demux_vcid_in,
    output reg demux_vcid_valid_in,
    output reg Main_rd
);

    reg [5:0] data_out_recordar;
    reg demux_vcid_valid_in_recordar;
    reg Main_rd_recordar;

    always @(*) begin
        if ( (!(VC0_almost_full || VC1_almost_full)) && !(Main_empty)) begin
            data_out_recordar = Main_data_out;
            demux_vcid_valid_in_recordar = 1; 
            Main_rd_recordar = 1;
        end else begin
            data_out_recordar = 0;
            demux_vcid_valid_in_recordar = 0; 
            Main_rd_recordar = 0;
        end
    end


    always @(posedge clk) begin
        if (reset_L == 1) begin
                demux_vcid_in <= data_out_recordar; 
                demux_vcid_valid_in <= demux_vcid_valid_in_recordar;
                Main_rd <= Main_rd_recordar;
            end
        else begin
            demux_vcid_in <= 0; 
            demux_vcid_valid_in <= 0;
            Main_rd <= 0;
        end
    end


/*
    always @(*) begin
        if (!(VC0_almost_full || VC1_almost_full) && !(Main_empty)) begin
            data_out_recordar = Main_data_out;
            demux_vcid_valid_in_recordar = 1; 
            Main_rd_recordar = 1;
        end else begin
            data_out_recordar = 0;
            demux_vcid_valid_in_recordar = 0; 
            Main_rd_recordar = 0;
        end
    end

    always @(posedge clk) begin
        if (reset_L == 1) begin
            if(!(VC0_almost_full || VC1_almost_full) && !(Main_empty)) begin
                demux_vcid_in <= data_out_recordar;
                demux_vcid_valid_in <= demux_vcid_valid_in_recordar;
                Main_rd <= Main_rd_recordar;
            end else begin
                demux_vcid_in <= 0; 
                demux_vcid_valid_in <= 0;
                Main_rd <= 0;
            end
        end else begin
            demux_vcid_in <= 0;
            demux_vcid_valid_in <= 0;
            Main_rd <= 0;
        end
    end
*/

endmodule