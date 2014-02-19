// contestName: Codeforces Round #171 (Div. 2)
// problemId:   279B
// problemName: Книги
// author:      STU_Mikiashvili_Guram
// href:        /contest/279/submission/3292710
// verdict:     Полное решение

#include <iostream>

using namespace std;

int main()
{
	int n, t, i=0, j=1, sum;
	cin>>n>>t;
	int m[100010];
	for(int k=0;k<n;k++) cin>>m[k];
	sum=m[0];
	while(j<n) {if(sum>t) sum-=m[i++]; sum+=m[j++];}
	if(sum>t) i++;
	cout<<j-i<<endl;
	return 0;
}