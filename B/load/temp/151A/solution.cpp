// contestName: Codeforces Round #107 (Div. 2)
// problemId:   151A
// problemName: Газировкопитие
// author:      rahman007
// href:        /contest/151/submission/3137394
// verdict:     Полное решение

#include<iostream>
#include<algorithm>
using namespace std;
int main(){int a,b,c,d,e,f,g,h;cin >> a >>b>>c>>d>>e>>f>>g>>h;cout << min(b*c/g,min(d*e,f/h))/a;}