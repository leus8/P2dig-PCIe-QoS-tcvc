module probador 
(   output reg clk,
    output reg reset_L,
    output reg [3:0] dataA,
    output reg [3:0] dataB,
    output reg [3:0] idx,
    input [3:0] sum30_dd,
    input [3:0] idx_dd);

initial begin
    $dumpfile("./dump/sum_pipe.vcd");
    $dumpvars;
    reset_L<=0;
    dataA<=4'b0001;
    dataB<=4'b0010;
    idx<=4'b0001;
    @(posedge clk);
    @(posedge clk);
    reset_L<=1;
    @(posedge clk);
    dataA<=4'b0100;
    dataB<=4'b0110;
    idx<=4'b0010;
    @(posedge clk);
    dataA<=4'b0011;
    dataB<=4'b0011;
    idx<=4'b0011;
    @(posedge clk);
    dataA<=4'b0011;
    dataB<=4'b1110;
    idx<=4'b0100;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    $finish;
    end


    

initial clk <= 0; 
always #2 clk <= ~clk;

endmodule




