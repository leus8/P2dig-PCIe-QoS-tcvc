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
	gtkwave $(DUMPDIR)/interconexion.vcd

yosys:

	yosys -s ./ys/Modulo.ys
	
sed:

	sed -i 's/Modulo/Modulo_estr/' Modulo_estr.v
	sed -i 's/interconnect/interconnect_estr/' Modulo_estr.v
	sed -i 's/maquina_estados/maquina_estados_estr/' Modulo_estr.v
	sed -i 's/D0/D0_estr/' Modulo_estr.v
	sed -i 's/D1/D1_estr/' Modulo_estr.v
	sed -i 's/VC0/VC0_estr/' Modulo_estr.v
	sed -i 's/VC1/VC1_estr/' Modulo_estr.v
	sed -i 's/Main/Main_estr/' Modulo_estr.v
	sed -i 's/fifo/fifo_estr/' Modulo_estr.v
	sed -i 's/fifo16/fifo16_estr/' Modulo_estr.v
	sed -i 's/demux_dest/demux_dest_estr/' Modulo_estr.v
	sed -i 's/demux_vc_id/demux_vc_id_estr/' Modulo_estr.v
	sed -i 's/fifo_main_pop/fifo_main_pop_estr/' Modulo_estr.v
	sed -i 's/pop_delay_vc0/pop_delay_vc0_estr/' Modulo_estr.v
	sed -i 's/mux/mux_estr/' Modulo_estr.v

autoinst:
# To use autoinst call make target autoinst as follows:
# make autoinst file=name_of_file

	emacs --batch $(file) -f verilog-batch-auto

.PHONY: all build clean run wave yosys sed autoinst