#include "if.h"

IF::IF(char* _memory, INSTRUCTION* _IR, WIRE* _pc)
{
    memory = _memory;
    IR = _IR;
    pc = _pc;
}

void IF::Update(REG* _predPc)
{
    predPc = *_predPc;
    *_predPc = *_predPc + 4;
}

void IF::Work()
{
    *pc = predPc;
    instruction = *(INSTRUCTION*)(memory + *pc);
    *IR = instruction;
}