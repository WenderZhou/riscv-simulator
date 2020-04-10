#ifndef MEM_H
#define MEM_H

#include "utils.h"
#include "def.h"

class MEM
{
public:
    MEM(char* _memory);
    ERROR_TYPE OneInstruction(WIRE DataIn, WIRE* DataOut, MEM_RW_CTRL MemRw, ADDR Adr);
private:
    char* memory;
};

#endif