#ifndef DEF_H
#define DEF_H

#define REGFILE_SIZE 32

#define STRANGE_MAGIC_NUMBER 1

#define MEMORY_SIZE (4 * 1024 * 1024)

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

typedef enum
{
    ADD, MUL, SUB, SLL, MULH,
    SLT, XOR, DIV, SRL, SRA,
    OR, REM, AND, ADDW, MULW,
    SUBW, SLLW, DIVW, SRLW, DIVUW,
    SRAW, REMW, REMUW,
    LB, LH, LW, LD,
    ADDI, SLLI, SLTI, XORI, SRLI,
    SRAI, ORI, ANDI,
    ADDIW, SLLIW, SRLIW, SRAIW,
    JALR, ECALL,
    SB, SH, SW, SD,
    BEQ, BNE, BLT, BGE,
    AUIPC, LUI,
    JAL,
    UNDEF
} ICODE;

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
    ALU_SLT,
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
    ALU_JALR,
    ALU_PASS,
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


typedef enum
{
    STAGE_IF,
    STAGE_ID,
    STAGE_EXE,
    STAGE_MEM,
    STAGE_WB
} PIPELINE_STAGE;

#endif