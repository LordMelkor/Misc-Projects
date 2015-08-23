clear; clc;
load('fixbysub.mat')

i=0;
plotmat1=[];
for n=1:length(s)
    ind=find(s(n).gambleid==1);
    indlength=length(ind);
    totdur=s(n).start(max(ind))-s(n).start(min(ind));
    
    for j=1:indlength
        i=i+1;
        [tempx,tempy]=transdex(s(n).realcell(ind(j)));
        if tempx ~=0 && tempy ~=0
            tempxyz(1,1)=tempx;
            tempxyz(1,2)=tempy;
            tempxyz(1,3)=(s(n).start(ind(j))-s(n).start(min(ind)))/totdur;
            plotmat1=[plotmat1;tempxyz];
            clear tempx tempy tempxyz
        else
            clear tempx tempy
        end
        %plotmat2(i,1)=s(n).x(ind(j));
        %plotmat2(i,2)=s(n).y(ind(j));
        %plotmat2(i,3)=(s(n).start(ind(j))-s(n).start(min(ind)))/totdur;
    end
    clear totdur;
end
clear i j n ind indlength;

figure(1)
scatter3(plotmat1(:,1),plotmat1(:,2),plotmat1(:,3))
xlabel('x')
ylabel('y')
zlabel('t')

%[coeff,score,latent,tsquared,explained,mu] =pca(plotmat1);

%{
for i=1:length(plotmat1)
    plotmatr(i,:)=plotmat1(i,:)+.23*[randn(1,2), 0];
end
clear i;

figure(2)
scatter3(plotmatr(:,1),plotmatr(:,2),plotmatr(:,3))
xlabel('x')
ylabel('y')
zlabel('t')

coeff2=pca(plotmatr)
%}

%{
figure(2)
scatter3(plotmat2(:,1),plotmat2(:,2),plotmat2(:,3))
xlabel('x')
ylabel('y')
zlabel('t')
%}