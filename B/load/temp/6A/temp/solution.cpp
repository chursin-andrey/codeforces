// contestName: Codeforces Beta Round #6 (�������� 2)
// problemId:   6A
// problemName: �����������
// author:      Iman
// href:        /contest/6/submission/656435
// verdict:     ������ �������

#include <iostream>
#include <algorithm>
int a[4];
int main(){std::cin>>a[0]>>a[1]>>a[2]>>a[3];std::sort(a, a + 4);
    if(a[1]+a[2]>a[3]||a[0]+a[1]>a[2])std::cout<<"TRIANGLE";else if(a[1]+a[2]==a[3]||a[0]+a[1]==a[2])std::cout<<"SEGMENT";else std::cout<<"IMPOSSIBLE";}