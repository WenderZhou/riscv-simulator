#ifndef ID_H
#define ID_H

#include "utils.h"
#include "def.h"

class ID
{
public:
    ID(REG* _regfile, WIRE* _busA, WIRE* _busB, WIRE* _imm);
    void Update(WIRE _pc, INSTRUCTION _instruction);
    void extend();
    void Work();
    void ForwardA(WIRE A);
    void ForwardB(WIRE B);

    REG pc;
    INSTRUCTION instruction;
    unsigned int Ra;
    unsigned int Rb;
private:
    REG* regfile;
    WIRE* busA;
    WIRE* busB;
    WIRE* imm;
};

#endif