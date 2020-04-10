#include "mem.h"

MEM::MEM(char* _memory)
{
    memory = _memory;
}

ERROR_TYPE MEM::OneInstruction(WIRE DataIn, WIRE* DataOut, MEM_RW_CTRL MemRw, ADDR Adr)
{
    switch (MemRw)
    {
    case MEM_R_B:
        *DataOut = SignExt((REG)(*(BYTE*)(memory + Adr)),8);
        break;
    case MEM_R_H:
        if(Adr % 2 != 0)
            return ALIGN_ERROR;
        *DataOut = SignExt((REG)(*(HALFWORD*)(memory + Adr)),16);
        break;
    case MEM_R_W:
        if(Adr % 4 != 0)
            return ALIGN_ERROR;
        *DataOut = SignExt((REG)(*(WORD*)(memory + Adr)),32);
        break;
    case MEM_R_D:
        if(Adr % 8 != 0)
            return ALIGN_ERROR;
        *DataOut = SignExt((REG)(*(DOUBLEWORD*)(memory + Adr)),64);
        break;
    case MEM_W_B:
        *(BYTE*)(memory + Adr) = (BYTE)DataIn;
        break;
    case MEM_W_H:
        if(Adr % 2 != 0)
            return ALIGN_ERROR;
        *(HALFWORD*)(memory + Adr) = (HALFWORD)DataIn;
        break;
    case MEM_W_W:
        if(Adr % 4 != 0)
            return ALIGN_ERROR;
        *(WORD*)(memory + Adr) = (WORD)DataIn;
        break;
    case MEM_W_D:
        if(Adr % 8 != 0)
            return ALIGN_ERROR;
        *(DOUBLEWORD*)(memory + Adr) = (DOUBLEWORD)DataIn;
        break;
    case MEM_UNDEF:
        break;
    default:
        break;
    }
    return NO_ERROR;
}