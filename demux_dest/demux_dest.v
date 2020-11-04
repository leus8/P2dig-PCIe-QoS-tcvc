module demux_dest #(  
        parameter BW = 6
    )

    (   input clk,
        input reset_L,
        output reg [BW-1:0] data_in_d0,
        output reg valid_in_d0,
        output reg[BW-1:0] data_in_d1,
        output reg valid_in_d1,
        input valid_in,
        input [BW-1:0] data_in
    );

                        
    reg [BW-1:0] data_recordar0;
    reg [BW-1:0] data_recordar1;
    reg valid_recordar0;
    reg valid_recordar1;

    wire selector;
    assign selector = data_in[4]; // selector es el bit de dest

    always @(*) begin   
        if (selector == 0 && valid_in == 1) begin
            data_recordar0 = data_in;
            data_recordar1 = 0;
            valid_recordar0 = valid_in;
            valid_recordar1 = 0;


        end else if (selector == 1 && valid_in == 1) begin
            data_recordar0 = 0;
            data_recordar1 = data_in;
            valid_recordar0 = 0;
            valid_recordar1 = valid_in;

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
                data_in_d0 <= data_recordar0;
                valid_in_d0 <= valid_recordar0;
                valid_in_d1 <= 0;
            end else if (selector == 1) begin
                data_in_d1 <= data_recordar1;
                valid_in_d1 <= valid_recordar1;
                valid_in_d0 <= 0;
            end
        end else begin
            data_in_d0 <= 0;
            data_in_d1 <= 0;
            valid_in_d0 <= 0;
            valid_in_d1 <= 0;
        end
    end

endmodule
