#ifndef DEF_H
#define DEF_H

#define REGFILE_SIZE 32

#define STRANGE_MAGIC_NUMBER 1

typedef unsigned long long REG;
typedef signed long long SREG;
typedef unsigned long long ADDR;

typedef unsigned char BYTE; 
typedef unsigned short HALFWORD;
typedef unsigned int WORD;
typedef unsigned long long DOUBLEWORD;

typedef unsigned int INSTRUCTION;

typedef unsigned long long WIRE;

typedef enum
{
    TYPE_R,
    TYPE_I,
    TYPE_S,
    TYPE_B,
    TYPE_U,
    TYPE_J,
    TYPE_UNDEF
} INSTRUCTION_TYPE;

typedef enum
{
    NO_ERROR,
    HALT,
    ALIGN_ERROR,
    INVALID_INSTRUCTION
} ERROR_TYPE;

typedef enum 
{
    M_UNSIGNED_CHAR,
    M_CHAR,
    M_UNSIGNED_SHORT,
    M_SHORT,
    M_UNSIGNED_INT,
    M_INT,
    M_UNSIGNED_LONG_LONG,
    M_LONG_LONG
} MONITOR_DATA_TYPE;

// control signal
typedef enum
{
    A_SEL_BUSA,
    A_SEL_PC,
    A_SEL_UNDEF
} A_SEL_CTRL;

typedef enum
{
    B_SEL_BUSB,
    B_SEL_IMM,
    B_SEL_UNDEF
} B_SEL_CTRL;

typedef enum
{
    ALU_ADD,
    ALU_MUL,
    ALU_SUB,
    ALU_SLL,
    ALU_MULH,
    ALU_STL,
    ALU_XOR,
    ALU_DIV,
    ALU_SRL,
    ALU_SRA,
    ALU_OR,
    ALU_REM,
    ALU_AND,
    ALU_ADDW,
    ALU_MULW,
    ALU_SUBW,
    ALU_SLLW,
    ALU_DIVW,
    ALU_SRLW,
    ALU_DIVUW,
    ALU_SRAW,
    ALU_REMW,
    ALU_REMUW,
    ALU_UNDEF
} ALU_CTRL;

typedef enum
{
    MEM_R_B,
    MEM_R_H,
    MEM_R_W,
    MEM_R_D,
    MEM_W_B,
    MEM_W_H,
    MEM_W_W,
    MEM_W_D,
    MEM_UNDEF
} MEM_RW_CTRL;

typedef enum
{
    WB_PC_PLUS4,
    WB_ALUOUT,
    WB_DATAOUT,
    WB_UNDEF
} WB_SRC_CTRL;

#endif