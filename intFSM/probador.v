module probador (
	output reg reset_L,
    output reg clk,
    output reg Main_wr,
    output reg D0_rd,
    output reg D1_rd,
    output reg init,
    output reg [(BW-1):0] Main_data_in,

    //Maquina de estados entrada
    //MF
    output reg [3:0] UmbralesMFs_HIGH,
    output reg [3:0] UmbralesMFs_LOW,
    //VF
    output reg [31:0] UmbralesVCs_HIGH,
    output reg [31:0] UmbralesVCs_LOW,
    //DF
    output reg [7:0] UmbralesDs_HIGH,
    output reg [7:0] UmbralesDs_LOW,
    // FIFO: Main
    input Main_full,


    // FIFO: D0
    input D0_empty,
    input D0_error_output,

    // FIFO: D1
    input D1_empty,
    input D1_error_output,

    // DATA OUT
    input [(BW-1):0] D0_data_out,
    input [(BW-1):0] D1_data_out,

    //Maquinas de estados salida
    input error_out_cond,
    input active_out_cond,
    input idle_out_cond,
    input [4:0] error_full_cond);

    parameter BW = 6;
    parameter LEN4=4;
    parameter LEN16=16;


initial begin
    $dumpfile("./dump/interconexion.vcd");
    $dumpvars;

    // 6'b01_0001;
    UmbralesMFs_HIGH<=3;
    UmbralesMFs_LOW<=1;
    //VF
    UmbralesVCs_HIGH<=32'hFFFFFFFF;
    UmbralesVCs_LOW<=32'h1;
    //DF
    UmbralesDs_HIGH<=16'hFFFF;
    UmbralesDs_LOW<=16'h1;
    Main_data_in<=0;
    Main_wr<=0;
    reset_L<=0;
    init<=0;
    @(posedge clk);
    init<=1;
    reset_L<=1;
    Main_data_in<=6'b00_0101;
    @(posedge clk);

    Main_data_in<=6'b01_0111;
    @(posedge clk);

    Main_data_in<=6'b01_1100;
    @(posedge clk);

    Main_data_in<=6'b00_0001;
    @(posedge clk);

    Main_data_in<=6'b10_0110;
    @(posedge clk);

    Main_data_in<=6'b01_0100;
    @(posedge clk);

    Main_data_in<=6'b10_1000;
    @(posedge clk);

    repeat (20) begin
    @(posedge clk);
    end

    $finish;
end

    // push fifo main
    always @ (*) begin
        if (reset_L && ~Main_full && Main_data_in) begin
            Main_wr = 1;
            @(posedge clk);
        end
        else begin
            Main_wr = 0;
            @(posedge clk);
        end
    end

    // read D0
    always @ (*) begin
        if (reset_L && ~D0_empty && ~D0_error_output) begin
            D0_rd = 1;
            @(posedge clk);
        end
        else begin
            D0_rd = 0;
            @(posedge clk);
        end
    end

    // read D1
    always @ (*) begin
        if (reset_L && ~D1_empty && ~D1_error_output) begin
            D1_rd = 1;
            @(posedge clk);
        end
        else begin
            D1_rd = 0;
            @(posedge clk);
        end
    end

initial clk <= 0; 
always #8 clk <= ~clk;

endmodule