#include "stdio.h"
#include "simulator.h"
#include "pipeline.h"
#include "utils.h"
#include "Read_Elf.h"
#include "def.h"
#include "stdlib.h"

// #define SIMULATOR
#define PIPELINE

int main(int argc, char **argv)
{
    char* filename = argv[1];
    printf("%s\n",filename);
#ifdef SIMULATOR
    Simulator* sim = new Simulator();
#else
#ifdef PIPELINE
    Pipeline* sim = new Pipeline();
#endif
#endif

    bool singleStep = false;
    MonitorUnit* result;

    int argCount = 0;
    for(argc -= 2, argv += 2; argc > 0; argc -= argCount, argv += argCount)
    {
        if(!strcmp(*argv,"-s"))
        {
            singleStep = true;
            argCount = 1;
            break;
        }
        else if(!strcmp(*argv,"-o"))
        {
            
            result = new MonitorUnit(*(argv+1),M_INT,(int)strtol(*(argv+2),NULL,10),(int)strtol(*(argv+3),NULL,10));
            sim->Monitor(result,1);
            argCount = 4;
        }
        else if(!strcmp(*argv,"-h"))
        {
            printf("-s  run simulator once a step, otherwise continuously\n");
            printf("-o  show result\n");
            printf("    format: -o variableName startIndex endIndex\n");
            printf("    default dataType as int\n");
            return 0;
        }
    }

    

    sim->Run(filename,singleStep);

    sim->ShowResult();

    sim->ShowStat();

    return 0;
}