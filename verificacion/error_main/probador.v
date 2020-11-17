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
    $dumpfile("./dump/interconexion.vcd");
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

    Main_data_in<=6'b10_0001;
    @(posedge clk);

    Main_data_in<=6'b11_1111;
    @(posedge clk);

    Main_data_in<=6'b10_1100;
    @(posedge clk);

    Main_data_in<=6'b11_0101;
    @(posedge clk);

    Main_data_in<=6'b10_0001;
    @(posedge clk);

    Main_data_in<=6'b11_1111;
    @(posedge clk);

    Main_data_in<=6'b10_1100;
    @(posedge clk);


    // se llena V0 y V1 casi lleno
    Main_data_in<=6'b00_0001; 
    @(posedge clk);

    Main_data_in<=6'b11_1101; // 1
    @(posedge clk);

    Main_data_in<=6'b00_1100;
    @(posedge clk);

    Main_data_in<=6'b11_0010; // 2
    @(posedge clk);

    Main_data_in<=6'b00_0110;
    @(posedge clk);

    Main_data_in<=6'b11_0100; // 3
    @(posedge clk);

    Main_data_in<=6'b00_1000;
    @(posedge clk);

    Main_data_in<=6'b11_1100; // 4
    @(posedge clk);

    Main_data_in<=6'b00_0101;
    @(posedge clk);

    Main_data_in<=6'b11_0111; // 5
    @(posedge clk);

    Main_data_in<=6'b00_1100;
    @(posedge clk);

    Main_data_in<=6'b11_0101; // 6
    @(posedge clk);

    Main_data_in<=6'b00_0110;
    @(posedge clk);

    Main_data_in<=6'b11_0100; // 7
    @(posedge clk);

    Main_data_in<=6'b00_1000;
    @(posedge clk);

    Main_data_in<=6'b11_1100; // 8
    @(posedge clk);


    Main_data_in<=6'b00_0111;
    @(posedge clk);

    Main_data_in<=6'b11_0111; // 9
    @(posedge clk);

    Main_data_in<=6'b00_1100;
    @(posedge clk);

    Main_data_in<=6'b11_0001; // 10
    @(posedge clk);

    Main_data_in<=6'b00_0110;
    @(posedge clk);

    Main_data_in<=6'b11_0100; // 11
    @(posedge clk);

    Main_data_in<=6'b00_1000;
    @(posedge clk);

    Main_data_in<=6'b11_1100; // 12
    @(posedge clk);

    Main_data_in<=6'b00_0101;
    @(posedge clk);

    Main_data_in<=6'b11_0111; // 13
    @(posedge clk);

    Main_data_in<=6'b00_1100;
    @(posedge clk);

    Main_data_in<=6'b11_0101; // 14
    @(posedge clk);

    Main_data_in<=6'b00_0110;
    @(posedge clk);

    Main_data_in<=6'b11_0111; // 15
    @(posedge clk);

    Main_data_in<=6'b00_1100; // 16 VC0
    @(posedge clk);
    

    // se llena Main

    Main_data_in<=6'b10_0001;
    @(posedge clk);

    Main_data_in<=6'b10_0111;
    @(posedge clk);

    Main_data_in<=6'b10_1100;
    @(posedge clk);

    Main_data_in<=6'b10_0101;
    @(posedge clk);

    Main_data_in<=6'b10_1101;
    @(posedge clk);

    Main_data_in<=0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);


    $finish;
end

    // push fifo main
    always @ (*) begin
        if (reset_L && Main_data_in) begin
            Main_wr = 1;
            @(posedge clk);
        end
        else begin
            Main_wr = 0;
            @(posedge clk);
        end
    end

/*
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
*/

initial clk <= 0; 
always #8 clk <= ~clk;

endmodule