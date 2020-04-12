#include "utils.h"

static char REG_NAME[32][5]
{
    "zero","ra","sp","gp","tp",
    "t0","t1","t2","s0","s1",
    "a0","a1","a2","a3","a4",
    "a5","a6","a7","s2","s3",
    "s4","s5","s6","s7","s8",
    "s9","s10","s11","t3","t4",
    "t5","t6"
};

unsigned int getbit(INSTRUCTION inst,int s,int e)
{
	return (inst << (31 - e)) >> (31 - e + s);
}

unsigned int get_opcode(INSTRUCTION instruction)
{
	return getbit(instruction, 0, 6);
}

unsigned int get_rd(INSTRUCTION instruction)
{
	return getbit(instruction, 7, 11);
}

unsigned int get_funct3(INSTRUCTION instruction)
{
	return getbit(instruction, 12, 14);
}

unsigned int get_rs1(INSTRUCTION instruction)
{
	return getbit(instruction, 15, 19);
}

unsigned int get_rs2(INSTRUCTION instruction)
{
	return getbit(instruction, 20, 24);
}

unsigned int get_funct7(INSTRUCTION instruction)
{
	return getbit(instruction, 25, 31);
}

INSTRUCTION_TYPE get_type(INSTRUCTION instruction)
{
	unsigned int opcode = get_opcode(instruction);
	switch (opcode)
	{
		case 0x33:
		case 0x3b:
			return TYPE_R;
		case 0x03:
		case 0x13:
		case 0x1b:
		case 0x67:
		case 0x73:
			return TYPE_I;
		case 0x23:
			return TYPE_S;
		case 0x63:
			return TYPE_B;
		case 0x17:
		case 0x37:
			return TYPE_U;
		case 0x6f:
			return TYPE_J;
		default:
			return TYPE_UNDEF;
	}
	return TYPE_UNDEF;
}

unsigned int get_Rw(INSTRUCTION instruction)
{
	switch (get_opcode(instruction))
	{
	case 0x33:
	case 0x3b:
	case 0x03:
	case 0x13:
	case 0x1b:
	case 0x67:
	case 0x17:
	case 0x37:
	case 0x6f:
		return get_rd(instruction);
	default:
		// so that can not match anything
		return REGFILE_SIZE;
	}
}

WB_SRC_CTRL get_WbSrc(INSTRUCTION instruction)
{
	switch (get_opcode(instruction))
    {
    case 0x67:
    case 0x6f:
        return WB_PC_PLUS4;
    case 0x33:
    case 0x3b:
    case 0x13:
    case 0x1b:
    case 0x17:
    case 0x37:
        return WB_ALUOUT;
    case 0x03:
        return WB_DATAOUT;
    default:
        return WB_UNDEF;
    }
}


REG SignExt(REG value, int length)
{
	return (REG)((SREG)value << (64 - length) >> (64 - length));
}

unsigned int get_imm(INSTRUCTION instruction)
{
	INSTRUCTION_TYPE type = get_type(instruction);
	switch (type)
	{
	case TYPE_R:
		return -1;
	case TYPE_I:
		return getbit(instruction, 20, 31);
	case TYPE_S:
		{
		unsigned int s_11_5 = getbit(instruction, 25, 31);
		unsigned int s_4_0 = getbit(instruction, 7, 11);
		return (s_11_5 << 5) | s_4_0;
		}
	case TYPE_B:
		{
		unsigned int b_12 = getbit(instruction, 31, 31);
		unsigned int b_10_5 = getbit(instruction, 25, 30);
		unsigned int b_4_1 = getbit(instruction, 8, 11);
		unsigned int b_11 = getbit(instruction, 7, 7);
		return (b_12 << 12) | (b_11 << 11) | (b_10_5 << 5) | (b_4_1 << 1);
		}
	case TYPE_U:
		{
		unsigned int u_31_12 = getbit(instruction, 12, 31);
		return u_31_12 << 12;
		}
	case TYPE_J:
		{
		unsigned int j_20 = getbit(instruction, 31, 31);
		unsigned int j_10_1 = getbit(instruction, 21, 30);
		unsigned int j_11 = getbit(instruction, 20, 20);
		unsigned int j_19_12 = getbit(instruction, 12, 19);
		return (j_20 << 20) | (j_19_12 << 12) | (j_11 << 11) | (j_10_1 << 1);
		}
	case TYPE_UNDEF:
		return -1;
	}
	return -1;
}


