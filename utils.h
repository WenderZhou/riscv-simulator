#ifndef UTILS_H
#define UTILS_H

#include "def.h"
#include "stdio.h"
#include "string.h"

unsigned int getbit(INSTRUCTION inst,int s,int e);

unsigned int get_opcode(INSTRUCTION instruction);
unsigned int get_rd(INSTRUCTION instruction);
unsigned int get_funct3(INSTRUCTION instruction);
unsigned int get_rs1(INSTRUCTION instruction);
unsigned int get_rs2(INSTRUCTION instruction);
unsigned int get_funct7(INSTRUCTION instruction);
unsigned int get_imm(INSTRUCTION instruction);
INSTRUCTION_TYPE get_type(INSTRUCTION instruction);

REG SignExt(REG value, int length);

ICODE get_icode_R(INSTRUCTION instruction);
ICODE get_icode_I(INSTRUCTION instruction);
ICODE get_icode_S(INSTRUCTION instruction);
ICODE get_icode_B(INSTRUCTION instruction);
ICODE get_icode_U(INSTRUCTION instruction);
ICODE get_icode_J(INSTRUCTION instruction);
ICODE get_icode(INSTRUCTION instruction);

void show(INSTRUCTION instruction);

class MonitorUnit
{
public:
    MonitorUnit(char* _name, MONITOR_DATA_TYPE _dataType, 
                int _start = 0, int _end = 0);
    char name[20];
    unsigned long long vadr;
    int start;
    int end;
    MONITOR_DATA_TYPE dataType;
};

#endif