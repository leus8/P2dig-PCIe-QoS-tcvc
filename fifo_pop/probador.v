module probador(

    output reg clk,

    output reg [5:0] data_in,

    output reg reset_L,

    output reg vc0_full,

    output reg vc1_full,

    output reg fifo_main_empty,

    // -------> Estructurales --------->

    output reg [5:0] data_in_estr,

    output reg vc0_full_estr,

    output reg vc1_full_estr,

    output reg fifo_main_empty_estr

    );

    initial begin

    $dumpfile("./dump/fifo_main_pop.vcd");
    $dumpvars;

    reset_L <= 0;

    data_in <= 0;
    vc0_full <= 0;
    vc1_full <= 0;
    fifo_main_empty <= 0;

    data_in_estr <= 0;
    vc0_full_estr <= 0;
    vc1_full_estr <= 0;
    fifo_main_empty_estr <= 0;
    @(posedge clk);

    // pop
    reset_L <= 1;

    data_in <= 6'b00_0001;
    vc0_full <= 0;
    vc1_full <= 0;
    fifo_main_empty <= 0;

    data_in_estr <= 6'b00_0001;
    vc0_full_estr <= 0;
    vc1_full_estr <= 0;
    fifo_main_empty_estr <= 0;
    @(posedge clk);

    // no pop
    data_in <= 6'b00_0010;
    vc0_full <= 0;
    vc1_full <= 0;
    fifo_main_empty <= 1;

    data_in_estr <= 6'b00_0010;
    vc0_full_estr <= 0;
    vc1_full_estr <= 0;
    fifo_main_empty_estr <= 1;
    @(posedge clk);

    // no pop
    data_in <= 6'b00_0011;
    vc0_full <= 1;
    vc1_full <= 1;
    fifo_main_empty <= 0;

    data_in_estr <= 6'b00_0011;
    vc0_full_estr <= 1;
    vc1_full_estr <= 1;
    fifo_main_empty_estr <= 0;
    @(posedge clk);

    // no pop
    data_in <= 6'b01_0100;
    vc0_full <= 1;
    vc1_full <= 1;
    fifo_main_empty <= 1;

    data_in_estr <= 6'b01_0100;
    vc0_full_estr <= 1;
    vc1_full_estr <= 1;
    fifo_main_empty_estr <= 1;
    @(posedge clk);

    // pop
    data_in <= 6'b00_0101;
    vc0_full <= 0;
    vc1_full <= 0;
    fifo_main_empty <= 0;

    data_in_estr <= 6'b00_0101;
    vc0_full_estr <= 0;
    vc1_full_estr <= 0;
    fifo_main_empty_estr <= 0;
    @(posedge clk);

    @(posedge clk);

    $finish;
    end

    initial clk <= 0;
    always #2 clk <= ~clk;


endmodule