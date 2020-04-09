#include "simulator.h"
#include "stdio.h"
#include "cstring"

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

Simulator::Simulator()
{
    memset(memory, 0, sizeof(memory));
    memset(regfile, 0, sizeof(regfile));
    pc = 0;
    nextpc = 0;
    // *(INSTRUCTION*)memory = 0x00800513;
    // *(INSTRUCTION*)(memory + 4) = 0x00852583;
    // *(INSTRUCTION*)(memory + 8) = 0x40a58633;
    // *(INSTRUCTION*)(memory + 16) = 20;
}

Simulator::~Simulator()
{
	delete elfReader;
}

ERROR_TYPE Simulator::OneInstruction()
{
    ERROR_TYPE error = NO_ERROR;
    INSTRUCTION instruction = FetchInstruction();

	if(pc == elfReader->mend)
		return HALT;

    show(instruction);

    INSTRUCTION_TYPE type = get_type(instruction);
    switch (type)
	{
	case TYPE_R:
		error = OneInstruction_R(instruction);
		break;
	case TYPE_I:
		error = OneInstruction_I(instruction);
		break;
	case TYPE_S:
		error = OneInstruction_S(instruction);
		break;
	case TYPE_B:
		error = OneInstruction_B(instruction);
		break;
	case TYPE_U:
		error = OneInstruction_U(instruction);
		break;
	case TYPE_J:
		error = OneInstruction_J(instruction);
		break;
	case TYPE_UNDEF:
		error = INVALID_INSTRUCTION;
		break;
	}
    return error;
}

void Simulator::load(char* filename)
{
	FILE* file = fopen(filename,"r");
	if(file == NULL)
	{
		printf("file can not open!\n");
		return;
	}

	fseek(file, elfReader->cadr, SEEK_SET);
	fread(memory + elfReader->cvadr, 1, elfReader->csize, file);
	fseek(file, elfReader->dadr, SEEK_SET);
	fread(memory + elfReader->dvadr, 1, elfReader->dsize, file);

	fclose(file);
}

void Simulator::Run(char* filename, bool singleStep)
{
	elfReader = new ElfReader(monitorTable, monitorCnt);
	elfReader->read_elf(filename);

	load(filename);
    
	nextpc = elfReader->madr;

	regfile[2] = MEMORY_SIZE - 10000;
	regfile[3] = elfReader->gp;

	char cmd = 0;

	if(singleStep)
	{
		while(true)
		{
			regfile[0] = 0;
			scanf("%c\n",&cmd);
			if(cmd == 'c')
			{
				ERROR_TYPE error = OneInstruction();
				if(error != NO_ERROR)
					return;
			}
			else if(cmd == 'v')
			{
				for(int i = 0; i < 8; ++i)
				{
					for(int j = 0; j < 4; ++j)
						printf("%s:	%8llx ", REG_NAME[i*4+j], regfile[i*4+j]);
					printf("\n");
				}
			}
			else if(cmd == 'q')
			{
				return;
			}
			else if(cmd == 'r')
				ShowResult();
			else
				printf("type 'h' to see usage\n");
		}
	}
	else
	{
		while(true)
		{
			regfile[0] = 0;
			ERROR_TYPE error = OneInstruction();
			ShowResult();
			if(error != NO_ERROR)
				return;
		}
	}
}

REG Simulator::GetReg(int idx)
{
    if(idx < 0 || idx >= REGFILE_SIZE)
    {
        printf("invalid register index %d\n", idx);
        return -1;
    }
    return regfile[idx];
}

BYTE Simulator::ReadMemory(ADDR addr)
{
    if(addr < 0 || addr >= MEMORY_SIZE)
    {
        printf("invalid addr 0x%llx when read memory\n", addr);
        return -1;
    }
    return memory[addr];
}

INSTRUCTION Simulator::FetchInstruction()
{
    pc = nextpc;
    nextpc = pc + 4;
    return *(INSTRUCTION*)(memory + pc);
}

