CFLAGS = -Wall

CC = g++
LD = g++

SIM_C = main.cc\
		simulator.cc\
		utils.cc\
		Read_Elf.cc\
		def.cc

SIM_O = main.o\
		simulator.o\
		utils.o\
		Read_Elf.o\
		def.o

PROGRAM = sim

$(PROGRAM):$(SIM_O)
	$(LD) $^ -o $@

$(SIM_O):$(SIM_C)
	$(CC) $(CFLAGS) -c $^

clean:
	rm *.o

