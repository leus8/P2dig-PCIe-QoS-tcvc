module maquina_estados_cond
   (//ENTRADAS   
    input clk,
    input init,
    input [3:0] UmbralesMFs,
    input [31:0] UmbralesVCs,
    input [7:0] UmbralesDs,
	input reset,
	input [4:0] FIFO_EMPTIES,
    input [4:0] FIFO_ERRORS,
    //SALIDAS
	output reg error_out_cond,
    output reg active_out_cond,
    output reg idle_out_cond,
    output reg [3:0] UmbralMF_cond,
    output reg [15:0] UmbralV0_cond,
    output reg [15:0] UmbralV1_cond,
    output reg [3:0] UmbralD0_cond,
    output reg [3:0] UmbralD1_cond,
    output reg [4:0] error_full_cond);






//Maquinas de estados


reg [2:0] estado;
reg [2:0] estado_prox;
reg [3:0] UmbralMF;
reg [15:0] UmbralV0;
reg [15:0] UmbralV1;
reg [3:0] UmbralD0;
reg [3:0] UmbralD1;
parameter RESET = 0;
parameter INIT = 1;
parameter IDLE = 2;
parameter ACTIVE = 3;
parameter ERROR = 4;






always @(posedge clk) begin
    if(reset==0) begin
        estado <= RESET;
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
    UmbralMF=UmbralesMFs;
    UmbralV0=UmbralesVCs[31:16];
    UmbralV1=UmbralesVCs[15:0];
    UmbralD0=UmbralesDs[7:4];
    UmbralD1=UmbralesDs[3:0];
    if(reset==0)begin
    UmbralMF_cond=4'b0;
    UmbralV0_cond=16'b0;
    UmbralV1_cond=16'b0;
    UmbralD0_cond=0;
    UmbralD1_cond=0;
    end else begin
    UmbralMF_cond=UmbralMF;
    UmbralV0_cond=UmbralV0;
    UmbralV1_cond=UmbralV1;
    UmbralD0_cond=UmbralD0;
    UmbralD1_cond=UmbralD1;
    end
    case (estado)
        RESET: begin
            active_out_cond=0;
            error_out_cond=0;
            idle_out_cond=0;
            error_full_cond=0;
            if(reset==0)begin
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
            UmbralMF=UmbralesMFs;
            UmbralV0=UmbralesVCs[31:16];
            UmbralV1=UmbralesVCs[15:0];
            UmbralD0=UmbralesDs[7:4];
            UmbralD1=UmbralesDs[3:0];
            if(reset==0)
                estado_prox=RESET;
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
            if(reset==0)
                estado_prox=RESET;
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
            if(reset==0)
                estado_prox=RESET;
            else 
                estado_prox=ERROR;
           
        end

        ACTIVE: begin
            error_out_cond=0;
            idle_out_cond=0;
            active_out_cond=1;
            if(reset==0)
                estado_prox=RESET;
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

