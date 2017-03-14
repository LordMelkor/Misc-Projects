import random

def flipper(sol):
	arrSize=len(sol)
	seq=[None]*arrSize
	counter = 0
	while seq != sol:
		coin_flip = random.randrange(2)
		seq.pop(0)
		seq.append(coin_flip)
		counter+=1
	return counter

def simul(sol,n):
	avgPrv=0
	for it in range(1, n+1):
		currCount=flipper(sol)
		avg=avgPrv + (currCount-avgPrv)/it #computes running average
		avgPrv=avg
	return avg

def main():
	n=100000
	# Heads == 1; Tails == 0
	sol1=[1,1,0]
	sol2=[1,0,0]
	
	ans1=simul(sol1,n)
	ans2=simul(sol2,n)
	
	print('For {0} iterations the average number of turns until sequence reached for {1} is {2}'.format(n,sol1,ans1))
	print('For {0} iterations the average number of turns until sequence reached for {1} is {2}'.format(n,sol2,ans2))

if __name__ == "__main__":
    main()