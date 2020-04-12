#ifndef WB_H
#define WB_H

#include "utils.h"
#include "def.h"

class WB
{
public:
    WB(REG* _regfile, WIRE* _busW);

    void Update(REG _pc, WIRE _AluOut, WIRE _DataOut, INSTRUCTION _instruction);
    void CtrlLogic();
    ERROR_TYPE Work();

    REG pc;
    INSTRUCTION instruction;
    
    WIRE* busW;
private:
    REG* regfile;
    REG AluOut;
    REG DataOut;
    WB_SRC_CTRL WbSrc;
    int Rw;
    bool RegWr;
};

#endif