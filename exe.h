#ifndef EXE_H
#define EXE_H

#include "utils.h"
#include "def.h"

class EXE
{
public:
    ERROR_TYPE OneInstruction(  WIRE busA, WIRE busB, WIRE pc, WIRE imm,
                                INSTRUCTION instruction,
                                bool* AB_equal, WIRE* AluOut);
    void SetCtrl(INSTRUCTION instruction);
private:
    A_SEL_CTRL A_sel;
    B_SEL_CTRL B_sel;
    ALU_CTRL AluCtr;
};

#endif