ICODE get_icode_R(INSTRUCTION instruction)
{
	unsigned int opcode = get_opcode(instruction);
	unsigned int funct3 = get_funct3(instruction);
	unsigned int funct7 = get_funct7(instruction);
	switch (opcode)
	{
	case 0x33:
		switch (funct3)
		{
		case 0x0:	// add,mul,sub
			switch (funct7)
			{
			case 0x00:return ADD;
			case 0x01:return MUL;
			case 0x20:return SUB;
			default:return UNDEF;
			}
			break;
		case 0x1:	// sll,mulh
			switch (funct7)
			{
			case 0x00:return SLL;
			case 0x01:return MULH;
			default:return UNDEF;
			}
			break;
		case 0x2:	// slt
			switch (funct7)
			{
			case 0x00:return SLT;
			default:return UNDEF;
			}
			break;
		case 0x4:	// xor,div
			switch (funct7)
			{
			case 0x00:return XOR;
			case 0x01:return DIV;
			default:return UNDEF;
			}
			break;
		case 0x5:	// srl,sra
			switch (funct7)
			{
			case 0x00:return SRL;
			case 0x20:return SRA;
			default:return UNDEF;
			}
			break;
		case 0x6:	// or,rem
			switch (funct7)
			{
			case 0x00:return OR;
			case 0x01:return REM;
			default:
				return UNDEF;
			}
			break;
		case 0x7:	// and
			switch (funct7)
			{
			case 0x00:return AND;
			default:return UNDEF;
			}
			break;
		default:
			return UNDEF;
		}
		break;
	case 0x3b:
		switch (funct3)
		{
		case 0x0:	// addw,mulw,subw
			switch (funct7)
			{
			case 0x00:return ADDW;
			case 0x01:return MULW;
			case 0x20:return SUBW;
			default:return UNDEF;
			}
			break;
		case 0x1:	// sllw
			switch (funct7)
			{
			case 0x00:return SLLW;
			default:return UNDEF;
			}
			break;
		case 0x4:	// divw
			switch (funct7)
			{
			case 0x01:return DIVW;
			default:return UNDEF;
			}
			break;
		case 0x5:	// srlw,divuw,sraw
			switch (funct7)
			{
			case 0x00:return SRLW;
			case 0x01:return DIVUW;
			case 0x20:return SRAW;
			default:return UNDEF;
			}
			break;
		case 0x6:	// remw
			switch (funct7)
			{
			case 0x01:return REMW;
			default:return UNDEF;
			}
			break;
		case 0x7:	// remuw
			switch (funct7)
			{
			case 0x01:return REMUW;
			default:return UNDEF;
			}
			break;
		default:
			return UNDEF;
		}
		break;
	default:
		return UNDEF;
	}
}

ICODE get_icode_I(INSTRUCTION instruction)
{
	unsigned int opcode = get_opcode(instruction);
	unsigned int funct3 = get_funct3(instruction);
	switch (opcode)
	{
	case 0x03:	// lb,lh,lw,ld
		switch (funct3)
		{
		case 0x0:return LB;
		case 0x1:return LH;
		case 0x2:return LW;
		case 0x3:return LD;
		default:return UNDEF;
		}
		break;
	case 0x13:	// addi,slli,slti,xori,srli,srai,ori,andi
		switch (funct3)
		{
		case 0x0:return ADDI;
		case 0x1:
			if(getbit(instruction,26,31) == 0x00)
				return SLLI;
			else
				return UNDEF;
		case 0x2:return SLTI;
		case 0x4:return XORI;
		case 0x5:
			if(getbit(instruction,26,31) == 0x00)
				return SRLI;
			else if(getbit(instruction,26,31) == 0x10)
				return SRAI;
			else
				return UNDEF;
		case 0x6:return ORI;
		case 0x7:return ANDI;
		default:return UNDEF;
		}
		break;
	case 0x1b:
		switch(funct3)
		{
			case 0x0:return ADDIW;
			case 0x1:
				if(get_funct7(instruction) == 0)
					return SLLIW;
				else
					return UNDEF;
			case 0x5:
				switch (get_funct7(instruction))
				{
				case 0x00:
					return SRLIW;
				case 0x20:return SRAIW;
				default:return UNDEF;
				}
				break;
			default:return UNDEF;
		}
		break;
	case 0x67:
		if(funct3 == 0x0)
			return JALR;
		else
			return UNDEF;
	case 0x73:
		if(funct3 == 0x0 && get_funct7(instruction) == 0x000)
			return ECALL;
		else
			return UNDEF;
	default:
		return UNDEF;
	}
}

