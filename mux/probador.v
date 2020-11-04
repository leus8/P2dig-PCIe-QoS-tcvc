module probador( // Módulo probador: generador de señales y monitor de datos
	output reg [5:0]	data_in0,
	output reg [5:0]	data_in1,
    output reg          valid_in0,
    output reg          valid_in1,
	output reg 			selector,
	output reg 			reset_L,
	output reg 			clk,
	
    // ------------------> Estructurales -------------->
    output reg [5:0]	data_in0_estr,
	output reg [5:0]	data_in1_estr,
    output reg valid_in0_estr,
    output reg valid_in1_estr

    );

	initial begin
		$dumpfile("./dump/mux.vcd");	// Nombre de archivo del "dump"
		$dumpvars;			// Directiva para "dumpear" variables

		// Generacion de las señales de entrada
			data_in0 <= 6'b00_0000; // Entradas en 0
			data_in1 <= 6'b00_0000;
            valid_in0 <= 0;
            valid_in1 <= 0;

            data_in0_estr <= 6'b00_0000; // Entradas en 0
			data_in1_estr <= 6'b00_0000;
            valid_in0_estr <= 0;
            valid_in1_estr <= 0;

    		reset_L <= 0;
			selector <= 0;
    	@(posedge clk); // Cambio con reset en 0, selector en 0
    		reset_L <= 1; 
    	@(posedge clk); // Cambio con reset ya en 1, de aqui en adelante se mantiene asi.
    		data_in0 <= 6'b00_0011; 
    		data_in1 <= 6'b00_0010;
            valid_in0 <= 1;
            valid_in1 <= 1;

            data_in0_estr <= 6'b00_0011; 
    		data_in1_estr <= 6'b00_0010;
            valid_in0_estr <= 1;
            valid_in1_estr <= 1;
    	@(posedge clk);
    		data_in0 <= 6'b00_0001; 
    		data_in1 <= 6'b00_0000;

            data_in0_estr <= 6'b00_0001; 
    		data_in1_estr <= 6'b00_0000;
			selector = 1;
    	@(posedge clk); // cambio con selector en 1
    		data_in0 <= 6'b00_0000; 
    		data_in1 <= 6'b00_0010;

            data_in0_estr <= 6'b00_0000; 
    		data_in1_estr <= 6'b00_0010;
    	@(posedge clk);
    		data_in0 <= 6'b00_0011; 
    		data_in1 <= 6'b00_0011;

            data_in0_estr <= 6'b00_0011; 
    		data_in1_estr <= 6'b00_0011;
			selector = 0;
		@(posedge clk); // cambio con selector en 0
    		data_in0 <= 6'b00_0000; 
    		data_in1 <= 6'b00_0001;

            data_in0_estr <= 6'b00_0000; 
    		data_in1_estr <= 6'b00_0001;
			selector = 1;
		@(posedge clk); // cambio con selector en 1
			data_in0 <= 6'b00_0010; 
    		data_in1 <= 6'b00_0000;

            data_in0_estr <= 6'b00_0010; 
    		data_in1_estr <= 6'b00_0000;
			selector = 0;
		@(posedge clk);
		@(posedge clk);

		$finish;
	end

	initial clk <= 0; 
	always #2 clk <= ~clk;

endmodule