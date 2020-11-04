module probador(

    output reg clk,

    output reg reset_L,

    output reg d0_full,

    output reg d1_full,

    output reg vc0_empty,

    output reg vc1_empty

    // -------> Estructurales --------->


    );

    initial begin

    $dumpfile("./dump/pop_delay_vc0.vcd");
    $dumpvars;

    reset_L <= 0;

    d0_full <= 0;
    d1_full <= 0;
    vc0_empty <= 1;
    vc1_empty <= 1;
    @(posedge clk);

    // pop vc0
    reset_L <= 1;

    d0_full <= 0;
    d1_full <= 0;
    vc0_empty <= 0;
    vc1_empty <= 0;
    @(posedge clk);

    // no pop vc0
    d0_full <= 1;
    d1_full <= 1;
    vc0_empty <= 0;
    vc1_empty <= 0;
    @(posedge clk);

    // no pop vc0
    d0_full <= 0;
    d1_full <= 0;
    vc0_empty <= 1;
    vc1_empty <= 1;
    @(posedge clk);

    // no pop vc0
    d0_full <= 1;
    d1_full <= 1;
    vc0_empty <= 1;
    vc1_empty <= 1;
    @(posedge clk);

    // pop vc0
    d0_full <= 0;
    d1_full <= 0;
    vc0_empty <= 0;
    vc1_empty <= 0;
    @(posedge clk);

    // no pop vc0
    d0_full <= 0;
    d1_full <= 0;
    vc0_empty <= 1;
    vc1_empty <= 0;
    @(posedge clk);
    @(posedge clk);

    $finish;
    end

    initial clk <= 0;
    always #2 clk <= ~clk;


endmodule