ICODE get_icode_S(INSTRUCTION instruction)
{
	unsigned int funct3 = get_funct3(instruction);
	switch (funct3)
	{
	case 0x0:return SB;
	case 0x1:return SH;
	case 0x2:return SW;
	case 0x3:return SD;
	default:return UNDEF;
	}
}

ICODE get_icode_B(INSTRUCTION instruction)
{
	unsigned int funct3 = get_funct3(instruction);
	switch (funct3)
	{
	case 0x0:return BEQ;
	case 0x1:return BNE;
	case 0x4:return BLT;
	case 0x5:return BGE;
	default:return UNDEF;
	}
}

ICODE get_icode_U(INSTRUCTION instruction)
{
	unsigned int opcode = get_opcode(instruction);
	switch (opcode)
	{
	case 0x17:return AUIPC;
	case 0x37:return LUI;
	default:
		printf("unknown instruction %x\n", instruction);
		return UNDEF;
	}
}

ICODE get_icode_J(INSTRUCTION instruction)
{
	return JAL;
}


ICODE get_icode(INSTRUCTION instruction)
{
	INSTRUCTION_TYPE type = get_type(instruction);
	switch (type)
	{
	case TYPE_R:
		return get_icode_R(instruction);
	case TYPE_I:
		return get_icode_I(instruction);
	case TYPE_S:
		return get_icode_S(instruction);
	case TYPE_B:
		return get_icode_B(instruction);
	case TYPE_U:
		return get_icode_U(instruction);
	case TYPE_J:
		return get_icode_J(instruction);
	case TYPE_UNDEF:
		return UNDEF;
	}
	return UNDEF;
}

MonitorUnit::MonitorUnit(char* _name, MONITOR_DATA_TYPE _dataType,
            int _start, int _end)
{
    memset(name,0,sizeof(name));
    memcpy(name,_name,strlen(_name));
    dataType = _dataType;
    start = _start;
    end = _end;
}