ERROR_TYPE Simulator::OneInstruction_R(INSTRUCTION instruction)
{
	unsigned int opcode = get_opcode(instruction);
	unsigned int funct3 = get_funct3(instruction);
	unsigned int funct7 = get_funct7(instruction);
	unsigned int rd = get_rd(instruction);
	unsigned int rs1 = get_rs1(instruction);
	unsigned int rs2 = get_rs2(instruction);
	switch (opcode)
	{
	case 0x33:
		switch (funct3)
		{
		case 0x0:	// add,mul,sub
			switch (funct7)
			{
			case 0x00:  // add
				regfile[rd] = regfile[rs1] + regfile[rs2];
				break;
			case 0x01:  // mul
				regfile[rd] = regfile[rs1] * regfile[rs2];
				break;
			case 0x20:  // sub
				regfile[rd] = regfile[rs1] - regfile[rs2];
				break;
			default:
				return INVALID_INSTRUCTION;
			}
			break;
		case 0x1:	// sll,mulh
			switch (funct7)
			{
			case 0x00:  // sll
				// NOTE: shift amount is encoded in the lower 6 bits of rs2
				regfile[rd] = regfile[rs1] << (regfile[rs2] & 0x3f);
				break;
			case 0x01:  // mulh:how to simulate this?
				regfile[rd] = 0;
				break;
			default:
				return INVALID_INSTRUCTION;
			}
			break;
		case 0x2:	//slt
			switch (funct7)
			{
			case 0x00:  // slt
				// NOTE: slt perform signed comparison
				regfile[rd] = (REG)((SREG)regfile[rs1] < (SREG)regfile[rs2] ? 1 : 0);
				break;
			default:
				return INVALID_INSTRUCTION;
			}
			break;
		case 0x4:	//xor,div
			switch (funct7)
			{
			case 0x00:  // xor
				regfile[rd] = regfile[rs1] ^ regfile[rs2];
				break;
			case 0x01:  // div
				// NOTE: div perform signed integer division
				regfile[rd] = (REG)((SREG)regfile[rs1] / (SREG)regfile[rs2]);
				break;
			default:
				return INVALID_INSTRUCTION;
			}
			break;
		case 0x5:	//srl,sra
			switch (funct7)
			{
			case 0x00:  // srl
				regfile[rd] = regfile[rs1] >> (regfile[rs2] & 0x3f);
				break;
			case 0x20:  // sra
				regfile[rd] = (REG)((SREG)regfile[rs1] >> (regfile[rs2] & 0x3f));
				break;
			default:
				return INVALID_INSTRUCTION;
			}
			break;
		case 0x6:	//or,rem
			switch (funct7)
			{
			case 0x00:
				regfile[rd] = regfile[rs1] | regfile[rs2];
				break;
			case 0x01:
				// NOTE: I think rem perform signed integer mod
				regfile[rd] = (REG)((SREG)regfile[rs1] % (SREG)regfile[rs2]);
				break;
			default:
				return INVALID_INSTRUCTION;
			}
			break;
		case 0x7:	//and
			switch (funct7)
			{
			case 0x00:
				regfile[rd] = regfile[rs1] & regfile[rs2];
				break;
			default:
				return INVALID_INSTRUCTION;
			}
			break;
		default:
			return INVALID_INSTRUCTION;
		}
		break;
	case 0x3b:
		switch (funct3)
		{
		case 0x0:	// addw,mulw,subw
			switch (funct7)
			{
			case 0x00:	// addw
				regfile[rd] = SignExt((REG)((int)regfile[rs1] + (int)regfile[rs2]),32);
				break;
			case 0x01:	// mulw
				regfile[rd] = SignExt((REG)((int)regfile[rs1] * (int)regfile[rs2]),32);
				break;
			case 0x20:	// subw
				regfile[rd] = SignExt((REG)((int)regfile[rs1] - (int)regfile[rs2]),32);
				break;
			default:
				return NO_ERROR;
			}
			break;
		case 0x1:	// sllw
			switch (funct7)
			{
			case 0x00:	// sllw
				regfile[rd] = SignExt((regfile[rs1] << (regfile[rs2] & 0x1f)) & 0xffffffff,32);
				break;
			default:
				return NO_ERROR;
			}
			break;
		case 0x4:	// divw
			switch (funct7)
			{
			case 0x01:	// divw
				regfile[rd] = SignExt((REG)((int)regfile[rs1] / (int)regfile[rs2]),32);
				break;
			default:
				return NO_ERROR;
			}
			break;
		case 0x5:	// srlw,divuw,sraw
			switch (funct7)
			{
			case 0x00:	// srlw
				regfile[rd] = SignExt(regfile[rs1] >> (regfile[rs2] & 0x1f),32);
				break;
			case 0x01:	// divuw
				regfile[rd] = SignExt((REG)((unsigned int)regfile[rs1] / (unsigned int)regfile[rs2]),32);
				break;
			case 0x20:	// sraw
				regfile[rd] = SignExt((REG)(((SREG)regfile[rs1] >> (regfile[rs2] & 0x1f)) & 0xffffffff),32);
				break;
			default:
				return NO_ERROR;
			}
			break;
		case 0x6:	// remw
			switch (funct7)
			{
			case 0x01:	// remw
				regfile[rd] = SignExt((REG)((int)regfile[rs1] % (int)regfile[rs2]),32);
				break;
			default:
				return NO_ERROR;
			}
			break;
		case 0x7:	// remuw
			switch (funct7)
			{
			case 0x01:	// remuw
				regfile[rd] = SignExt((REG)((unsigned int)regfile[rs1] % (unsigned int)regfile[rs2]),32);
				break;
			default:
				return NO_ERROR;
			}
			break;
		default:
			return NO_ERROR;
		}
		break;
	default:
		return NO_ERROR;
	}
	return NO_ERROR;
}


