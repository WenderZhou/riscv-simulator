#ifndef PIPELINE_H
#define PIPELINE_H

#include "utils.h"
#include "def.h"
#include "Read_Elf.h"
#include "if.h"
#include "id.h"
#include "exe.h"
#include "mem.h"
#include "wb.h"

class Pipeline
{
public:
    Pipeline();
    ~Pipeline();
    void Run(char* filename, bool singleStep = false);
    void Monitor(MonitorUnit* _monitorTable, int cnt);
    void ShowResult();
private:
    ERROR_TYPE OneTick();
    void Update();
    void Work();

    void HazardHandler();
    void BranchLogic();
    bool CheckDataHazard();

    void BubbleLogic();

    IF ifu;
    ID idu;
    EXE exeu;
    MEM memu;
    WB wbu;

    REG predPc;
    INSTRUCTION IR;
    WIRE pc;
    WIRE busA, busB, imm;
    WIRE AluOut, DataIn;
    WIRE DataOut;
    WIRE busW;

    void load(char* filename);
    ElfReader* elfReader;

    char memory[MEMORY_SIZE];
    REG regfile[REGFILE_SIZE];
    
    bool stall[5];
    bool bubble[5];

    MonitorUnit* monitorTable;
    int monitorCnt;
};

#endif