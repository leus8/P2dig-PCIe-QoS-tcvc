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
    input Main_full_estr,


    // FIFO: D0
    input D0_empty,
    input D0_error_output,
    input D0_empty_estr,
    input D0_error_output_estr,

    // FIFO: D1
    input D1_empty,
    input D1_error_output,
    input D1_empty_estr,
    input D1_error_output_estr,

    // DATA OUT
    input [(BW-1):0] D0_data_out,
    input [(BW-1):0] D1_data_out,
    input [(BW-1):0] D0_data_out_estr,
    input [(BW-1):0] D1_data_out_estr,


    //Maquinas de estados salida
    input error_out,
    input active_out,
    input idle_out,
    input [4:0] error_full,
    input error_out_estr,
    input active_out_estr,
    input idle_out_estr,
    input [4:0] error_full_estr);

    parameter BW = 6;
    parameter LEN4=4;
    parameter LEN16=16;


initial begin
    $dumpfile("./dump/camino_v1_d1.vcd");
    $dumpvars;

    // 6'b01_0001;
    UmbralesMFs_HIGH<=3;
    UmbralesMFs_LOW<=1;
    //VF
    UmbralesVCs_HIGH<=32'b00000000000011110000000000001111; // 15 y 15
    UmbralesVCs_LOW<=32'b00000000000000010000000000000001; // 1 y 1
    //DF
    UmbralesDs_HIGH<=8'b00110011; // 3 y 3
    UmbralesDs_LOW<=16'b00010001; // 1 y 1
    Main_data_in<=0;
    //Main_wr<=0;

    D0_rd <= 0;
    D1_rd <= 0;

    reset_L<=0;
    init<=0;
    @(posedge clk);

    reset_L<=1;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);

    // se llenan D0 y D1 casi lleno

    Main_data_in<=6'b11_0001;
    @(posedge clk);

    Main_data_in<=6'b11_1111;
    @(posedge clk);

    Main_data_in<=6'b11_1100;
    @(posedge clk);

    Main_data_in<=6'b11_0101;
    @(posedge clk);

    Main_data_in<=6'b11_0001;
    @(posedge clk);

    Main_data_in<=6'b11_1111;
    @(posedge clk);

    Main_data_in<=6'b11_1100;
    @(posedge clk);
    D0_rd <= 0;
    D1_rd <= 1;

    Main_data_in<=6'b11_0001;
    @(posedge clk);

    Main_data_in<=6'b11_1111;
    @(posedge clk);

    Main_data_in<=6'b11_1100;
    @(posedge clk);

    Main_data_in<=6'b11_0101;
    @(posedge clk);

    Main_data_in<=6'b11_0001;
    @(posedge clk);

    Main_data_in<=6'b11_1111;
    @(posedge clk);



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


initial clk <= 0; 
always #8 clk <= ~clk;

endmodule