#ifndef MEM_H
#define MEM_H

#include "utils.h"
#include "def.h"

class MEM
{
public:
    MEM(char* _memory, WIRE* _DataOut);
    void Update(REG _pc, WIRE _AluOut, WIRE _DataIn, INSTRUCTION _instruction);
    void CtrlLogic();
    ERROR_TYPE Work();

    REG pc;
    INSTRUCTION instruction;
    REG AluOut;

private:
    char* memory;
    WIRE* DataOut;
    REG DataIn;
    MEM_RW_CTRL MemRw;
    ADDR Adr;
};

#endif