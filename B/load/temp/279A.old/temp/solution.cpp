// contestName: Codeforces Round #171 (Div. 2)
// problemId:   279A
// problemName: Точка на спирали
// author:      cinderela
// href:        /contest/279/submission/3250275
// verdict:     Полное решение

#include <iostream>

using namespace std;

int x,y,m;

int main(){
	cin>>x>>y;
	if(y>x && x>=-y)m=-2+y*4;
	if(y<x && x<=-y+1)m=-y*4;
	if(y<=x && x>-y+1)m=-3+x*4;
	if(y>=x && x<-y)m=-1-4*x;
	cout<<m<<endl;
	return 0;
}
