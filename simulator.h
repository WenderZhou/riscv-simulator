#ifndef SIMULATOR_H
#define SIMULATOR_H

#include "utils.h"
#include "def.h"
#include "Read_Elf.h"


class Simulator
{
public:
    Simulator();
    ~Simulator();
    void Run(char* filename, bool singleStep = false);
    REG GetReg(int idx);
    BYTE ReadMemory(ADDR addr);
    void Monitor(MonitorUnit* _monitorTable, int cnt);
    void ShowResult();

private:
    ERROR_TYPE OneInstruction();
    INSTRUCTION FetchInstruction();

    void load(char* filename);
    ElfReader* elfReader;

    char memory[MEMORY_SIZE];
    REG regfile[REGFILE_SIZE];
    REG pc;
    REG nextpc;
    MonitorUnit* monitorTable;
    int monitorCnt;
};

#endif
