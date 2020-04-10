#include "stdio.h"
#include "simulator.h"
#include "utils.h"
#include "Read_Elf.h"
#include "def.h"

int main()
{
    char filename[20] = { "test/simple-f" };
    Simulator* sim = new Simulator();

    MonitorUnit* result = new MonitorUnit("result",M_INT,0,9);

    sim->Monitor(result,1);

    sim->Run(filename,false);

    sim->ShowResult();

    return 0;
}