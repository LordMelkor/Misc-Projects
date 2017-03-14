#import sys
import random
	
def player(x):
	choice=random.random()
	if choice>x:
		return choice
	else:
		choice=random.random()
		return choice

def simul(p1,p2,n):
	wins=[0,0]
	i=0
	while i<n:
		if player(p1)>player(p2):
			wins[0]+=1
		else:
			wins[1]+=1
		i+=1
	return wins

def main():
	#n=int(sys.argv[1])
	
	p1=0.75
	p2=0.75
	n=1000000
	ans=simul(p1,p2,n)
	ratio=ans[0]/ans[1]
	
	print('For {0} iterations the wins for P1={1} and P2={2} look like {3} and Ratio: {4}'.format(n,p1,p2,ans,ratio))

if __name__ == "__main__":
    main()