ERROR_TYPE Simulator::OneInstruction_I(INSTRUCTION instruction)
{
    unsigned int opcode = get_opcode(instruction);
	unsigned int funct3 = get_funct3(instruction);
	unsigned int rd = get_rd(instruction);
	unsigned int rs1 = get_rs1(instruction);
	unsigned int imm = get_imm(instruction);
	switch (opcode)
	{
	case 0x03:	// lb,lh,lw,ld
        // NOTE: signed extend if less than 64 bit
		switch (funct3)
		{
		case 0x0:   // lb
            regfile[rd] = SignExt((REG)(*(BYTE*)(memory + regfile[rs1] + SignExt(imm,12))),8);
			break;
		case 0x1:   // lh
            if((regfile[rs1] + SignExt(imm,12)) % 2 != 0)
                return ALIGN_ERROR;
			regfile[rd] = SignExt((REG)(*(HALFWORD*)(memory + regfile[rs1] + SignExt(imm,12))),16);
			break;
		case 0x2:   // lw
            if((regfile[rs1] + SignExt(imm,12)) % 4 != 0)
                return ALIGN_ERROR;
			regfile[rd] = SignExt((REG)(*(WORD*)(memory + regfile[rs1] + SignExt(imm,12))),32);
			break;
		case 0x3:   // ld
            if((regfile[rs1] + SignExt(imm,12)) % 8 != 0)
                return ALIGN_ERROR;
			regfile[rd] = SignExt((REG)(*(DOUBLEWORD*)(memory + regfile[rs1] + SignExt(imm,12))),64);
			break;
		default:
			return INVALID_INSTRUCTION;
		}
		break;
	case 0x13:	// addi,slli,slti,xori,srli,srai,ori,andi,addi
		switch (funct3)
		{
		case 0x0:   // addi
			regfile[rd] = (REG)((SREG)regfile[rs1] + (SREG)SignExt(imm,12));
			break;
		case 0x1:   // slli
			if(getbit(instruction,26,31) == 0x00)
				regfile[rd] = regfile[rs1] << (imm & 0x3f);
			else
				return INVALID_INSTRUCTION;
			break;
		case 0x2:   // slti
			regfile[rd] = (REG)((SREG)regfile[rs1] < (SREG)SignExt(imm,12) ? 1 : 0);
			break;
		case 0x4:   // xori
			regfile[rd] = regfile[rs1] ^ SignExt(imm,12);
			break;
		case 0x5:
			if(getbit(instruction,26,31) == 0x00)   // srli
				regfile[rd] = regfile[rs1] >> (imm & 0x3f);
			else if(getbit(instruction,26,31) == 0x10)  // srai
				regfile[rd] = (REG)((SREG)regfile[rs1] >> (imm & 0x3f));
			else
				return INVALID_INSTRUCTION;
			break;
		case 0x6:   // ori
			regfile[rd] = regfile[rs1] | SignExt(imm,12);
			break;
		case 0x7:   // andi
			regfile[rd] = regfile[rs1] & SignExt(imm,12);
			break;
		default:
			return INVALID_INSTRUCTION;
		}
		break;
	case 0x1b:
		switch(funct3)
		{
			case 0x0:	// addiw
				// Overflows are ignored and the result is the low 32 bits 
				// of the result sign-extension to 64 bits
				regfile[rd] = SignExt(((SREG)regfile[rs1] + (SREG)SignExt(imm,12)) & 0xffffffff,32);
				break;
			case 0x1:	// slliw
				if(get_funct7(instruction) == 0)
					regfile[rd] = SignExt((regfile[rs1] << getbit(instruction,20,24)) & 0xffffffff,32);
				else
					return INVALID_INSTRUCTION;
				break;
			case 0x5:	// srliw,sraiw
				switch (get_funct7(instruction))
				{
				case 0x00:	// srliw
					regfile[rd] = SignExt((regfile[rs1] >> getbit(instruction,20,24)) & 0xffffffff,32);
					break;
				case 0x20:	// sraiw
					regfile[rd] = SignExt(((SREG)regfile[rs1] >> getbit(instruction,20,24)) & 0xffffffff,32);
					break;
				default:
					return INVALID_INSTRUCTION;
				}
				break;
			default:
				return INVALID_INSTRUCTION;
		}
        break;
	case 0x67:
		if(funct3 == 0x0)   // jalr
		{
            regfile[rd] = pc + 4;
            nextpc = (REG)((SREG)regfile[rs1] + (SREG)SignExt(imm,12));
            nextpc = nextpc & (SREG)(~1);
        }
		else
			return INVALID_INSTRUCTION;
        break;
	case 0x73:
		if(funct3 == 0x0 && get_funct7(instruction) == 0x000)
			printf("ecall\n");
		else
			return INVALID_INSTRUCTION;
        break;
	default:
		return INVALID_INSTRUCTION;
	}
    return NO_ERROR;
}


