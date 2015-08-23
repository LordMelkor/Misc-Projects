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

# Permutation generator sourced from:
# http://code.activestate.com/recipes/496819-a-recursive-function-to-get-permutation-of-a-list/
def permu(xs):
    if len(xs)<2: yield xs
    else:
        h = []
        for x in xs:
            h.append(x)
            if x in h[:-1]: continue
            ts = xs[:]; ts.remove(x)
            for ps in permu(ts):
                yield [x]+ps


N=8
pGen = permu(list(range(1,N+1)))
its=math.factorial(N)

# Running Stats

# initialize
x=countChainsBrute(next(pGen))
M=x
S=0
for k in range(2,its+1):
    input = next(pGen)
    x=countChainsBrute(input)
    M_old=M
    M=M_old+(x-M_old)/k
    S=S+(x-M_old)*(x-M)
V=S/(its)
stdD=math.sqrt(V)
print('fancy mean is ',M)
print('fancy std dev is ',stdD)