void show(INSTRUCTION instruction)
{
	unsigned int rd = get_rd(instruction);
	unsigned int rs1 = get_rs1(instruction);
	unsigned int rs2 = get_rs2(instruction);
	unsigned int imm = get_imm(instruction);

	ICODE icode = get_icode(instruction);

	switch (icode)
	{
	case ADD:
		printf("add	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case MUL:
		printf("mul	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case SUB:
		printf("sub	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case SLL:
		printf("sll	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case MULH:
		printf("mulh	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case SLT:
		printf("slt	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case XOR:
		printf("xor	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case DIV:
		printf("div	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case SRL:
		printf("srl	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case SRA:
		printf("sra	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case OR:
		printf("or	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case REM:
		printf("rem	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case AND:
		printf("and	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case ADDW:
		printf("addw	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case MULW:
		printf("mulw	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case SUBW:
		printf("subw	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case SLLW:
		printf("sllw	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case DIVW:
		printf("divw	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case SRLW:
		printf("srlw	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case DIVUW:
		printf("divuw	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case SRAW:
		printf("sraw	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case REMW:
		printf("remw	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case REMUW:
		printf("remuw	%s,%s,%s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
		break;
	case LB:
		printf("lb	%s,%lld(%s)\n", REG_NAME[rd], (long long)SignExt(imm,12), REG_NAME[rs1]);
		break;
	case LH:
		printf("lh	%s,%lld(%s)\n", REG_NAME[rd], (long long)SignExt(imm,12), REG_NAME[rs1]);
		break;
	case LW:
		printf("lw	%s,%lld(%s)\n", REG_NAME[rd], (long long)SignExt(imm,12), REG_NAME[rs1]);
		break;
	case LD:
		printf("ld	%s,%lld(%s)\n", REG_NAME[rd], (long long)SignExt(imm,12), REG_NAME[rs1]);
		break;
	case ADDI:
		printf("addi	%s,%s,%lld\n", REG_NAME[rd], REG_NAME[rs1], (long long)SignExt(imm,12));
		break;
	case SLLI:
		printf("slli	%s,%s,0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm & 0x3f);
		break;
	case SLTI:
		printf("slti	%s,%s,%lld\n", REG_NAME[rd], REG_NAME[rs1], (long long)SignExt(imm,12));
		break;
	case XORI:
		printf("slti	%s,%s,%lld\n", REG_NAME[rd], REG_NAME[rs1], (long long)SignExt(imm,12));
		break;
	case SRLI:
		printf("srli	%s,%s, 0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm & 0x3f);
		break;
	case SRAI:
		printf("srai	%s,%s, 0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm & 0x3f);
		break;
	case ORI:
		printf("ori	%s,%s,%lld\n", REG_NAME[rd], REG_NAME[rs1], (long long)SignExt(imm,12));
		break;
	case ANDI:
		printf("andi	%s,%s,%lld\n", REG_NAME[rd], REG_NAME[rs1], (long long)SignExt(imm,12));
		break;
	case ADDIW:
		printf("addiw	%s,%s,%lld\n", REG_NAME[rd], REG_NAME[rs1], (long long)SignExt(imm,12));
		break;
	case SLLIW:
		printf("slliw	%s,%s,%lld\n", REG_NAME[rd], REG_NAME[rs1], (long long)SignExt(imm,12));
		break;
	case SRLIW:
		printf("srliw	%s,%s,%lld\n", REG_NAME[rd], REG_NAME[rs1], (long long)SignExt(imm,12));
		break;
	case SRAIW:
		printf("sraiw	%s,%s,%lld\n", REG_NAME[rd], REG_NAME[rs1], (long long)SignExt(imm,12));
		break;
	case JALR:
		printf("jalr	%s,%s,%lld\n", REG_NAME[rd], REG_NAME[rs1], (long long)SignExt(imm,12));
		break;
	case ECALL:
		printf("ecall\n");
		break;
	case SB:
		printf("sb	%s,%lld(%s)\n", REG_NAME[rs2], (long long)SignExt(imm,12), REG_NAME[rs1]);
		break;
	case SH:
		printf("sh	%s,%lld(%s)\n", REG_NAME[rs2], (long long)SignExt(imm,12), REG_NAME[rs1]);
		break;
	case SW:
		printf("sw	%s,%lld(%s)\n", REG_NAME[rs2], (long long)SignExt(imm,12), REG_NAME[rs1]);
		break;
	case SD:
		printf("sd	%s,%lld(%s)\n", REG_NAME[rs2], (long long)SignExt(imm,12), REG_NAME[rs1]);
		break;
    case BEQ:
		printf("beq	%s,%s,%lld\n", REG_NAME[rs1], REG_NAME[rs2], (long long)SignExt(imm, 13));
		break;
	case BNE:
		printf("bne	%s,%s,%lld\n", REG_NAME[rs1], REG_NAME[rs2], (long long)SignExt(imm, 13));
		break;
	case BLT:
		printf("blt	%s,%s,%lld\n", REG_NAME[rs1], REG_NAME[rs2], (long long)SignExt(imm, 13));
		break;
	case BGE:
		printf("bge	%s,%s,%lld\n", REG_NAME[rs1], REG_NAME[rs2], (long long)SignExt(imm, 13));
		break;
    case AUIPC:
		printf("auipc	%s,0x%llx\n", REG_NAME[rd], SignExt(imm >> 12, 20));
		break;
	case LUI:
		printf("lui	%s, 0x%llx\n", REG_NAME[rd], SignExt(imm >> 12, 20));
		break;
    case JAL:
		printf("jal	%s,0x%x\n", REG_NAME[rd], imm);
		break;
    case UNDEF:
		printf("unknown instruction %x\n", instruction);
		break;
	default:
		break;
	}
}