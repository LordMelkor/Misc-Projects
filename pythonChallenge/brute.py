import numpy
import math

def countChainsBrute(perm):
    N=len(perm)
    sol = [None] * N
    cnt = 0
    max_cnt=0
    
    i=1
    while i <= N:
        x = perm[i-1]
        if x==1:
            if sol[0]==None:
                cnt=cnt+1
            sol[0]=1
            if sol[1]==None:
                sol[1]=0
        elif x==N:
            if sol[N-1]==None:
                cnt=cnt+1
            sol[N-1]=N
            if sol[N-2]==None:
                sol[N-2]=0
        else:
            b1=0
            b2=0
            if sol[x-1]==None:
                cnt=cnt+1
            sol[x-1]=x
            if sol[x-2]==None:
                sol[x-2]=0
            elif sol[x-2]>0:
                b1=1
            if sol[x]==None:
                sol[x]=0
            elif sol[x]>0:
                b2=1
            cnt=cnt-b1*b2
        if cnt>max_cnt:
            max_cnt=cnt
        if sol.count(None)==0:
            i=N
        i=i+1
    
    return max_cnt


import itertools

N = 8

lst=list(itertools.permutations(list(range(1,N+1))))

its=len(lst)

v=numpy.empty(its,dtype=int)

for i in range(its):
    v[i]=countChainsBrute(lst[i])

print('numpy mean is ',numpy.mean(v,dtype=numpy.float64))
print('numpy std dev is ',numpy.std(v,dtype=numpy.float64))