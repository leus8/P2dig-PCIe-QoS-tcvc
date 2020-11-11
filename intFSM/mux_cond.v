module mux_cond (  
    input clk,
    input reset_L,
    input vc0_delay, // selector
    input [5:0] VC0_data_out,
    input VC0_rd, // valid_VC0
    input [5:0] VC1_data_out,
    input VC1_rd, // valid_VC1
    output reg demux_dest_valid_in,
    output reg[5:0] demux_dest_data_in
    );

    reg[5:0] data_out_recordar;
    reg valid_in_recordar;

    always @(*) begin
        if (vc0_delay == 1) begin
            valid_in_recordar = VC1_rd;
            data_out_recordar = VC1_data_out;
        end else begin
            valid_in_recordar = VC0_rd;
            data_out_recordar = VC0_data_out;
        end
    end

    always @(posedge clk) begin
        if (reset_L == 1) begin
            demux_dest_valid_in <= valid_in_recordar; // &

            if(valid_in_recordar == 1) begin
                demux_dest_data_in <= data_out_recordar; // -    
            end

        end else begin
            demux_dest_data_in <= 0; // -
            demux_dest_valid_in <= 0; // &
        end
    end
endmodule
