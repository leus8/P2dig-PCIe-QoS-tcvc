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
	output reg error_out,
    output reg active_out,
    output reg idle_out,
    //MF
    output reg [3:0] UmbralMF_HIGH,
    output reg [3:0] UmbralMF_LOW,
    //VF
    output reg [15:0] UmbralV0_HIGH,
    output reg [15:0] UmbralV0_LOW,
    output reg [15:0] UmbralV1_HIGH,
    output reg [15:0] UmbralV1_LOW,
    //DF
    output reg [3:0] UmbralD0_HIGH,
    output reg [3:0] UmbralD0_LOW,
    output reg [3:0] UmbralD1_HIGH,
    output reg [3:0] UmbralD1_LOW,
    output reg [4:0] error_full);






//Maquinas de estados


reg [2:0] estado;
reg [2:0] estado_prox;
//MF
reg [3:0] UmbralMF_HIGH_intern;
reg [3:0] UmbralMF_LOW_intern;
//VF
reg [15:0] UmbralV0_HIGH_intern;
reg [15:0] UmbralV0_LOW_intern;
reg [15:0] UmbralV1_HIGH_intern;
reg [15:0] UmbralV1_LOW_intern;
//DF
reg [3:0] UmbralD0_HIGH_intern;
reg [3:0] UmbralD0_LOW_intern;
reg [3:0] UmbralD1_HIGH_intern;
reg [3:0] UmbralD1_LOW_intern;
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
    error_out=0;
    active_out=0;
    idle_out=0;
    error_full=0;
    //MF
    UmbralMF_HIGH_intern=UmbralesMFs_HIGH;
    UmbralMF_LOW_intern=UmbralesMFs_LOW;
    //VF
    UmbralV0_HIGH_intern=UmbralesVCs_HIGH[31:16];
    UmbralV0_LOW_intern=UmbralesVCs_LOW[31:16];
    UmbralV1_HIGH_intern=UmbralesVCs_HIGH[15:0];
    UmbralV1_LOW_intern=UmbralesVCs_LOW[15:0];
    //DF
    UmbralD0_HIGH_intern=UmbralesDs_HIGH[7:4];
    UmbralD0_LOW_intern=UmbralesDs_LOW[7:4];
    UmbralD1_HIGH_intern=UmbralesDs_HIGH[3:0];
    UmbralD1_LOW_intern=UmbralesDs_LOW[3:0];
    if(reset_L==0)begin
    UmbralMF_HIGH=0;
    UmbralMF_LOW=0;
    UmbralV0_HIGH=0;
    UmbralV0_LOW=0;
    UmbralV1_HIGH=0;
    UmbralV1_LOW=0;
    UmbralD0_HIGH=0;
    UmbralD0_LOW=0;
    UmbralD1_HIGH=0;
    UmbralD1_LOW=0;
    end else begin
    UmbralMF_HIGH=UmbralMF_HIGH_intern;
    UmbralMF_LOW=UmbralMF_LOW_intern;
    UmbralV0_HIGH=UmbralV0_HIGH_intern;
    UmbralV0_LOW=UmbralV0_LOW_intern;
    UmbralV1_HIGH=UmbralV1_HIGH_intern;
    UmbralV1_LOW=UmbralV1_LOW_intern;
    UmbralD0_HIGH=UmbralD0_HIGH_intern;
    UmbralD0_LOW=UmbralD0_LOW_intern;
    UmbralD1_HIGH=UmbralD1_HIGH_intern;
    UmbralD1_LOW=UmbralD1_LOW_intern;
    end
    case (estado)
        RESET_L: begin
            active_out=0;
            error_out=0;
            idle_out=0;
            error_full=0;
            UmbralMF_HIGH=0;
            UmbralMF_LOW=0;
            UmbralV0_HIGH=0;
            UmbralV0_LOW=0;
            UmbralV1_HIGH=0;
            UmbralV1_LOW=0;
            UmbralD0_HIGH=0;
            UmbralD0_LOW=0;
            UmbralD1_HIGH=0;
            UmbralD1_LOW=0;
            if(reset_L==0)begin
                if(init==1)
                estado_prox=INIT;
            end else
                estado_prox=INIT;
        end
        INIT: begin
            error_out=0;
            idle_out=0;
            active_out=0;
            error_full=0;
            UmbralMF_HIGH_intern=UmbralesMFs_HIGH;
            UmbralMF_LOW_intern=UmbralesMFs_LOW;
            UmbralV0_HIGH_intern=UmbralesVCs_HIGH[31:16];
            UmbralV0_LOW_intern=UmbralesVCs_LOW[31:16];
            UmbralV1_HIGH_intern=UmbralesVCs_HIGH[15:0];
            UmbralV1_LOW_intern=UmbralesVCs_LOW[15:0];
            UmbralD0_HIGH_intern=UmbralesDs_HIGH[7:4];
            UmbralD0_LOW_intern=UmbralesDs_LOW[7:4];
            UmbralD1_HIGH_intern=UmbralesDs_HIGH[3:0];
            UmbralD1_LOW_intern=UmbralesDs_LOW[3:0];
            if(reset_L==0)
                estado_prox=RESET_L;
            else if(init==1)
                estado_prox=INIT;
            else if(FIFO_ERRORS!=4'b0)
                estado_prox=ERROR;
            else if(FIFO_EMPTIES==4'b1111)
                estado_prox= IDLE;
            else if(FIFO_EMPTIES!=4'b1111)
                estado_prox= ACTIVE;    
            else
                estado_prox = IDLE;
        end
        IDLE: begin
            error_out=0;
            idle_out=1;
            active_out=0;
            error_full=0;
            if(reset_L==0)
                estado_prox=RESET_L;
            else if(FIFO_ERRORS!=4'b0)
                estado_prox=ERROR;
            else if(FIFO_EMPTIES!=4'b1111)
                estado_prox=ACTIVE;
            else
                estado_prox=IDLE;
        end

        ERROR: begin
            idle_out=0;
            error_out=1;
            active_out=0;
            error_full= FIFO_ERRORS;
            if(reset_L==0)
                estado_prox=RESET_L;
            else 
                estado_prox=ERROR;
           
        end

        ACTIVE: begin
            error_out=0;
            idle_out=0;
            active_out=1;
            if(reset_L==0)
                estado_prox=RESET_L;
            else if(init==1)
                estado_prox=INIT;
            else if(FIFO_ERRORS!=4'b0)
                estado_prox=ERROR;
            else if(FIFO_EMPTIES==4'b1111)
                estado_prox= IDLE;
            else
                estado_prox=ACTIVE;
        
        end
    
    endcase

end

endmodule

