#ifndef DEF_H
#define DEF_H

#define REGFILE_SIZE 32

typedef unsigned long long REG;
typedef signed long long SREG;
typedef unsigned long long ADDR;

typedef unsigned char BYTE; 
typedef unsigned short HALFWORD;
typedef unsigned int WORD;
typedef unsigned long long DOUBLEWORD;

typedef unsigned int INSTRUCTION;

enum INSTRUCTION_TYPE
{ TYPE_R, TYPE_I, TYPE_S, TYPE_B, TYPE_U, TYPE_J, TYPE_UNDEF };

enum ERROR_TYPE
{ NO_ERROR, ALIGN_ERROR, INVALID_INSTRUCTION };

#endif