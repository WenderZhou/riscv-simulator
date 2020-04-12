#include "pipeline.h"
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

Pipeline::Pipeline():
    ifu(memory, &IR, &pc),
    idu(regfile, &busA, &busB, &imm),
    exeu(&AluOut, &DataIn),
    memu(memory, &DataOut),
    wbu(regfile, &busW)
{
    memset(memory, 0, sizeof(memory));
    memset(regfile, 0, sizeof(regfile));
    instructionCnt = 0;
    cycle = 0;
}

Pipeline::~Pipeline()
{
	delete elfReader;
}

void Pipeline::load(char* filename)
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

void Pipeline::Update()
{
    if(!stall[STAGE_WB])
        wbu.Update(memu.pc, memu.AluOut, DataOut, memu.instruction);
    if(!stall[STAGE_MEM])
        memu.Update(exeu.pc, AluOut, DataIn, exeu.instruction);
    if(!stall[STAGE_EXE])
        exeu.Update(idu.pc, busA, busB, imm, idu.instruction);
    if(!stall[STAGE_ID])
        idu.Update(pc, IR);
    if(!stall[STAGE_IF])
        ifu.Update(&predPc);
}

void Pipeline::Work()
{
    if(!bubble[STAGE_IF])
        ifu.Work();
    if(!bubble[STAGE_ID])
        idu.Work();
    if(!bubble[STAGE_EXE])
        exeu.Work();
    if(!bubble[STAGE_MEM])
        memu.Work();
    if(!bubble[STAGE_WB])
        wbu.Work();
}

ERROR_TYPE Pipeline::OneTick()
{
    Update();
    regfile[0] = 0;

    // printf("bubble:");
    // for(int i = 0; i < 5; i++)
    //     if(bubble[i])
    //         printf(" T");
    //     else
    //         printf(" F");
    // printf("\nstall:");
    // for(int i = 0; i < 5; i++)
    //     if(stall[i])
    //         printf(" T");
    //     else
    //         printf(" F");
    // printf("\n");

    // printf("ID:");
    // if(bubble[STAGE_ID])
    //     printf("bubble\n");
    // else
    //     show(idu.instruction);
    // printf("EXE:");
    // if(bubble[STAGE_EXE])
    //     printf("bubble\n");
    // else
    //     show(exeu.instruction);
    // printf("MEM:");
    // if(bubble[STAGE_MEM])
    //     printf("bubble\n");
    // else
    //     show(memu.instruction);
    // printf("WB:");
    // if(bubble[STAGE_WB])
    //     printf("bubble\n");
    // else
    //     show(wbu.instruction);

    if(wbu.pc == elfReader->mend || wbu.pc == elfReader->mend - 1)
		return HALT;

    if(!bubble[STAGE_WB] && !stall[STAGE_WB])
        instructionCnt++;

    Work();

    regfile[0] = 0;
    for(int i = 0; i < 5; ++i)
        stall[i] = false;

    HazardHandler();

    BubbleLogic();

    // ShowResult();

    Penalty(wbu.instruction);

    return NO_ERROR;
}

void Pipeline::HazardHandler()
{
    BranchLogic();

    if(CheckDataHazard())
    {
        stall[STAGE_IF] = true;
        stall[STAGE_ID] = true;
    }
}

void Pipeline::BranchLogic()
{
    if(!bubble[STAGE_EXE] && exeu.GetNextPc() != idu.pc)
    {
        bubble[STAGE_IF] = true;
        bubble[STAGE_ID] = true;
        predPc = exeu.GetNextPc();
    }
}

