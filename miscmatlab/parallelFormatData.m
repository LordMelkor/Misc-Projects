matlabpool local
load('fixationdata.mat');

subjects=unique(fixationdata.Subid);

parfor i=1:length(subjects)
    ind=find(fixationdata.Subid==subjects(i));
    indlength=length(ind);
    varnm=fieldnames(fixationdata);
    varnm=varnm(1:end-1);
    for n=1:length(varnm)
        s(i).(varnm{n})=zeros(indlength,1,'double');
    end
    %{
    s(i).start=zeros(indlength,1,'double');
    s(i).duration=zeros(indlength,1,'double');
    s(i).x=zeros(indlength,1,'double');
    s(i).y=zeros(indlength,1,'double');
    s(i).cell=zeros(indlength,1,'double');
    s(i).realcell=zeros(indlength,1,'double');
    s(i).col=zeros(indlength,1,'double');
    s(i).row=zeros(indlength,1,'double');
    s(i).gambleid=zeros(indlength,1,'double');
    s(i).gamborder=zeros(indlength,1,'double');
    s(i).eveq=zeros(indlength,1,'double');
    s(i).evtype=zeros(indlength,1,'double');
    s(i).prob=zeros(indlength,1,'double');
    s(i).maxwchoice=zeros(indlength,1,'double');
    s(i).minlchoice=zeros(indlength,1,'double');
    s(i).evchoice=zeros(indlength,1,'double');
    s(i).opchoice=zeros(indlength,1,'double');
    %}
    for j=1:indlength
        for n=1:length(varnm)
            s(i).(varnm{n})(j)=fixationdata.(varnm{n})(ind(j));
        end
        %{
        s(i).start(j)=fixationdata.start(ind(j));
        s(i).duration(j)=fixationdata.duration(ind(j));
        s(i).x(j)=fixationdata.x(ind(j));
        s(i).y(j)=fixationdata.y(ind(j));
        s(i).cell(j)=fixationdata.cell(ind(j));
        s(i).realcell(j)=fixationdata.realcell(ind(j));
        s(i).col(j)=fixationdata.col(ind(j));
        s(i).row(j)=fixationdata.row(ind(j));
        s(i).gambleid(j)=fixationdata.gambleid(ind(j));
        s(i).gamborder(j)=fixationdata.gamborder(ind(j));
        s(i).eveq(j)=fixationdata.eveq(ind(j));
        s(i).evtype(j)=fixationdata.evtype(ind(j));
        s(i).prob(j)=fixationdata.prob(ind(j));
        s(i).evchoice(j)=fixationdata.evchoice(ind(j));
        s(i).maxwchoice(j)=fixationdata.maxwchoice(ind(j));
        s(i).minlchoice(j)=fixationdata.minlchoice(ind(j));
        s(i).opchoice(j)=fixationdata.opchoice(ind(j));
        %}
    end
end

for i=1:length(s)
    tmp=struct2dataset(s(i));
    tmp=sortrows(tmp,'start');
    s(i)=dataset2struct(tmp,'AsScalar',true);
end

clear i j ind tmp n varnm subjects;

matlabpool close