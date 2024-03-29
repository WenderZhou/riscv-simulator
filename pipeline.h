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
    void Run(char* filename, bool singleStep = false, bool verbose = false);
    void Monitor(MonitorUnit* _monitorTable, int cnt);
    void ShowResult();
    void ShowStat();
    
private:
    ERROR_TYPE OneTick(bool verbose);
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

    unsigned long long instructionCnt;
    unsigned long long cycle;
    unsigned long long dataHazardCnt;
    unsigned long long controlHazardCnt;

    void Penalty(INSTRUCTION instruction);
};

#endif