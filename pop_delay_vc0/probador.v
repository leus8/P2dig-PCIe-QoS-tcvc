module probador(

    output reg clk,

    output reg reset_L,

    output reg d0_full,

    output reg d1_full,

    output reg vc0_empty,

    output reg vc1_empty,

    // -------> Estructurales --------->
    output reg d0_full_estr,

    output reg d1_full_estr,

    output reg vc0_empty_estr,

    output reg vc1_empty_estr

    );

    initial begin

    $dumpfile("./dump/pop_delay_vc0.vcd");
    $dumpvars;

    reset_L <= 0;

    d0_full <= 0;
    d1_full <= 0;
    vc0_empty <= 1;
    vc1_empty <= 1;

    d0_full_estr <= 0;
    d1_full_estr <= 0;
    vc0_empty_estr <= 1;
    vc1_empty_estr <= 1;
    @(posedge clk);

    // pop vc0
    reset_L <= 1;

    d0_full <= 0;
    d1_full <= 0;
    vc0_empty <= 0;
    vc1_empty <= 0;

    d0_full_estr <= 0;
    d1_full_estr <= 0;
    vc0_empty_estr <= 0;
    vc1_empty_estr <= 0;
    @(posedge clk);

    // no pop vc0
    d0_full <= 1;
    d1_full <= 1;
    vc0_empty <= 0;
    vc1_empty <= 0;

    d0_full_estr <= 1;
    d1_full_estr <= 1;
    vc0_empty_estr <= 0;
    vc1_empty_estr <= 0;
    @(posedge clk);

    // no pop vc0
    d0_full <= 0;
    d1_full <= 0;
    vc0_empty <= 1;
    vc1_empty <= 1;

    d0_full_estr <= 0;
    d1_full_estr <= 0;
    vc0_empty_estr <= 1;
    vc1_empty_estr <= 1;
    @(posedge clk);

    // no pop vc0
    d0_full <= 1;
    d1_full <= 1;
    vc0_empty <= 1;
    vc1_empty <= 1;

    d0_full_estr <= 1;
    d1_full_estr <= 1;
    vc0_empty_estr <= 1;
    vc1_empty_estr <= 1;
    @(posedge clk);

    // pop vc0
    d0_full <= 0;
    d1_full <= 0;
    vc0_empty <= 0;
    vc1_empty <= 0;

    d0_full_estr <= 0;
    d1_full_estr <= 0;
    vc0_empty_estr <= 0;
    vc1_empty_estr <= 0;
    @(posedge clk);

    // no pop vc0 - pop vc1
    d0_full <= 0;
    d1_full <= 0;
    vc0_empty <= 1;
    vc1_empty <= 0;

    d0_full_estr <= 0;
    d1_full_estr <= 0;
    vc0_empty_estr <= 1;
    vc1_empty_estr <= 0;
    @(posedge clk);
    @(posedge clk);

    $finish;
    end

    initial clk <= 0;
    always #2 clk <= ~clk;


endmodule