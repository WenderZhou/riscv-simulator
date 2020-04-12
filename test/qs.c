#include "stdio.h"
#define size 40

int result[size];

int Partition(int* a, int left, int right){
    int l = left;
    int r = right;
    int tempRecord = a[r];
    while(l != r){
        while(a[l] <= tempRecord && r > l)
            l++;
        if(l < r){
            a[r] = a[l];
            r--;
        }
        while(a[r] >= tempRecord && r > l)
            r--;
        if(l < r){
            a[l] = a[r];
            l++;
        }
    }
    a[l] = tempRecord;
    return l;
}

void QuickSort(int* a,int left, int right){
    if(right <= left)
        return;
    int pivot = (left + right)/2;
    int temp = a[pivot];
    a[pivot] = a[right];
    a[right] = temp;
    pivot = Partition(a, left, right);
    QuickSort(a, left, pivot - 1);
    QuickSort(a, pivot + 1, right);
}

int main() {
    
    for(int i = 0; i < size; ++i)
        result[i] = size - i;

    QuickSort(result, 0, size - 1);

    return 0;
}
