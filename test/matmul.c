#include "stdio.h"

int A[5][5];
int B[5][2];
int result[5][2];

int main() {
    for(int i = 0; i < 5; ++i)
        for(int j = 0; j < 2; ++j)
            result[i][j] = 0;
    
    int a = 0;
    for(int i = 0; i < 5; ++i)
        for(int j = 0; j < 5; ++j)
            A[i][j] = a++;
    
    a = 0;
    for(int i = 0; i < 5; ++i)
        for(int j = 0; j < 2; ++j)
            B[i][j] = a++;
    
    for(int i = 0; i < 5; ++i)
        for(int k = 0; k < 2; ++k)
            for(int j = 0; j < 5; ++j)
                result[i][k] += A[i][j] * B[j][k];
    
    return 0;
}
