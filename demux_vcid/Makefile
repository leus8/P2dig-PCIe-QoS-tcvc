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
	gtkwave $(DUMPDIR)/demux_vcid.vcd

yosys:

	yosys -s ./ys/demux_vc_id.ys
	
sed:
	sed -i 's/module demux_vc_id/module demux_vc_id_estr/' demux_vc_id_estr.v

autoinst:
# To use autoinst call make target autoinst as follows:
# make autoinst file=name_of_file

	emacs --batch $(file) -f verilog-batch-auto

.PHONY: all build clean run wave yosys sed autoinst