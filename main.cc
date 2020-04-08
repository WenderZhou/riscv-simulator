#include "stdio.h"
#include "simulator.h"
#include "utils.h"

int main()
{
    Simulator* sim = new Simulator();
    sim->Run();
    return 0;
}