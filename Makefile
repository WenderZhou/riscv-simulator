CFLAGS = -Wall

CC = g++
LD = g++

SIM_C = main.cc\
		simulator.cc\
		utils.cc\
		Read_Elf.cc\
		pipeline.cc\
		if.cc\
		id.cc\
		exe.cc\
		mem.cc\
		wb.cc

SIM_O = main.o\
		simulator.o\
		utils.o\
		Read_Elf.o\
		pipeline.o\
		if.o\
		id.o\
		exe.o\
		mem.o\
		wb.o

PROGRAM = sim

$(PROGRAM):$(SIM_O)
	$(LD) $^ -o $@

$(SIM_O):$(SIM_C)
	$(CC) $(CFLAGS) -c $^

clean:
	rm *.o