bool Pipeline::CheckDataHazard()
{
    unsigned int Ra = idu.Ra;
    unsigned int Rb = idu.Rb;
    unsigned int Rw = REGFILE_SIZE;

    switch (get_type(idu.instruction))
    {
    case TYPE_R:
    case TYPE_S:
    case TYPE_B:
        Rw = get_Rw(wbu.instruction);
        if(!bubble[STAGE_WB] && (Ra == Rw || Rb == Rw))
        {
            if(Ra == Rw)
                idu.ForwardA(busW);
            else
                idu.ForwardB(busW);
        }
        Rw = get_Rw(memu.instruction);
        if(!bubble[STAGE_MEM] && (Ra == Rw || Rb == Rw))
        {
            switch (get_WbSrc(memu.instruction))
            {
            case WB_DATAOUT:
                if(Ra == Rw)
                    idu.ForwardA(DataOut);
                else
                    idu.ForwardB(DataOut);
                break;
            case WB_ALUOUT:
                if(Ra == Rw)
                    idu.ForwardA(memu.AluOut);
                else
                    idu.ForwardB(memu.AluOut);
                break;
            case WB_PC_PLUS4:
                if(Ra == Rw)
                    idu.ForwardA(memu.pc + 4);
                else
                    idu.ForwardB(memu.pc + 4);
                break;
            default:
                // NOTE: should never arrive here
                break;
            }
        }
        Rw = get_Rw(exeu.instruction);
        if(!bubble[STAGE_EXE] && (Ra == Rw || Rb == Rw))
        {
            switch (get_WbSrc(exeu.instruction))
            {
            case WB_DATAOUT:
                return true;
            case WB_ALUOUT:
                if(Ra == Rw)
                    idu.ForwardA(AluOut);
                else
                    idu.ForwardB(AluOut);
                break;
            case WB_PC_PLUS4:
                if(Ra == Rw)
                    idu.ForwardA(exeu.pc + 4);
                else
                    idu.ForwardB(exeu.pc + 4);
                break;
            default:
                // NOTE: should never arrive here
                break;
            }
        }
        break;
    case TYPE_I:
        Rw = get_Rw(wbu.instruction);
        if(!bubble[STAGE_WB] && Ra == Rw)
            idu.ForwardA(busW);
        Rw = get_Rw(memu.instruction);
        if(!bubble[STAGE_MEM] && Ra == Rw)
        {
            switch (get_WbSrc(memu.instruction))
            {
            case WB_DATAOUT:
                idu.ForwardA(DataOut);
                break;
            case WB_ALUOUT:
                idu.ForwardA(memu.AluOut);
                break;
            case WB_PC_PLUS4:
                idu.ForwardA(memu.pc + 4);
                break;
            default:
                // NOTE: should never arrive here
                break;
            }
        }
        Rw = get_Rw(exeu.instruction);
        if(!bubble[STAGE_EXE] && Ra == Rw)
        {
            switch (get_WbSrc(exeu.instruction))
            {
            case WB_DATAOUT:
                return true;
            case WB_ALUOUT:
                idu.ForwardA(AluOut);
                break;
            case WB_PC_PLUS4:
                idu.ForwardA(exeu.pc + 4);
                break;
            default:
                // NOTE: should never arrive here
                break;
            }
        }
        break;
    default:
        break;
    }
    return false;
}

void Pipeline::Run(char* filename, bool singleStep)
{
	elfReader = new ElfReader(monitorTable, monitorCnt);
	elfReader->read_elf(filename);

	load(filename);
    
	predPc = elfReader->madr;

	regfile[2] = MEMORY_SIZE - 10000;
	regfile[3] = elfReader->gp;

    char cmd = 0;

    bubble[0] = false;
    for(int i = 1; i < 5; i++)
    {
        bubble[i] = true;
    }
    for(int i = 0; i < 5; i++)
    {
        stall[i] = false;
    }

	if(singleStep)
	{
		while(true)
		{
			regfile[0] = 0;
			scanf("%c\n",&cmd);
			if(cmd == 'c')
			{
                ERROR_TYPE error = OneTick();
                if(error != NO_ERROR)
                     return;
			}
            else if(cmd == 'x')
			{
                ERROR_TYPE error = OneTick();
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
			ERROR_TYPE error = OneTick();
			if(error != NO_ERROR)
				return;
		}
	}
}

void Pipeline::Monitor(MonitorUnit* _monitorTable, int cnt)
{
	monitorTable = _monitorTable;
	monitorCnt = cnt;
}

void Pipeline::ShowResult()
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

void Pipeline::BubbleLogic()
{
    int i;
    for(i = 0; i < 5 && stall[i]; ++i);
    for(int j = 4; j > i; j--)
        bubble[j] = bubble[j - 1];
    if(i < 5)
        bubble[i] = true;
    if(!stall[STAGE_IF])
        bubble[i] = false;
}

void Pipeline::Penalty(INSTRUCTION instruction)
{
    switch (get_icode(instruction))
    {
    case MUL:cycle+=MUL_PENALTY;break;
    case DIV:cycle+=DIV_PENALTY;break;
    case REM:cycle+=REM_PENALTY;break;
    case MULW:cycle+=MULW_PENALTY;break;
    case DIVW:cycle+=DIVW_PENALTY;break;
    case REMW:cycle+=REMW_PENALTY;break;
    case LB:
    case LH:
    case LW:
    case LD:
    case SB:
    case SH:
    case SW:
    case SD:cycle+=MEMORY_PENALTY;break;
    default:cycle += 1;break;
    }
}

void Pipeline::ShowStat()
{
    printf("instruction count:%d\n", instructionCnt);
    printf("cycle:%d\n",cycle);
}