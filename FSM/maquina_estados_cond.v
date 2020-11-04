module maquina_estados_cond
   (//ENTRADAS   
    input clk,
    input init,
    input UmbralesMFs,
    input [1:0] UmbralesVCs,
    input [1:0] UmbralesDs,
	input reset,
	input [4:0] FIFO_EMPTIES,
    input [4:0] FIFO_ERRORS,
    //SALIDAS
	output reg error_out_cond,
    output reg active_out_cond,
    output reg idle_out_cond,
    output reg UmbralMF_cond,
    output reg UmbralV0_cond,
    output reg UmbralV1_cond,
    output reg UmbralD0_cond,
    output reg UmbralD1_cond);






//Maquinas de estados


reg [2:0] estado;
reg [2:0] estado_prox;

parameter RESET = 0;
parameter INIT = 1;
parameter IDLE = 2;
parameter ACTIVE = 3;
parameter ERROR = 4;


always @(*) begin
        UmbralMF_cond=0;
        UmbralV0_cond=0;
        UmbralV1_cond=0;
        UmbralD0_cond=0;
        UmbralD1_cond=0;
    if(reset==0)begin
        UmbralMF_cond=0;
        UmbralV0_cond=0;
        UmbralV1_cond=0;
        UmbralD0_cond=0;
        UmbralD1_cond=0;
    end

end




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
    case (estado)
        RESET: begin
            active_out_cond=0;
            error_out_cond=0;
            idle_out_cond=0;
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
            UmbralMF_cond=UmbralesMFs;
            UmbralV0_cond=UmbralesVCs[0];
            UmbralV1_cond=UmbralesVCs[1];
            UmbralD0_cond=UmbralesDs[0];
            UmbralD1_cond=UmbralesDs[1];
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

