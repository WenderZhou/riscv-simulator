#include "exe.h"

ERROR_TYPE
EXE::OneInstruction(  WIRE busA, WIRE busB, WIRE pc, WIRE imm,
                    INSTRUCTION instruction,
                    bool* AB_equal, WIRE* AluOut)
{
    SetCtrl(instruction);

    WIRE A = 0;
    WIRE B = 0;

    switch (A_sel)
    {
    case A_SEL_BUSA:
        A = busA;
        break;
    case A_SEL_PC:
        A = pc;
        break;
    case A_SEL_UNDEF:
        break;
    default:
        break;
    }

    switch (B_sel)
    {
    case B_SEL_BUSB:
        B = busB;
        break;
    case B_SEL_IMM:
        B = imm;
        break;
    case B_SEL_UNDEF:
        break;
    default:
        break;
    }

    *AB_equal = A == B;

    switch (AluCtr)
    {
    case ALU_ADD:
        *AluOut = A + B;
        break;
    case ALU_MUL:
        *AluOut = A * B;
        break;
    case ALU_SUB:
        *AluOut = A - B;
        break;
    case ALU_SLL:
        *AluOut = A << (B & 0x3f);
        break;
    case ALU_MULH:
        *AluOut = 0;
        break;
    case ALU_STL:
        *AluOut = WIRE((SREG)A < (SREG)B ? 1 : 0);
        break;
    case ALU_XOR:
        *AluOut = A ^ B;
        break;
    case ALU_DIV:
        *AluOut = (WIRE)((SREG)A / (SREG)B);
        break;
    case ALU_SRL:
        *AluOut = A >> (B & 0x3f);
        break;
    case ALU_SRA:
        *AluOut = (WIRE)((SREG)A >> (B & 0x3f));
        break;
    case ALU_OR:
        *AluOut = A | B;
        break;
    case ALU_REM:
        *AluOut = (WIRE)((SREG)A % (SREG)B);
        break;
    case ALU_AND:
        *AluOut = A & B;
        break;
    case ALU_ADDW:
        *AluOut = SignExt((REG)((int)A + (int)B),32);
        break;
    case ALU_MULW:
        *AluOut = SignExt((REG)((int)A * (int)B),32);
        break;
    case ALU_SUBW:
        *AluOut = SignExt((REG)((int)A - (int)B),32);
        break;
    case ALU_SLLW:
        *AluOut = SignExt((A << (B & 0x1f)) & 0xffffffff,32);
        break;
    case ALU_DIVW:
        *AluOut = SignExt((REG)((int)A / (int)B),32);
        break;
    case ALU_SRLW:
        *AluOut = SignExt(A >> (B & 0x1f),32);
        break;
    case ALU_DIVUW:
        *AluOut = SignExt((REG)((unsigned int)A / (unsigned int)B),32);
        break;
    case ALU_SRAW:
        *AluOut = SignExt((REG)((SREG)A >> (B & 0x1f)),32);
        break;
    case ALU_REMW:
        *AluOut = SignExt((REG)((int)A % (int)B),32);
        break;
    case ALU_REMUW:
        *AluOut = SignExt((REG)((unsigned int)A % (unsigned int)B),32);
        break;
    case ALU_UNDEF:
        *AluOut = 0;
        break;
    default:
        break;
    }

    return NO_ERROR;
}