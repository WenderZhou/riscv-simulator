#include "if.h"

// #define ALWAYS_TAKE
// #define ALWAYS_NTAKE
#define BTFNT

IF::IF(char* _memory, INSTRUCTION* _IR, WIRE* _pc)
{
    memory = _memory;
    IR = _IR;
    pc = _pc;
}

void IF::Update(REG* _predPc)
{
    predPc = *_predPc;
    // *_predPc = *_predPc + 4;
    INSTRUCTION temp = *(INSTRUCTION*)(memory + predPc);
    switch (get_icode(temp))
    {
    case JAL:
        *_predPc = *_predPc + SignExt(get_imm(temp),21);
#ifdef ALWAYS_NTAKE
        *_predPc = *_predPc + 4;
#endif
        break;
    case BEQ:
    case BNE:
    case BLT:
    case BGE:
#ifdef ALWAYS_TAKE
        *_predPc = *_predPc + SignExt(get_imm(temp),13);
#endif
#ifdef ALWAYS_NTAKE
        *_predPc = *_predPc + 4;
#endif
#ifdef BTFNT
        if((SREG)SignExt(get_imm(temp),13) < 0)
            *_predPc = *_predPc + SignExt(get_imm(temp),13);   
        else
            *_predPc = *_predPc + 4;
#endif
        break;
    default:
        *_predPc = *_predPc + 4;
        break;
    }
}

void IF::Work()
{
    *pc = predPc;
    instruction = *(INSTRUCTION*)(memory + *pc);
    *IR = instruction;
}