module probador 
    (output reg clk,
	output reg reset,
    output reg init,
    output reg [3:0] UmbralesMFs,
    output reg [31:0] UmbralesVCs,
    output reg [7:0] UmbralesDs,
    output reg [4:0] FIFO_EMPTIES,
    output reg [4:0] FIFO_ERRORS,
	input error_out_cond,
    input active_out_cond,
    input idle_out_cond,
    input [3:0] UmbralMF_cond,
    input [15:0] UmbralV0_cond,
    input [15:0] UmbralV1_cond,
    input [3:0] UmbralD0_cond,
    input [3:0] UmbralD1_cond,
    input [4:0] error_full_cond,
    input error_out_estr,
    input active_out_estr,
    input idle_out_estr,
    input [3:0] UmbralMF_estr,
    input [15:0] UmbralV0_estr,
    input [15:0] UmbralV1_estr,
    input [3:0] UmbralD0_estr,
    input [3:0] UmbralD1_estr,
    input [4:0] error_full_estr);

initial begin
    $dumpfile("waves.vcd");
    $dumpvars;
    init<=0;
    UmbralesVCs<=32'hbcbcaaff;
    UmbralesDs<=8'b11111010;
    UmbralesMFs<=4'b1111;
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
    UmbralesVCs<=32'hcbcbaabb;
    UmbralesDs<=8'b11001010;
    UmbralesMFs<=4'b1001;
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




