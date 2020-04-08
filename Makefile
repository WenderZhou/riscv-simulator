CFLAGS = -Wall

CC = g++
LD = g++

SIM_H = utils.h\
		simulator.h

SIM_C = main.cc\
		simulator.cc\
		utils.cc

SIM_O = main.o\
		simulator.o\
		utils.o

PROGRAM = sim

$(PROGRAM):$(SIM_O)
	$(LD) $^ -o $@

$(SIM_O):$(SIM_C)
	$(CC) $(CFLAGS) -c $^

clean:
	rm *.o

