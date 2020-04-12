#include "exe.h"

EXE::EXE(WIRE* _AluOut, WIRE* _DataIn)
{
    AluOut = _AluOut;
    DataIn = _DataIn;
}

void
EXE::Update(REG _pc, WIRE _busA, WIRE _busB, WIRE _imm, INSTRUCTION _instruction)
{
    pc = _pc;
    busA = _busA;
    busB = _busB;
    imm = _imm;
    instruction = _instruction;
}

void EXE::CtrlLogic()
{
    switch (get_opcode(instruction))
    {
    case 0x33:
    case 0x3b:
        A_sel = A_SEL_BUSA;
        B_sel = B_SEL_BUSB;
        break;
    case 0x03:
    case 0x13:
    case 0x1b:
    case 0x67:
    case 0x23:
        A_sel = A_SEL_BUSA;
        B_sel = B_SEL_IMM;
        break;
    case 0x63:
    case 0x17:
    case 0x37:  // NOTE: AluCtr = PASS, so pc will not be used
    case 0x6f:
        A_sel = A_SEL_PC;
        B_sel = B_SEL_IMM;
        break;
    default:
        A_sel = A_SEL_UNDEF;
        B_sel = B_SEL_UNDEF;
        break;
    }

    switch (get_icode(instruction))
    {
	case ADD:AluCtr = ALU_ADD;break;
	case MUL:AluCtr = ALU_MUL;break;
	case SUB:AluCtr = ALU_SUB;break;
	case SLL:AluCtr = ALU_SLL;break;
	case MULH:AluCtr = ALU_MULH;break;
	case SLT:AluCtr = ALU_SLT;break;
	case XOR:AluCtr = ALU_XOR;break;
	case DIV:AluCtr = ALU_DIV;break;
	case SRL:AluCtr = ALU_SRL;break;
	case SRA:AluCtr = ALU_SRA;break;
	case OR:AluCtr = ALU_OR;break;
	case REM:AluCtr = ALU_REM;break;
	case AND:AluCtr = ALU_AND;break;
	case ADDW:AluCtr = ALU_ADDW;break;
	case MULW:AluCtr = ALU_MULW;break;
	case SUBW:AluCtr = ALU_SUBW;break;
	case SLLW:AluCtr = ALU_SLLW;break;
	case DIVW:AluCtr = ALU_DIVW;break;
	case SRLW:AluCtr = ALU_SRLW;break;
	case DIVUW:AluCtr = ALU_DIVUW;break;
	case SRAW:AluCtr = ALU_SRAW;break;
	case REMW:AluCtr = ALU_REMW;break;
	case REMUW:AluCtr = ALU_REMUW;break;
	case LB:
	case LH:
	case LW:
	case LD:AluCtr = ALU_ADD;break;
	case ADDI:AluCtr = ALU_ADD;break;
	case SLLI:AluCtr = ALU_SLL;break;
	case SLTI:AluCtr = ALU_SLT;break;
	case XORI:AluCtr = ALU_XOR;break;
	case SRLI:AluCtr = ALU_SRL;break;
	case SRAI:AluCtr = ALU_SRA;break;
	case ORI:AluCtr = ALU_OR;break;
	case ANDI:AluCtr = ALU_AND;break;
	case ADDIW:AluCtr = ALU_ADDW;break;
	case SLLIW:AluCtr = ALU_SLLW;break;
	case SRLIW:AluCtr = ALU_SRLW;break;
	case SRAIW:AluCtr = ALU_SRAW;break;
	case JALR:AluCtr = ALU_JALR;break;
	case ECALL:AluCtr = ALU_UNDEF;break;
	case SB:
	case SH:
	case SW:
	case SD:AluCtr = ALU_ADD;break;
    case BEQ:
	case BNE:
	case BLT:
	case BGE:AluCtr = ALU_ADD;break;
    case AUIPC:AluCtr = ALU_ADD;break;
	case LUI:AluCtr = ALU_PASS;break;
    case JAL:AluCtr = ALU_ADD;break;
    case UNDEF:AluCtr = ALU_UNDEF;break;
	default:AluCtr = ALU_UNDEF;break;
	}

    // printf("ASEL:%d,BSEL:%d,ICODE:%d\n",A_sel,B_sel,AluCtr);
}

