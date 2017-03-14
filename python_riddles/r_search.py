import math
from pandas import DataFrame

def bsearch1k(st,rg):
	mxRg=max(rg)
	cnt_list=[None]*mxRg
	for i in rg:
		cnt=1
		lb=0
		ub=mxRg
		guess=st
		while guess != i:
			if ub-lb<=0:
				cnt='Error OoR'
				break
			if guess<i:
				lb = guess+1
			else:
				ub=guess
			guess=(lb+ub)//2
			cnt+=1
			if cnt>math.ceil(math.log((mxRg*2)+1,2)):
				cnt='Error'
				break
		cnt_list[i-1]=cnt
	return cnt_list

def brute_force(rg):
	rg = range(1, 1001)
	ret_list=[None]*max(rg)
	for j in rg:
		df = DataFrame({'Range': list(rg), 'Iterations': bsearch1k(j,rg)})
		ret_list[j-1]=df[df['Iterations'] <= 9]['Range'].sum()
	return ret_list


def main():
	rg = range(1, 1001)
	
	# finDF=DataFrame({'Range': list(rg), 'Returns': brute_force(rg)})
	finDF = DataFrame({'Range': list(rg), 'Iterations': bsearch1k(503,rg)})
	
	finDF.to_excel('r_search.xlsx', index=False, sheet_name='Sheet1')


if __name__ == "__main__":
    main()