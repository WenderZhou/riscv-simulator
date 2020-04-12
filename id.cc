#include "id.h"

ID::ID(REG* _regfile, WIRE* _busA, WIRE* _busB, WIRE* _imm)
{
    regfile = _regfile;
    busA = _busA;
    busB = _busB;
    imm = _imm;
}

void ID::Update(WIRE _pc, INSTRUCTION _instruction)
{
    pc = _pc;
    instruction = _instruction;
}

void ID::extend()
{
    switch (get_type(instruction))
    {
    case TYPE_R:*imm = 0;break;
    case TYPE_I:*imm = SignExt(*imm,12);break;
    case TYPE_S:*imm = SignExt(*imm,12);break;
    case TYPE_B:*imm = SignExt(*imm,13);break;
    case TYPE_U:*imm = SignExt(*imm,32);break;
    case TYPE_J:*imm = SignExt(*imm,21);break;
    default:break;
    }
}

void ID::Work()
{
    Ra = get_rs1(instruction);
    Rb = get_rs2(instruction);

    *busA = regfile[Ra];
    *busB = regfile[Rb];
    *imm = get_imm(instruction);

    extend();
}

void ID::ForwardA(WIRE A)
{
    *busA = A;
}

void ID::ForwardB(WIRE B)
{
    *busB = B;
}