ERROR_TYPE EXE::Work()
{
    CtrlLogic();

    WIRE A = 0;
    WIRE B = 0;

    switch (A_sel)
    {
    case A_SEL_BUSA:
        A = busA;
        break;
    case A_SEL_PC:
        A = pc;
        break;
    case A_SEL_UNDEF:
        break;
    default:
        break;
    }

    switch (B_sel)
    {
    case B_SEL_BUSB:
        B = busB;
        break;
    case B_SEL_IMM:
        B = imm;
        break;
    case B_SEL_UNDEF:
        break;
    default:
        break;
    }

    // printf("A:%llx,B:%llx\n",A,B);

    *DataIn = busB;

    switch (get_icode(instruction))
    {
    case BEQ:BranchCond = busA == busB;break;
    case BNE:BranchCond = busA != busB;break;
    case BLT:BranchCond = (SREG)busA < (SREG)busB;break;
    case BGE:BranchCond = (SREG)busA >= (SREG)busB;break;
    default:BranchCond = false;break;
    }

    switch (AluCtr)
    {
    case ALU_ADD:
        *AluOut = A + B;
        break;
    case ALU_MUL:
        *AluOut = A * B;
        break;
    case ALU_SUB:
        *AluOut = A - B;
        break;
    case ALU_SLL:
        *AluOut = A << (B & 0x3f);
        break;
    case ALU_MULH:
        *AluOut = 0;
        break;
    case ALU_SLT:
        *AluOut = WIRE((SREG)A < (SREG)B ? 1 : 0);
        break;
    case ALU_XOR:
        *AluOut = A ^ B;
        break;
    case ALU_DIV:
        *AluOut = (WIRE)((SREG)A / (SREG)B);
        break;
    case ALU_SRL:
        *AluOut = A >> (B & 0x3f);
        break;
    case ALU_SRA:
        *AluOut = (WIRE)((SREG)A >> (B & 0x3f));
        break;
    case ALU_OR:
        *AluOut = A | B;
        break;
    case ALU_REM:
        *AluOut = (WIRE)((SREG)A % (SREG)B);
        break;
    case ALU_AND:
        *AluOut = A & B;
        break;
    case ALU_ADDW:
        *AluOut = SignExt((REG)((int)A + (int)B),32);
        break;
    case ALU_MULW:
        *AluOut = SignExt((REG)((int)A * (int)B),32);
        break;
    case ALU_SUBW:
        *AluOut = SignExt((REG)((int)A - (int)B),32);
        break;
    case ALU_SLLW:
        *AluOut = SignExt((A << (B & 0x1f)) & 0xffffffff,32);
        break;
    case ALU_DIVW:
        *AluOut = SignExt((REG)((int)A / (int)B),32);
        break;
    case ALU_SRLW:
        *AluOut = SignExt(A >> (B & 0x1f),32);
        break;
    case ALU_DIVUW:
        *AluOut = SignExt((REG)((unsigned int)A / (unsigned int)B),32);
        break;
    case ALU_SRAW:
        *AluOut = SignExt((REG)((SREG)A >> (B & 0x1f)),32);
        break;
    case ALU_REMW:
        *AluOut = SignExt((REG)((int)A % (int)B),32);
        break;
    case ALU_REMUW:
        *AluOut = SignExt((REG)((unsigned int)A % (unsigned int)B),32);
        break;
    case ALU_PASS:
        *AluOut = B;
        break;
    case ALU_JALR:
        *AluOut = (REG)(((SREG)A + (SREG)B) & (SREG)(~1));
        break;
    case ALU_UNDEF:
        *AluOut = 0;
        break;
    default:
        break;
    }

    return NO_ERROR;
}

WIRE EXE::GetNextPc()
{
    switch (get_opcode(instruction))
    {
    case 0x67:return *AluOut;
    case 0x6f:return *AluOut;
    case 0x63:
        if(BranchCond)
            return *AluOut;
        else
            return pc + 4;
        break;
    default:return pc + 4;
    }
    return pc + 4;
}