module pop_delay_vc0(
    input clk,
    input reset_L,
    input d0_full,
    input d1_full,
    input vc0_empty,
    input vc1_empty,
    output reg vc0_delay,
    output reg vc0_read,
    output reg vc1_read
);

    reg and_d0d1;
    reg and_vc0_0;
    reg and_vc0_1;
    reg vc0_delay_recordar;
    reg vc0_read_recordar;
    reg vc1_read_recordar;
    
    // and de d0 y d1
    always @(*) begin
        if (d0_full && d1_full) begin
            and_d0d1 = 1;
        end else begin
            and_d0d1 = 0;
        end
    end

    // and final 0
    always @(*) begin
        if (!(vc0_empty) && !(and_d0d1)) begin
            and_vc0_0 = 1;
        end else begin
            and_vc0_0 = 0;
        end
    end

    // and final 1
    always @(*) begin
        if (vc0_empty && !(and_d0d1) && !(vc1_empty)) begin
            and_vc0_1 = 1;
        end else begin
            and_vc0_1 = 0;
        end
    end

    // pop delay
    always @(*) begin
        if (and_vc0_0 == 1) begin
            vc0_delay_recordar = 0;
            vc0_read_recordar = 1;
            vc1_read_recordar = 0;
        end 
        else if (and_vc0_1 && !(and_vc0_0)) begin
            vc0_delay_recordar = 1;
            vc0_read_recordar = 0;
            vc1_read_recordar = 1;
        end else begin
            vc0_delay_recordar = 0;
            vc0_read_recordar = 0;
            vc1_read_recordar = 0;
        end
    end

    // pop delay flop
    always @(posedge clk) begin
        if (reset_L == 1) begin
            if (and_vc0_0 == 1) begin
                vc0_delay <= vc0_delay_recordar;
                vc0_read <= vc0_read_recordar;
                vc1_read <= vc1_read_recordar;
            end 
            else if (and_vc0_1 && !(and_vc0_0)) begin
                vc0_delay <= vc0_delay_recordar;
                vc0_read <= vc0_read_recordar;
                vc1_read <= vc1_read_recordar;
            end else begin
                vc0_delay <= 0;
                vc0_read <= 0;
                vc1_read <= 0;
            end
        end else begin
            vc0_delay <= 0;
            vc0_read <= 0;
            vc1_read <= 0;
        end
    end

endmodule