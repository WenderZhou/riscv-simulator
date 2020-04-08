#ifndef SIMULATOR_H
#define SIMULATOR_H

#include "utils.h"
#include "def.h"

#define MEMORY_SIZE 100000000

class Simulator
{
public:
    Simulator();
    ~Simulator();
    void Run();
    REG GetReg(int idx);
    BYTE ReadMemory(ADDR addr);
    
private:
    ERROR_TYPE OneInstruction_R(INSTRUCTION instruction);
    ERROR_TYPE OneInstruction_I(INSTRUCTION instruction);
    ERROR_TYPE OneInstruction_S(INSTRUCTION instruction);
    ERROR_TYPE OneInstruction_B(INSTRUCTION instruction);
    ERROR_TYPE OneInstruction_U(INSTRUCTION instruction);
    ERROR_TYPE OneInstruction_J(INSTRUCTION instruction);
    ERROR_TYPE OneInstruction();
    INSTRUCTION FetchInstruction();
    char memory[MEMORY_SIZE];
    REG regfile[REGFILE_SIZE];
    REG pc;
    REG nextpc;
};

#endif
