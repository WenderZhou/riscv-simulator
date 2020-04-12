#include "wb.h"

WB::WB(REG* _regfile, WIRE* _busW)
{
    regfile = _regfile;
    busW = _busW;
}

void
WB::Update(REG _pc, WIRE _AluOut, WIRE _DataOut, INSTRUCTION _instruction)
{
    pc = _pc;
    AluOut = _AluOut;
    DataOut = _DataOut;
    instruction = _instruction;
}

void WB::CtrlLogic()
{
    Rw = get_rd(instruction);

    switch (get_opcode(instruction))
    {
    case 0x67:
    case 0x6f:
        WbSrc = WB_PC_PLUS4;
        RegWr = true;
        break;
    case 0x33:
    case 0x3b:
    case 0x13:
    case 0x1b:
    case 0x17:
    case 0x37:
        WbSrc = WB_ALUOUT;
        RegWr = true;
        break;
    case 0x03:
        WbSrc = WB_DATAOUT;
        RegWr = true;
        break;
    default:
        WbSrc = WB_UNDEF;
        RegWr = false;
        break;
    }
}

ERROR_TYPE WB::Work()
{
    CtrlLogic();

    switch (WbSrc)
    {
    case WB_PC_PLUS4:
        *busW = pc + 4;
        break;
    case WB_ALUOUT:
        *busW = AluOut;
        break;
    case WB_DATAOUT:
        *busW = DataOut;
        break;
    case WB_UNDEF:
        break;
    default:
        break;
    }

    if(RegWr)
        regfile[Rw] = *busW;

    return NO_ERROR;
}