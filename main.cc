#include "stdio.h"
#include "simulator.h"
#include "pipeline.h"
#include "utils.h"
#include "Read_Elf.h"
#include "def.h"

int main()
{
    char filename[20] = { "test/qsort" };
    // Simulator* sim = new Simulator();
    Pipeline* sim = new Pipeline();
    MonitorUnit* result = new MonitorUnit("result",M_INT,0,39);

    sim->Monitor(result,1);

    sim->Run(filename,false);

    sim->ShowResult();

    return 0;
}