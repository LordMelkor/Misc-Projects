function [c]=interleave(a,b)
c=[0 0];
index=1;
indexa=1;
indexb=1;

while index <= length(a)+length(b)
	if indexa <= length(a)
		c(index)=a(indexa);
		indexa=indexa+1;
		index=index+1;
	end
	if indexb <= length(b)
		c(index)=b(indexb);
		indexb=indexb+1;
		index=index+1;
	end
end