module probador(

    output reg clk, // clk

    output reg [5:0] data_in, // entrada de datos
 
    output reg reset_L, // reset_L para correcto funcionamiento estructural

    output reg valid_in, // valid de entrada

    // -------------> Estructural <---------------------

    output reg [5:0] data_in_estr, // entrada de datos


    output reg valid_in_estr // valid de entrada

    
    );

    initial begin

    $dumpfile("./dump/demux_vcid.vcd");
    $dumpvars;

    data_in <= 0;
    data_in_estr <= 0;
    valid_in <= 0;
    valid_in_estr <= 0;
    reset_L <= 0;

    @(posedge clk);
    @(posedge clk);

    data_in <= 6'b01_0001;
    data_in_estr <= 6'b01_0001;
    reset_L <= 1;
    valid_in <= 1;
    valid_in_estr <= 1;
    @(posedge clk);

    data_in <= 6'b11_0010;
    data_in_estr <= 6'b11_0010;
    @(posedge clk);

    data_in <= 6'b11_0011;
    data_in_estr <= 6'b11_0011;
    @(posedge clk);

    data_in <= 6'b01_0100;
    data_in_estr <= 6'b01_0100;
    @(posedge clk);

    data_in <= 0;
    data_in_estr <= 0;
    valid_in <= 0;
    valid_in_estr <= 0;
    @(posedge clk);


    @(posedge clk);
    @(posedge clk);

    $finish;
    end

    initial clk <= 0;
    always #2 clk <= ~clk;

endmodule