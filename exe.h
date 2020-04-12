#ifndef EXE_H
#define EXE_H

#include "utils.h"
#include "def.h"

class EXE
{
public:
    EXE(WIRE* _AluOut, WIRE* _DataIn);
    void Update(REG _pc, WIRE _busA, WIRE _busB, WIRE _imm, INSTRUCTION _instruction);
    ERROR_TYPE Work();
    void CtrlLogic();
    WIRE GetNextPc();

    REG pc;
    INSTRUCTION instruction;

private:
    REG busA;
    REG busB;
    REG imm;

    WIRE* AluOut;
    WIRE* DataIn;
    bool BranchCond;

    A_SEL_CTRL A_sel;
    B_SEL_CTRL B_sel;
    ALU_CTRL AluCtr;
};

#endif