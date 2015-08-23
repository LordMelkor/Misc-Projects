#!/usr/bin/env python3

# Krishanu Ray, 2015
# 100,000,000 iterations used for N=16 & N=32

import math
import random
import numpy
import sys, getopt

def main(argv):
    n = None
    its = None
    try:
        opts, args = getopt.getopt(argv,"hn:i:",["N=","iterations="])
    except getopt.GetoptError:
        print("chains.py -n <N> -i <iterations>")
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print("chains.py -n <N> -i <iterations>")
            sys.exit()
        elif opt in ("-n", "-N"):
            n = arg
        elif opt in ("-i", "--iterations"):
            its = arg
    n=int(n)
    its=int(its)
    return [n,its]

# Sampling with replacement algo sourced from:
# http://stackoverflow.com/questions/18921302/how-to-incrementally-sample-without-replacement/18990254#18990254

def shuffle_gen(n):
    # this is used like a range(n) list, but we don’t store
    # those entries where state[i] = i.
    state = dict()
    for remaining in range(n, 0, -1):
        i = random.randrange(remaining)
        yield state.get(i,i)
        state[i] = state.get(remaining - 1,remaining - 1)
        # Cleanup – we don’t need this information anymore
        state.pop(remaining - 1, None)


#For a given draw order, determine M. With optimizations.

def countChains(N):
    sol = [None] * N
    gen = shuffle_gen(N)
    cnt = 0
    max_cnt = 0
    
    i=1
    while i <= N:
        x = next(gen)+1
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


#Running Stats

# its=100000
# avg=0
# #initialize
# x=countChains(5)
# M=x
# S=0
# for k in range(2,its+1):
   # x=countChains(4)
   # avg=avg+x
   # M_old=M
   # M=M_old+(x-M_old)/k
   # S=S+(x-M_old)*(x-M)
# avg=avg/its
# V=S/(its-1)
# stdD=math.sqrt(V)
# print('mean is ',avg)
# print('fancy mean is ',M)
# print('fancy std dev is ',stdD)


#Single-Thread

#its=1000000
#v=numpy.empty(its,dtype=int)
#
#def looper(it,tbl):
#   tbl[it]=countChains(5)
#
#for i in range(its):
#    looper(i,v)
#
#print('numpy mean is ',numpy.mean(v,dtype=numpy.float64))
#print('numpy std dev is ',numpy.std(v,dtype=numpy.float64,ddof=1))


#Multi-Threaded
from joblib import Parallel, delayed
import multiprocessing

def prll(chunk,chainSize):
    for i in range(len(chunk)):
        chunk[i]=countChains(chainSize)
    return chunk

if __name__ == '__main__':
    [n,its]=main(sys.argv[1:])
    
    num_cores = int(multiprocessing.cpu_count())

    its=its-its%num_cores

    inputs=[None]*num_cores

    for i in range(num_cores):
        inputs[i]=numpy.empty(its/num_cores,dtype=int)

    results = Parallel(n_jobs=num_cores)(delayed(prll)(x,n) for x in inputs)
    del inputs

    v=numpy.concatenate(results)
    del results

    print(its,' iterations, ','N = ',n,sep='')
    print('Sample Mean: ',"{0:.10f}".format(numpy.mean(v,dtype=numpy.float64)))
    print('Sample Std Dev: ',"{0:.10f}".format(numpy.std(v,dtype=numpy.float64,ddof=1)))
