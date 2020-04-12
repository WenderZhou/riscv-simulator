#include "simulator.h"
#include "stdio.h"
#include "cstring"
#include "stdlib.h"

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
}

Simulator::~Simulator()
{
	delete elfReader;
}

ERROR_TYPE Simulator::OneInstruction(bool verbose)
{
	regfile[0] = 0;

    ERROR_TYPE error = NO_ERROR;
    INSTRUCTION instruction = FetchInstruction();

	if(pc == elfReader->mend)
		return HALT;

	if(verbose)
    	show(instruction);

	unsigned int rd = get_rd(instruction);
	unsigned int rs1 = get_rs1(instruction);
	unsigned int rs2 = get_rs2(instruction);
	unsigned int imm = get_imm(instruction);

	ICODE icode = get_icode(instruction);

	switch (icode)
	{
	case ADD:
		regfile[rd] = regfile[rs1] + regfile[rs2];
		break;
	case MUL:
		regfile[rd] = regfile[rs1] * regfile[rs2];
		break;
	case SUB:
		regfile[rd] = regfile[rs1] - regfile[rs2];
		break;
	case SLL:
		// NOTE: shift amount is encoded in the lower 6 bits of rs2
		regfile[rd] = regfile[rs1] << (regfile[rs2] & 0x3f);
		break;
	case MULH:  // mulh:how to simulate this?
		regfile[rd] = 0;
		break;
	case SLT:
		// NOTE: slt perform signed comparison
		regfile[rd] = (REG)((SREG)regfile[rs1] < (SREG)regfile[rs2] ? 1 : 0);
		break;
	case XOR:
		regfile[rd] = regfile[rs1] ^ regfile[rs2];
		break;
	case DIV:
		// NOTE: div perform signed integer division
		regfile[rd] = (REG)((SREG)regfile[rs1] / (SREG)regfile[rs2]);
		break;
	case SRL:
		regfile[rd] = regfile[rs1] >> (regfile[rs2] & 0x3f);
		break;
	case SRA:
		regfile[rd] = (REG)((SREG)regfile[rs1] >> (regfile[rs2] & 0x3f));
		break;
	case OR:
		regfile[rd] = regfile[rs1] | regfile[rs2];
		break;
	case REM:
		// NOTE: I think rem perform signed integer mod
		regfile[rd] = (REG)((SREG)regfile[rs1] % (SREG)regfile[rs2]);
		break;
	case AND:
		regfile[rd] = regfile[rs1] & regfile[rs2];
		break;
	case ADDW:
		regfile[rd] = SignExt((REG)((int)regfile[rs1] + (int)regfile[rs2]),32);
		break;
	case MULW:
		regfile[rd] = SignExt((REG)((int)regfile[rs1] * (int)regfile[rs2]),32);
		break;
	case SUBW:
		regfile[rd] = SignExt((REG)((int)regfile[rs1] - (int)regfile[rs2]),32);
		break;
	case SLLW:
		regfile[rd] = SignExt((regfile[rs1] << (regfile[rs2] & 0x1f)) & 0xffffffff,32);
		break;
	case DIVW:
		regfile[rd] = SignExt((REG)((int)regfile[rs1] / (int)regfile[rs2]),32);
		break;
	case SRLW:
		regfile[rd] = SignExt(regfile[rs1] >> (regfile[rs2] & 0x1f),32);
		break;
	case DIVUW:
		regfile[rd] = SignExt((REG)((unsigned int)regfile[rs1] / (unsigned int)regfile[rs2]),32);
		break;
	case SRAW:
		regfile[rd] = SignExt((REG)(((SREG)regfile[rs1] >> (regfile[rs2] & 0x1f)) & 0xffffffff),32);
		break;
	case REMW:
		regfile[rd] = SignExt((REG)((int)regfile[rs1] % (int)regfile[rs2]),32);
		break;
	case REMUW:
		regfile[rd] = SignExt((REG)((unsigned int)regfile[rs1] % (unsigned int)regfile[rs2]),32);
		break;
	case LB:
		regfile[rd] = SignExt((REG)(*(BYTE*)(memory + regfile[rs1] + SignExt(imm,12))),8);
		break;
	case LH:
		if((regfile[rs1] + SignExt(imm,12)) % 2 != 0)
			return ALIGN_ERROR;
		regfile[rd] = SignExt((REG)(*(HALFWORD*)(memory + regfile[rs1] + SignExt(imm,12))),16);
		break;
	case LW:
		if((regfile[rs1] + SignExt(imm,12)) % 4 != 0)
			return ALIGN_ERROR;
		regfile[rd] = SignExt((REG)(*(WORD*)(memory + regfile[rs1] + SignExt(imm,12))),32);
		break;
	case LD:
		if((regfile[rs1] + SignExt(imm,12)) % 8 != 0)
			return ALIGN_ERROR;
		regfile[rd] = SignExt((REG)(*(DOUBLEWORD*)(memory + regfile[rs1] + SignExt(imm,12))),64);
		break;
	case ADDI:
		regfile[rd] = (REG)((SREG)regfile[rs1] + (SREG)SignExt(imm,12));
		break;
	case SLLI:
		regfile[rd] = regfile[rs1] << (imm & 0x3f);
		break;
	case SLTI:
		regfile[rd] = (REG)((SREG)regfile[rs1] < (SREG)SignExt(imm,12) ? 1 : 0);
		break;
	case XORI:
		regfile[rd] = regfile[rs1] ^ SignExt(imm,12);
		break;
	case SRLI:
		regfile[rd] = regfile[rs1] >> (imm & 0x3f);
		break;
	case SRAI:
		regfile[rd] = (REG)((SREG)regfile[rs1] >> (imm & 0x3f));
		break;
	case ORI:
		regfile[rd] = regfile[rs1] | SignExt(imm,12);
		break;
	case ANDI:
		regfile[rd] = regfile[rs1] & SignExt(imm,12);
		break;
	case ADDIW:
		// Overflows are ignored and the result is the low 32 bits 
		// of the result sign-extension to 64 bits
		regfile[rd] = SignExt(((SREG)regfile[rs1] + (SREG)SignExt(imm,12)) & 0xffffffff,32);
		break;
	case SLLIW:
		regfile[rd] = SignExt((regfile[rs1] << getbit(instruction,20,24)) & 0xffffffff,32);
		break;
	case SRLIW:
		regfile[rd] = SignExt((regfile[rs1] >> getbit(instruction,20,24)) & 0xffffffff,32);
		break;
	case SRAIW:
		regfile[rd] = SignExt(((SREG)regfile[rs1] >> getbit(instruction,20,24)) & 0xffffffff,32);
		break;
	case JALR:
		// NOTE: calculate nextpc first then update regfile!!!
		nextpc = (REG)((SREG)regfile[rs1] + (SREG)SignExt(imm,12));
		nextpc = nextpc & (SREG)(~1);
		regfile[rd] = pc + 4;
		break;
	case ECALL:
		printf("ecall\n");
		break;
	case SB:
		*(BYTE*)(memory + regfile[rs1] + SignExt(imm,12)) = (BYTE)regfile[rs2];
		break;
	case SH:
		if((regfile[rs1] + SignExt(imm,12)) % 2 != 0)
			return ALIGN_ERROR;
		*(HALFWORD*)(memory + regfile[rs1] + SignExt(imm,12)) = (HALFWORD)regfile[rs2];
		break;
	case SW:
		if((regfile[rs1] + SignExt(imm,12)) % 4 != 0)
            return ALIGN_ERROR;
        *(WORD*)(memory + regfile[rs1] + SignExt(imm,12)) = (WORD)regfile[rs2];
		break;
	case SD:
		if((regfile[rs1] + SignExt(imm,12)) % 8 != 0)
            return ALIGN_ERROR;
        *(DOUBLEWORD*)(memory + regfile[rs1] + SignExt(imm,12)) = (DOUBLEWORD)regfile[rs2];
		break;
    case BEQ:
		if(regfile[rs1] == regfile[rs2])
            nextpc = pc + SignExt(imm,13);
		break;
	case BNE:
		if(regfile[rs1] != regfile[rs2])
            nextpc = pc + SignExt(imm,13);
		break;
	case BLT:
		// NOTE: blt perform signed comparison
		if((SREG)regfile[rs1] < (SREG)regfile[rs2])
            nextpc = pc + SignExt(imm,13);
		break;
	case BGE:
		 // NOTE: bge perform signed comparison
		if((SREG)regfile[rs1] >= (SREG)regfile[rs2])
            nextpc = pc + SignExt(imm,13);
		break;
    case AUIPC:
		regfile[rd] = pc + SignExt(imm,32);
		break;
	case LUI:
		regfile[rd] = SignExt(imm,32);
		break;
    case JAL:
		regfile[rd] = pc + 4;
		nextpc = pc + SignExt(imm,21);
		break;
    case UNDEF:
		error = INVALID_INSTRUCTION;
		break;
	default:
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

void Simulator::Run(char* filename, bool singleStep, bool verbose)
{
	elfReader = new ElfReader(monitorTable, monitorCnt);
	elfReader->read_elf(filename);

	load(filename);
    
	nextpc = elfReader->madr;

	regfile[2] = MEMORY_SIZE - 10000;
	regfile[3] = elfReader->gp;

	char cmd;
	char buf[20];
	ADDR userAdr = 0;
	REG destPC = 0;

	ERROR_TYPE error = NO_ERROR;

	if(singleStep)
	{
		while(true)
		{
			regfile[0] = 0;
			scanf("%c",&cmd);
			switch (cmd)
			{
			case 'b':	// break point
				scanf("%s",buf);
				destPC = strtol(buf,NULL,16);
				do{
					error = OneInstruction(verbose);
					if(error != NO_ERROR)
						return;
				}while(pc != destPC);
				break;
			case 'c':	// continue one step
				error = OneInstruction(verbose);
				if(error != NO_ERROR)
					return;
				break;
			case 'h':
				printf("type 'b 0x...' to run to the break point\n");
				printf("type 'c' to run the simulator by one step\n");
				printf("type 'm 0x...' to show memory 0x...\n");
				printf("type 'q' to quit\n");
				printf("type 'r' to show register\n");
				printf("type 'R' to show Result\n");
				printf("please type according to format, otherwise it may not work!\n");
				break;
			case 'm':	// show memory
				scanf("%s",buf);
				userAdr = strtol(buf,NULL,16);
				if(userAdr < 0 || userAdr > MEMORY_SIZE)
					printf("invalid address!\n");
				else
					printf("memory[0x%llx]:0x%hhx\n",userAdr,memory[userAdr]);
				break;
			case 'q':	// quit
				return;
			case 'r':	// show register
				for(int i = 0; i < 8; ++i)
				{
					for(int j = 0; j < 4; ++j)
						printf("%s:	%8llx ", REG_NAME[i*4+j], regfile[i*4+j]);
					printf("\n");
				}
				break;
			case 'R':	// show result
				ShowResult();
				break;
			default:
				printf("type 'h' to see usage\n");
				break;
			}	
			scanf("%c",&cmd);
		}
	}
	else
	{
		while(true)
		{
			regfile[0] = 0;
			error = OneInstruction(verbose);
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