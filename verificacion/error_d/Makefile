# set compiler option
CC=iverilog

# project directories
BASEDIR=.
DUMPDIR=$(BASEDIR)/dump
BINDIR=$(BASEDIR)/bin

OUTFILE=output

# Compiler options and flags
iFLAGS=

all: yosys sed build run wave

build:
	mkdir -p dump
	mkdir -p bin
	emacs --batch testbench.v -f verilog-batch-auto
	$(CC) -o $(BINDIR)/$(OUTFILE) testbench.v
	
clean:
	rm -f $(BINDIR)/$(OUTFILE)
	rm -f $(BINDIR)/$(DUMPDIR)/*

run:
	vvp $(BINDIR)/$(OUTFILE)
	
wave:
	gtkwave $(DUMPDIR)/error_d.vcd

yosys:

	yosys -s ./ys/Modulo.ys
	
sed:

	sed -i 's/Modulo_cond/Modulo_estr/' Modulo_estr.v
	sed -i 's/interconnect_cond/interconnect_estr/' Modulo_estr.v
	sed -i 's/maquina_estados_cond/maquina_estados_estr/' Modulo_estr.v
	sed -i 's/D0_cond/D0_estr/' Modulo_estr.v
	sed -i 's/D1_cond/D1_estr/' Modulo_estr.v
	sed -i 's/VC0_cond/VC0_estr/' Modulo_estr.v
	sed -i 's/VC1_cond/VC1_estr/' Modulo_estr.v
	sed -i 's/Main_cond/Main_estr/' Modulo_estr.v
	sed -i 's/fifo_cond/fifo_estr/' Modulo_estr.v
	sed -i 's/fifo16_cond/fifo16_estr/' Modulo_estr.v
	sed -i 's/demux_dest_cond/demux_dest_estr/' Modulo_estr.v
	sed -i 's/demux_vc_id_cond/demux_vc_id_estr/' Modulo_estr.v
	sed -i 's/fifo_main_pop_cond/fifo_main_pop_estr/' Modulo_estr.v
	sed -i 's/pop_delay_vc0_cond/pop_delay_vc0_estr/' Modulo_estr.v
	sed -i 's/mux_cond/mux_estr/' Modulo_estr.v

autoinst:
# To use autoinst call make target autoinst as follows:
# make autoinst file=name_of_file

	emacs --batch $(file) -f verilog-batch-auto

.PHONY: all build clean run wave yosys sed autoinst