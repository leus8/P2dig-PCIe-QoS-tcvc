all: yosys iverilog gtkwave clean

yosys:
	yosys ./scripts/yosys_script.ys
	sed -i 's/cond/estr/g' maquina_estados_estr.v

iverilog:
	iverilog -o out.o banco_pruebas.v
	vvp out.o

gtkwave:
	gtkwave waves.vcd

clean:
	rm *.o
	rm *.vcd