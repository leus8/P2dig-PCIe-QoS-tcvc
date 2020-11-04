module mux (  
    input clk,
    input reset_L,
    input selector,
    input [5:0] data_in0,
    input valid_in0,
    input [5:0] data_in1,
    input valid_in1,
    output reg valid_out,
    output reg[5:0] data_out
    );

    reg[5:0] data_out_recordar;
    reg valid_in_recordar;

    always @(*) begin
        if (selector == 1) begin
            valid_in_recordar = valid_in1;
            data_out_recordar = data_in1;
        end else begin
            valid_in_recordar = valid_in0;
            data_out_recordar = data_in0;
        end
    end

    always @(posedge clk) begin
        if (reset_L == 1) begin
            valid_out <= valid_in_recordar;

            if(valid_in_recordar == 1) begin
                data_out <= data_out_recordar;     
            end

        end else begin
            data_out <= 0;
            valid_out <= 0;
        end
    end
endmodule
