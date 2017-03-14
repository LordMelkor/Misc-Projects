import sys
import random

def flipper(sol):
	arrSize=len(sol[0])
	seq=[None]*arrSize
	counter = 0
	while (seq != sol[0]) and (seq != sol[1]):
		coin_flip = random.randrange(2)
		seq.pop(0)
		seq.append(coin_flip)
		counter+=1
	if seq == sol[0]:
		return [counter, sol[0]]
	else:
		return [counter, sol[1]]

def simul(sol,n):
	avg=[None,None]
	avgPrv=[0,0]
	for it in range(1, n+1):
		currFlip=flipper(sol)
		if currFlip[1]==sol[0]:
			avg[0]=avgPrv[0] + (currFlip[0]-avgPrv[0])/it
			avgPrv[0]=avg[0]
		else:
			avg[1]=avgPrv[1] + (currFlip[0]-avgPrv[1])/it
			avgPrv[1]=avg[1]
	return avg

def main():
	n=int(sys.argv[1])
	# Heads == 1; Tails == 0
	sol=[[1,1,0],[1,0,0]]
	
	ans=simul(sol,n)
	
	print('For {0} iterations the average number of turns until each sequence is reached for {1} is {2}'.format(n,sol,ans))

if __name__ == "__main__":
    main()