ERROR_TYPE Simulator::OneInstruction_S(INSTRUCTION instruction)
{
    unsigned int funct3 = get_funct3(instruction);
	unsigned int rs1 = get_rs1(instruction);
	unsigned int rs2 = get_rs2(instruction);
	unsigned int imm = get_imm(instruction);
	switch (funct3)
	{
	case 0x0:   // sb
		*(BYTE*)(memory + regfile[rs1] + SignExt(imm,12)) = (BYTE)regfile[rs2];
		break;
	case 0x1:   // sh
		if((regfile[rs1] + SignExt(imm,12)) % 2 != 0)
            return ALIGN_ERROR;
        *(HALFWORD*)(memory + regfile[rs1] + SignExt(imm,12)) = (HALFWORD)regfile[rs2];
		break;
	case 0x2:   // sw
		if((regfile[rs1] + SignExt(imm,12)) % 4 != 0)
            return ALIGN_ERROR;
        *(WORD*)(memory + regfile[rs1] + SignExt(imm,12)) = (WORD)regfile[rs2];
		break;
	case 0x3:   // sd
		if((regfile[rs1] + SignExt(imm,12)) % 8 != 0)
            return ALIGN_ERROR;
        *(DOUBLEWORD*)(memory + regfile[rs1] + SignExt(imm,12)) = (DOUBLEWORD)regfile[rs2];
		break;
	default:
		return INVALID_INSTRUCTION;
	}
    return NO_ERROR;
}

