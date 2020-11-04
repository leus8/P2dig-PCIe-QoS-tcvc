module probador 
    (output reg clk,
	output reg reset,
    output reg init,
    output reg UmbralesMFs,
    output reg [1:0] UmbralesVCs,
    output reg [1:0] UmbralesDs,
    output reg [4:0] FIFO_EMPTIES,
    output reg [4:0] FIFO_ERRORS,
	input error_out_cond,
    input active_out_cond,
    input idle_out_cond,
    input UmbralMF_cond,
    input UmbralV0_cond,
    input UmbralV1_cond,
    input UmbralD0_cond,
    input UmbralD1_cond,
    input error_out_estr,
    input active_out_estr,
    input idle_out_estr,
    input UmbralMF_estr,
    input UmbralV0_estr,
    input UmbralV1_estr,
    input UmbralD0_estr,
    input UmbralD1_estr);

initial begin
    $dumpfile("waves.vcd");
    $dumpvars;
    init<=0;
    UmbralesVCs<=2'b01;
    UmbralesDs<=2'b11;
    UmbralesMFs<=1;
    FIFO_EMPTIES<=4'b0;
    FIFO_ERRORS<=4'b0;
    reset<=0;
    repeat(4)begin
    @(posedge clk);
    end
    reset<=1;
    //ARANCA
    @(posedge clk);
    repeat(4)begin
    @(posedge clk);
    end
    //PASAMOS A IDLE
    FIFO_EMPTIES<=4'b0;
    repeat(4)begin
    @(posedge clk);
    end
    //PASAMOS A ACTIVE
    FIFO_EMPTIES<=4'b1110;
    repeat(4)begin
    @(posedge clk);
    end
    //PASAMOS A IDLE
    FIFO_EMPTIES<=4'b0;
    repeat(4)begin
    @(posedge clk);
    end
    //ERROR
    UmbralesVCs<=2'b11;
    UmbralesDs<=2'b00;
    UmbralesMFs<=0;
    FIFO_ERRORS<=4'b1001;
    repeat(4)begin
    @(posedge clk);
    end
    //REINICIAMOS
    reset<=0;
    repeat(4)begin
    @(posedge clk);
    end
    reset<=1;
    repeat(4)begin
    @(posedge clk);
    end




    $finish;
end

initial clk <= 0; 
always #2 clk <= ~clk;

endmodule




