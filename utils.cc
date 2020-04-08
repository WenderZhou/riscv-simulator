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
		unsigned int u_31_12 = getbit(instruction, 31, 12);
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


void show_R(INSTRUCTION instruction)
{
	unsigned int funct3 = get_funct3(instruction);
	unsigned int funct7 = get_funct7(instruction);
	unsigned int rd = get_rd(instruction);
	unsigned int rs1 = get_rs1(instruction);
	unsigned int rs2 = get_rs2(instruction);
	switch (funct3)
	{
	case 0x0:	// add,mul,sub
		switch (funct7)
		{
		case 0x00:
			printf("add %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		case 0x01:
			printf("mul %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		case 0x20:
			printf("sub %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		default:
			printf("unknown instruction %x\n", instruction);
			break;
		}
		break;
	case 0x1:	// sll,mulh
		switch (funct7)
		{
		case 0x00:
			printf("sll %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		case 0x01:
			printf("mulh %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		default:
			printf("unknown instruction %x\n", instruction);
			break;
		}
		break;
	case 0x2:	//slt
		switch (funct7)
		{
		case 0x00:
			printf("slt %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		default:
			printf("unknown instruction %x\n", instruction);
			break;
		}
		break;
	case 0x4:	//xor,div
		switch (funct7)
		{
		case 0x00:
			printf("xor %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		case 0x01:
			printf("div %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		default:
			printf("unknown instruction %x\n", instruction);
			break;
		}
		break;
	case 0x5:	//srl,sra
		switch (funct7)
		{
		case 0x00:
			printf("srl %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		case 0x20:
			printf("sra %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		default:
			printf("unknown instruction %x\n", instruction);
			break;
		}
		break;
	case 0x6:	//or,rem
		switch (funct7)
		{
		case 0x00:
			printf("or %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		case 0x01:
			printf("rem %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		default:
			printf("unknown instruction %x\n", instruction);
			break;
		}
		break;
	case 0x7:	//and
		switch (funct7)
		{
		case 0x00:
			printf("and %s, %s, %s\n", REG_NAME[rd], REG_NAME[rs1], REG_NAME[rs2]);
			break;
		default:
			printf("unknown instruction %x\n", instruction);
			break;
		}
		break;
	default:
		printf("unknown instruction %x\n", instruction);
		break;
	}
}

void show_I(INSTRUCTION instruction)
{
	unsigned int opcode = get_opcode(instruction);
	unsigned int funct3 = get_funct3(instruction);
	unsigned int rd = get_rd(instruction);
	unsigned int rs1 = get_rs1(instruction);
	unsigned int imm = get_imm(instruction);
	switch (opcode)
	{
	case 0x03:	// lb,lh,lw,ld
		switch (funct3)
		{
		case 0x0:
			printf("lb %s, 0x%x(%s)\n", REG_NAME[rd], imm, REG_NAME[rs1]);
			break;
		case 0x1:
			printf("lh %s, 0x%x(%s)\n", REG_NAME[rd], imm, REG_NAME[rs1]);
			break;
		case 0x2:
			printf("lw %s, 0x%x(%s)\n", REG_NAME[rd], imm, REG_NAME[rs1]);
			break;
		case 0x3:
			printf("ld %s, 0x%x(%s)\n", REG_NAME[rd], imm, REG_NAME[rs1]);
			break;
		default:
			printf("unknown instruction %x\n", instruction);
			break;
		}
		break;
	case 0x13:	// addi,slli,slti,xori,srli,srai,ori,andi,addi
		switch (funct3)
		{
		case 0x0:
			printf("addi %s, %s, 0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm);
			break;
		case 0x1:
			if(getbit(instruction,26,31) == 0x00)
				printf("slli %s, %s, 0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm);
			else
				printf("unknown instruction %x\n", instruction);
			break;
		case 0x2:
			printf("slti %s, %s, 0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm);
			break;
		case 0x4:
			printf("xori %s, %s, 0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm);
			break;
		case 0x5:
			if(getbit(instruction,26,31) == 0x00)
				printf("srli %s, %s, 0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm);
			else if(getbit(instruction,26,31) == 0x10)
				printf("srai %s, %s, 0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm);
			else
				printf("unknown instruction %x\n", instruction);
			break;
		case 0x6:
			printf("ori %s, %s, 0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm);
			break;
		case 0x7:
			printf("andi %s, %s, 0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm);
			break;
		default:
			printf("unknown instruction %x\n", instruction);
			break;
		}
		break;
	case 0x1b:
		if(funct3 == 0x0)
			printf("addiw %s, %s, 0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm);
		else
			printf("unknown instruction %x\n", instruction);
		break;
	case 0x67:
		if(funct3 == 0x0)
			printf("jalr %s, %s, 0x%x\n", REG_NAME[rd], REG_NAME[rs1], imm);
		else
			printf("unknown instruction %x\n", instruction);
		break;
	case 0x73:
		if(funct3 == 0x0 && get_funct7(instruction) == 0x000)
			printf("ecall\n");
		else
			printf("unknown instruction %x\n", instruction);
		break;
	default:
		printf("unknown instruction %x\n", instruction);
		break;
	}
}

void show_S(INSTRUCTION instruction)
{
	unsigned int funct3 = get_funct3(instruction);
	unsigned int rs1 = get_rs1(instruction);
	unsigned int rs2 = get_rs2(instruction);
	unsigned int imm = get_imm(instruction);
	switch (funct3)
	{
	case 0x0:
		printf("sb %s, 0x%x(%s)\n", REG_NAME[rs2], imm, REG_NAME[rs1]);
		break;
	case 0x1:
		printf("sh %s, 0x%x(%s)\n", REG_NAME[rs2], imm, REG_NAME[rs1]);
		break;
	case 0x2:
		printf("sw %s, 0x%x(%s)\n", REG_NAME[rs2], imm, REG_NAME[rs1]);
		break;
	case 0x3:
		printf("sd %s, 0x%x(%s)\n", REG_NAME[rs2], imm, REG_NAME[rs1]);
		break;
	default:
		printf("unknown instruction %x\n", instruction);
		break;
	}
}

void show_B(INSTRUCTION instruction)
{
	unsigned int funct3 = get_funct3(instruction);
	unsigned int rs1 = get_rs1(instruction);
	unsigned int rs2 = get_rs2(instruction);
	unsigned int imm = get_imm(instruction);
	switch (funct3)
	{
	case 0x0:
		printf("beq %s, %s, 0x%x\n", REG_NAME[rs1], REG_NAME[rs2], imm);
		break;
	case 0x1:
		printf("bne %s, %s, 0x%x\n", REG_NAME[rs1], REG_NAME[rs2], imm);
		break;
	case 0x4:
		printf("blt %s, %s, 0x%x\n", REG_NAME[rs1], REG_NAME[rs2], imm);
		break;
	case 0x5:
		printf("bge %s, %s, 0x%x\n", REG_NAME[rs1], REG_NAME[rs2], imm);
		break;
	default:
		printf("unknown instruction %x\n", instruction);
		break;
	}
}

void show_U(INSTRUCTION instruction)
{
	unsigned int opcode = get_opcode(instruction);
	unsigned int rd = get_rd(instruction);
	unsigned int imm = get_imm(instruction);
	switch (opcode)
	{
	case 0x17:
		printf("auipc %s, 0x%x\n", REG_NAME[rd], imm);
		break;
	case 0x37:
		printf("lui %s, 0x%x\n", REG_NAME[rd], imm);
		break;
	default:
		printf("unknown instruction %x\n", instruction);
		break;
	}
}

void show_J(INSTRUCTION instruction)
{
	unsigned int rd = get_rd(instruction);
	unsigned int imm = get_imm(instruction);
	printf("jal %s, 0x%x\n", REG_NAME[rd], imm);
}


void show(INSTRUCTION instruction)
{
	INSTRUCTION_TYPE type = get_type(instruction);
	switch (type)
	{
	case TYPE_R:
		show_R(instruction);
		break;
	case TYPE_I:
		show_I(instruction);
		break;
	case TYPE_S:
		show_S(instruction);
		break;
	case TYPE_B:
		show_B(instruction);
		break;
	case TYPE_U:
		show_U(instruction);
		break;
	case TYPE_J:
		show_J(instruction);
		break;
	case TYPE_UNDEF:
		printf("undefined instruction type!\n");
		break;
	}
}