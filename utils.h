#ifndef UTILS_H
#define UTILS_H

#include "def.h"
#include "stdio.h"

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

void show_R(INSTRUCTION instruction);
void show_I(INSTRUCTION instruction);
void show_S(INSTRUCTION instruction);
void show_B(INSTRUCTION instruction);
void show_U(INSTRUCTION instruction);
void show_J(INSTRUCTION instruction);
void show(INSTRUCTION instruction);

#endif