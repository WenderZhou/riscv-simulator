#ifndef DEF_H
#define DEF_H

#define REGFILE_SIZE 32

#define STRANGE_MAGIC_NUMBER 1

typedef unsigned long long REG;
typedef signed long long SREG;
typedef unsigned long long ADDR;

typedef unsigned char BYTE; 
typedef unsigned short HALFWORD;
typedef unsigned int WORD;
typedef unsigned long long DOUBLEWORD;

typedef unsigned int INSTRUCTION;

enum INSTRUCTION_TYPE
{ TYPE_R, TYPE_I, TYPE_S, TYPE_B, TYPE_U, TYPE_J, TYPE_UNDEF };

enum ERROR_TYPE
{ NO_ERROR, HALT, ALIGN_ERROR, INVALID_INSTRUCTION };

enum MONITOR_DATA_TYPE
{ M_UNSIGNED_CHAR, M_CHAR, M_UNSIGNED_SHORT, M_SHORT,
  M_UNSIGNED_INT, M_INT, M_UNSIGNED_LONG_LONG, M_LONG_LONG };

enum MONITOR_STRUCT_TYPE
{ M_SINGLE, M_ARRAY };

class MonitorUnit
{
public:
    MonitorUnit(char* _name, MONITOR_DATA_TYPE _dataType, 
                int _start = 0, int _end = 0);
    char name[20];
    unsigned long long vadr;
    int start;
    int end;
    MONITOR_DATA_TYPE dataType;
};

#endif