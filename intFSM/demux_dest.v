module demux_dest #(  
        parameter BW = 6
    )

    (   input clk,
        input reset_L,
        output reg [BW-1:0] D0_data_in,
        output reg D0_wr,
        output reg[BW-1:0] D1_data_in,
        output reg D1_wr,
        input demux_dest_valid_in,
        input [BW-1:0] demux_dest_data_in
    );

                        
    reg [BW-1:0] data_recordar0;
    reg [BW-1:0] data_recordar1;
    reg valid_recordar0;
    reg valid_recordar1;

    wire selector;
    assign selector = demux_dest_data_in[4]; // selector es el bit de dest

    always @(*) begin   
        if (selector == 0 && demux_dest_valid_in == 1) begin
            data_recordar0 = demux_dest_data_in;
            data_recordar1 = 0;
            valid_recordar0 = demux_dest_valid_in;
            valid_recordar1 = 0;


        end else if (selector == 1 && demux_dest_valid_in == 1) begin
            data_recordar0 = 0;
            data_recordar1 = demux_dest_data_in;
            valid_recordar0 = 0;
            valid_recordar1 = demux_dest_valid_in;

        end else begin
            data_recordar0 = 0;
            data_recordar1 = 0;
            valid_recordar0 = 0;
            valid_recordar1 = 0;
        end
    end

    always @(posedge clk) begin
        if (reset_L == 1) begin
            if (selector == 0) begin
                D0_data_in <= data_recordar0;
                D0_wr <= valid_recordar0;
                D1_wr <= 0;
            end else if (selector == 1) begin
                D1_data_in <= data_recordar1;
                D1_wr <= valid_recordar1;
                D0_wr <= 0;
            end
        end else begin
            D0_data_in <= 0;
            D1_data_in <= 0;
            D0_wr <= 0;
            D1_wr <= 0;
        end
    end

endmodule
