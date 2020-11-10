module pop_delay_vc0(
    input clk,
    input reset_L,
    input D0_full,
    input D1_full,
    input VC0_empty,
    input VC1_empty,
    output reg vc0_delay,
    output reg VC0_rd,
    output reg VC1_rd
);

    reg and_d0d1;
    reg and_vc0_0;
    reg and_vc0_1;
    reg vc0_delay_recordar;
    reg VC0_rd_recordar;
    reg VC1_rd_recordar;
    reg vc0_delay_clk; // para retardar 1 ciclo el selector
    
    // and de d0 y d1
    always @(*) begin
        if (D0_full && D1_full) begin
            and_d0d1 = 1;
        end else begin
            and_d0d1 = 0;
        end
    end

    // and final 0
    always @(*) begin
        if (!(VC0_empty) && !(and_d0d1)) begin
            and_vc0_0 = 1;
        end else begin
            and_vc0_0 = 0;
        end
    end

    // and final 1
    always @(*) begin
        if (VC0_empty && !(and_d0d1) && !(VC1_empty)) begin
            and_vc0_1 = 1;
        end else begin
            and_vc0_1 = 0;
        end
    end

    // pop delay
    always @(*) begin
        if (and_vc0_0 == 1) begin
            vc0_delay = 0;
            VC0_rd = 1;
            VC1_rd = 0;
        end 
        else if (and_vc0_1 && !(and_vc0_0)) begin
            vc0_delay = 1;
            VC0_rd = 0;
            VC1_rd = 1;
        end else begin
            vc0_delay = 0;
            VC0_rd = 0;
            VC1_rd = 0;
        end
    end


    
/*
    // cambiar VC0/VC1_rd a reg

    // pop delay
    always @(*) begin
        if (and_vc0_0 == 1) begin
            vc0_delay_recordar = 0;
            VC0_rd_recordar = 1;
            VC1_rd_recordar = 0;
        end 
        else if (and_vc0_1 && !(and_vc0_0)) begin
            vc0_delay_recordar = 1;
            VC0_rd_recordar = 0;
            VC1_rd_recordar = 1;
        end else begin
            vc0_delay_recordar = 0;
            VC0_rd_recordar = 0;
            VC1_rd_recordar = 0;
        end
    end

    // pop delay flop
    always @(posedge clk) begin
        if (reset_L == 1) begin
            if (and_vc0_0 == 1) begin
                vc0_delay <= vc0_delay_recordar;
                VC0_rd <= VC0_rd_recordar;
                VC1_rd <= VC1_rd_recordar;
            end 
            else if (and_vc0_1 && !(and_vc0_0)) begin
                vc0_delay <= vc0_delay_recordar;
                VC0_rd <= VC0_rd_recordar;
                VC1_rd <= VC1_rd_recordar;
            end else begin
                vc0_delay <= 0;
                VC0_rd <= 0;
                VC1_rd <= 0;
            end
        end else begin
            vc0_delay <= 0;
            VC0_rd <= 0;
            VC1_rd <= 0;
        end
    end
*/


endmodule