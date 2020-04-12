#include "mem.h"

MEM::MEM(char* _memory, WIRE* _DataOut)
{
    memory = _memory;
    DataOut = _DataOut;
}

void MEM::Update(REG _pc, WIRE _AluOut, WIRE _DataIn, INSTRUCTION _instruction)
{
    pc = _pc;
    AluOut = _AluOut;
    DataIn = _DataIn;
    instruction = _instruction;
}

void MEM::CtrlLogic()
{
    Adr = AluOut;
    switch (get_opcode(instruction))
    {
    case 0x03:
        switch (get_funct3(instruction))
        {
        case 0x0:MemRw = MEM_R_B;break;
        case 0x1:MemRw = MEM_R_H;break;
        case 0x2:MemRw = MEM_R_W;break;
        case 0x3:MemRw = MEM_R_D;break;
        default:MemRw = MEM_UNDEF;break;
        }
        break;
    case 0x23:
        switch (get_funct3(instruction))
        {
        case 0x0:MemRw = MEM_W_B;break;
        case 0x1:MemRw = MEM_W_H;break;
        case 0x2:MemRw = MEM_W_W;break;
        case 0x3:MemRw = MEM_W_D;break;
        default:MemRw = MEM_UNDEF;break;
        }
        break;
    default:
        MemRw = MEM_UNDEF;
        break;
    }
}

ERROR_TYPE MEM::Work()
{
    CtrlLogic();

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
        printf("!!Adr:%llx\n",Adr);
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