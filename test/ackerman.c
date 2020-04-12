#include "stdio.h"

int result = 0;

int ack(int m,int n)
{
    if(m==0)
        return(n+1);
    else if(n==0)
        return(ack(m-1,1));
    else
        return(ack(m-1,ack(m,n-1)));
}

int main() {
    int x = 3;
    int y = 8;

    result = ack(x,y);

    return 0;
}