ERROR_TYPE Simulator::OneInstruction_B(INSTRUCTION instruction)
{
    unsigned int funct3 = get_funct3(instruction);
	unsigned int rs1 = get_rs1(instruction);
	unsigned int rs2 = get_rs2(instruction);
	unsigned int imm = get_imm(instruction);
	switch (funct3)
	{
	case 0x0:   // beq
		if(regfile[rs1] == regfile[rs2])
            nextpc = pc + SignExt(imm,13);
		break;
	case 0x1:   // bne
		if(regfile[rs1] != regfile[rs2])
            nextpc = pc + SignExt(imm,13);
		break;
	case 0x4:   // blt
        // NOTE: blt perform signed comparison
		if((SREG)regfile[rs1] < (SREG)regfile[rs2])
            nextpc = pc + SignExt(imm,13);
		break;
	case 0x5:   // bge
        // NOTE: bge perform signed comparison
		if((SREG)regfile[rs1] >= (SREG)regfile[rs2])
            nextpc = pc + SignExt(imm,13);
		break;
	default:
		return INVALID_INSTRUCTION;
	}
    return NO_ERROR;
}

ERROR_TYPE Simulator::OneInstruction_U(INSTRUCTION instruction)
{
    unsigned int opcode = get_opcode(instruction);
	unsigned int rd = get_rd(instruction);
	unsigned int imm = get_imm(instruction);
	switch (opcode)
	{
	case 0x17:  // auipc
		regfile[rd] = pc + SignExt(imm,32);
		break;
	case 0x37:  // lui
		regfile[rd] = SignExt(imm,32);
		break;
	default:
		return INVALID_INSTRUCTION;
	}
    return NO_ERROR;
}

ERROR_TYPE Simulator::OneInstruction_J(INSTRUCTION instruction)
{
    unsigned int rd = get_rd(instruction);
	unsigned int imm = get_imm(instruction);
	// jal
    regfile[rd] = pc + 4;
    nextpc = pc + SignExt(imm,21);
    return NO_ERROR;
}

void Simulator::Monitor(MonitorUnit* _monitorTable, int cnt)
{
	monitorTable = _monitorTable;
	monitorCnt = cnt;
}

void Simulator::ShowResult()
{
	for(int j = 0; j < monitorCnt; ++j)
	{
		MonitorUnit* unit = monitorTable + j;
		char* base = memory + unit->vadr;
		for(int i = unit->start; i <= unit->end; ++i)
		{
			switch (unit->dataType)
			{
			case M_UNSIGNED_CHAR:
				printf("%hhu ", *((unsigned char*)base + i));
				break;
			case M_CHAR:
				printf("%hhd ", *((char*)base + i));
				break;
			case M_UNSIGNED_SHORT:
				printf("%hu ", *((unsigned short*)base + i));
				break;
			case M_SHORT:
				printf("%hd ", *((short*)base + i));
				break;
			case M_UNSIGNED_INT:
				printf("%u ", *((unsigned int*)base + i));
				break;
			case M_INT:
				printf("%d ", *((int*)base + i));
				break;
			case M_UNSIGNED_LONG_LONG:
				printf("%llu ", *((unsigned long long*)base + i));
				break;
			case M_LONG_LONG:
				printf("%lld ", *((long long*)base + i));
				break;
			default:
				printf("??? ");
				break;
			}
		}
		printf("\n");
	}
}