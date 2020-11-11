module maquina_estados_cond
   (//ENTRADAS   
    input clk,
    input init,
    //MF
    input [3:0] UmbralesMFs_HIGH,
    input [3:0] UmbralesMFs_LOW,
    //VF
    input [31:0] UmbralesVCs_HIGH,
    input [31:0] UmbralesVCs_LOW,
    //DF
    input [7:0] UmbralesDs_HIGH,
    input [7:0] UmbralesDs_LOW,
	input reset_L,
	input [4:0] FIFO_EMPTIES,
    input [4:0] FIFO_ERRORS,
    //SALIDAS
	output reg error_out_cond,
    output reg active_out_cond,
    output reg idle_out_cond,
    //MF
    output reg [3:0] UmbralMF_HIGH_cond,
    output reg [3:0] UmbralMF_LOW_cond,
    //VF
    output reg [15:0] UmbralV0_HIGH_cond,
    output reg [15:0] UmbralV0_LOW_cond,
    output reg [15:0] UmbralV1_HIGH_cond,
    output reg [15:0] UmbralV1_LOW_cond,
    //DF
    output reg [3:0] UmbralD0_HIGH_cond,
    output reg [3:0] UmbralD0_LOW_cond,
    output reg [3:0] UmbralD1_HIGH_cond,
    output reg [3:0] UmbralD1_LOW_cond,
    output reg [4:0] error_full_cond);






//Maquinas de estados


reg [2:0] estado;
reg [2:0] estado_prox;
//MF
reg [3:0] UmbralMF_HIGH;
reg [3:0] UmbralMF_LOW;
//VF
reg [15:0] UmbralV0_HIGH;
reg [15:0] UmbralV0_LOW;
reg [15:0] UmbralV1_HIGH;
reg [15:0] UmbralV1_LOW;
//DF
reg [3:0] UmbralD0_HIGH;
reg [3:0] UmbralD0_LOW;
reg [3:0] UmbralD1_HIGH;
reg [3:0] UmbralD1_LOW;
//Estados
parameter RESET_L = 0;
parameter INIT = 1;
parameter IDLE = 2;
parameter ACTIVE = 3;
parameter ERROR = 4;






always @(posedge clk) begin
    if(reset_L==0) begin
        estado <= RESET_L;
    end
    else begin 
        estado<=estado_prox;
    end
end

always @(*) begin
    estado_prox=estado;
    error_out_cond=0;
    active_out_cond=0;
    idle_out_cond=0;
    error_full_cond=0;
    //MF
    UmbralMF_HIGH=UmbralesMFs_HIGH;
    UmbralMF_LOW=UmbralesMFs_LOW;
    //VF
    UmbralV0_HIGH=UmbralesVCs_HIGH[31:16];
    UmbralV0_LOW=UmbralesVCs_LOW[31:16];
    UmbralV1_HIGH=UmbralesVCs_HIGH[15:0];
    UmbralV1_LOW=UmbralesVCs_LOW[15:0];
    //DF
    UmbralD0_HIGH=UmbralesDs_HIGH[7:4];
    UmbralD0_LOW=UmbralesDs_LOW[7:4];
    UmbralD1_HIGH=UmbralesDs_HIGH[3:0];
    UmbralD1_LOW=UmbralesDs_LOW[3:0];
    if(reset_L==0)begin
    UmbralMF_HIGH_cond=0;
    UmbralMF_LOW_cond=0;
    UmbralV0_HIGH_cond=0;
    UmbralV0_LOW_cond=0;
    UmbralV1_HIGH_cond=0;
    UmbralV1_LOW_cond=0;
    UmbralD0_HIGH_cond=0;
    UmbralD0_LOW_cond=0;
    UmbralD1_HIGH_cond=0;
    UmbralD1_LOW_cond=0;
    end else begin
    UmbralMF_HIGH_cond=UmbralMF_HIGH;
    UmbralMF_LOW_cond=UmbralMF_LOW;
    UmbralV0_HIGH_cond=UmbralV0_HIGH;
    UmbralV0_LOW_cond=UmbralV0_LOW;
    UmbralV1_HIGH_cond=UmbralV1_HIGH;
    UmbralV1_LOW_cond=UmbralV1_LOW;
    UmbralD0_HIGH_cond=UmbralD0_HIGH;
    UmbralD0_LOW_cond=UmbralD0_LOW;
    UmbralD1_HIGH_cond=UmbralD1_HIGH;
    UmbralD1_LOW_cond=UmbralD1_LOW;
    end
    case (estado)
        RESET_L: begin
            active_out_cond=0;
            error_out_cond=0;
            idle_out_cond=0;
            error_full_cond=0;
            UmbralMF_HIGH_cond=0;
            UmbralMF_LOW_cond=0;
            UmbralV0_HIGH_cond=0;
            UmbralV0_LOW_cond=0;
            UmbralV1_HIGH_cond=0;
            UmbralV1_LOW_cond=0;
            UmbralD0_HIGH_cond=0;
            UmbralD0_LOW_cond=0;
            UmbralD1_HIGH_cond=0;
            UmbralD1_LOW_cond=0;
            if(reset_L==0)begin
                if(init==1)
                estado_prox=INIT;
            end else
                estado_prox=INIT;
        end
        INIT: begin
            error_out_cond=0;
            idle_out_cond=0;
            active_out_cond=0;
            error_full_cond=0;
            UmbralMF_HIGH=UmbralesMFs_HIGH;
            UmbralMF_LOW=UmbralesMFs_LOW;
            UmbralV0_HIGH=UmbralesVCs_HIGH[31:16];
            UmbralV0_LOW=UmbralesVCs_LOW[31:16];
            UmbralV1_HIGH=UmbralesVCs_HIGH[15:0];
            UmbralV1_LOW=UmbralesVCs_LOW[15:0];
            UmbralD0_HIGH=UmbralesDs_HIGH[7:4];
            UmbralD0_LOW=UmbralesDs_LOW[7:4];
            UmbralD1_HIGH=UmbralesDs_HIGH[3:0];
            UmbralD1_LOW=UmbralesDs_LOW[3:0];
            if(reset_L==0)
                estado_prox=RESET_L;
            else if(init==1)
                estado_prox=INIT;
            else if(FIFO_ERRORS!=4'b0)
                estado_prox=ERROR;
            else if(FIFO_EMPTIES==4'b0)
                estado_prox= IDLE;
            else
                estado_prox = INIT;
        end
        IDLE: begin
            error_out_cond=0;
            idle_out_cond=1;
            active_out_cond=0;
            error_full_cond=0;
            if(reset_L==0)
                estado_prox=RESET_L;
            else if(FIFO_ERRORS!=4'b0)
                estado_prox=ERROR;
            else if(FIFO_EMPTIES!=4'b0)
                estado_prox=ACTIVE;
            else
                estado_prox=IDLE;
        end

        ERROR: begin
            idle_out_cond=0;
            error_out_cond=1;
            active_out_cond=0;
            error_full_cond= FIFO_ERRORS;
            if(reset_L==0)
                estado_prox=RESET_L;
            else 
                estado_prox=ERROR;
           
        end

        ACTIVE: begin
            error_out_cond=0;
            idle_out_cond=0;
            active_out_cond=1;
            if(reset_L==0)
                estado_prox=RESET_L;
            else if(init==1)
                estado_prox=INIT;
            else if(FIFO_ERRORS!=4'b0)
                estado_prox=ERROR;
            else if(FIFO_EMPTIES==4'b0)
                estado_prox= IDLE;
            else
                estado_prox=ACTIVE;
        
        end
    
    endcase

end

endmodule

