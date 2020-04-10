#include "wb.h"

WB::WB(REG* _regfile)
{
    regfile = _regfile;
}

ERROR_TYPE
WB::OneInstruction( WIRE AluOut, WIRE DataOut, 
    WIRE PC_plus4, WB_SRC_CTRL WbSrc, unsigned int Rw, bool RegWr)
{
    WIRE busW = 0;

    switch (WbSrc)
    {
    case WB_PC_PLUS4:
        busW = PC_plus4;
        break;
    case WB_ALUOUT:
        busW = AluOut;
        break;
    case WB_DATAOUT:
        busW = DataOut;
        break;
    case WB_UNDEF:
        break;
    default:
        break;
    }

    if(RegWr)
        regfile[Rw] = busW;

    return NO_ERROR;
}