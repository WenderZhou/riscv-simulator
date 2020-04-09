#include "def.h"
#include "string.h"
#include "stdio.h"
#include "Read_Elf.h"

MonitorUnit::MonitorUnit(char* _name, MONITOR_DATA_TYPE _dataType,
            int _start, int _end)
{
    memset(name,0,sizeof(name));
    memcpy(name,_name,strlen(_name));
    dataType = _dataType;
    start = _start;
    end = _end;
}