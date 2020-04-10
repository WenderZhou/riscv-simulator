#ifndef WB_H
#define WB_H

#include "utils.h"
#include "def.h"

class WB
{
public:
    WB(REG* _regfile);
    ERROR_TYPE OneInstruction(  WIRE AluOut, WIRE DataOut, 
                        WIRE PC_plus4, WB_SRC_CTRL WbSrc, 
                        unsigned int Rw, bool RegWr);
private:
    REG* regfile;
};

#endif