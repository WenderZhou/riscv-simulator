#ifndef IF_H
#define IF_H

#include "utils.h"
#include "def.h"

class IF
{
public:
    IF(char* _memory, INSTRUCTION* _IR, WIRE* _pc);
    void Update(REG* _predPc);
    void Work();
    
private:
    INSTRUCTION instruction;
    
    char* memory;
    INSTRUCTION* IR;
    WIRE* pc;
    REG predPc;
};

#endif