library(ggplot2)
library(reshape2)
library(sqldf)

setwd("~/Public/Dropbox/proj2/")

#Import Data
stratops = read.csv("proj2_DATA.csv")
stratops <- transform(stratops,
                      trial_date = as.Date(trial_date, "%m/%d/%Y"),
                      subscription_date = as.Date(subscription_date, "%m/%d/%Y"))
str(stratops)

#Convert Data into a time-series
ts=data.frame()
for(i in 0:30) {
  denom=as.numeric(nrow(subset(stratops, trial_date == as.Date("2013-05-01")+i)))
  tx=subset(stratops,!is.na(subscription_date) & trial_date==as.Date("2013-05-01")+i)
  isWknd=ifelse(tx$day_of_week[[1]]=='Saturday'||tx$day_of_week[[1]]=='Sunday',1,0)
  tx=sqldf("select *, case when subscription_date>0 then subscription_date-trial_date end as days from tx order by days")
  tx=sqldf(paste("select ","'Cohort_",ifelse(i+1<10,0,""),i+1,"' as cohort,",isWknd," as isWknd,"," days, count(*) as cnt from tx group by days order by days", sep=""))
  tx$cumsum=cumsum(tx$cnt)
  tx$cohortSize=denom*rep(1, nrow(tx))
  tx$cr=tx$cumsum/denom
  ts=rbind(ts,tx)
}
rm(tx)


#Plot Data

ggplot(data = ts, aes(x=days, y=cr)) + geom_line(aes(colour=cohort))+ 
  geom_smooth(method='lm',formula=y~I(log(x+1)))

ts.sub=subset(ts, cohort=='Cohort_18')
ggplot(data = ts.sub, aes(x=days, y=cr)) + geom_line(aes(colour=cohort))+ 
  geom_smooth(method='lm',formula=y~1+I(1/(x+6)))

ts.sub=subset(ts, cohort=='Cohort_01')
ggplot(data = ts.sub, aes(x=days, y=cr)) + geom_line(aes(colour=cohort))+ 
  geom_smooth(method='lm',formula=y~I(1/(x+6)))+
  scale_x_continuous(limits = c(0, 155))


myrange=data.frame(days=c(1:155))

ts.sub=subset(ts, cohort=='Cohort_01' & days<=7)
model=lm(cr ~ I(1/(days+6.5)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")

ts.sub=subset(ts, cohort=='Cohort_01' & days<14)
model=lm(cr ~ I(1/(days+6.5)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")


ts.sub=subset(ts, cohort=='Cohort_01' & days<=30)
model=lm(cr ~ I(1/(days+6.5)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")

ts.sub=subset(ts, cohort=='Cohort_01' & days<=60)
model=lm(cr ~ I(1/(days+6.5)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")

ts.sub=subset(ts, cohort=='Cohort_01' & days<=90)
model=lm(cr ~ I(1/(days+6.5)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")

ts.sub=subset(ts, cohort=='Cohort_01' & days<=120)
model=lm(cr ~ I(1/(days+6.5)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")

ts.sub=subset(ts, cohort=='Cohort_01' & days<=150)
model=lm(cr ~ I(1/(days+6.5)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")


ts.sub=subset(ts, cohort=='Cohort_21' & days>=13 & days<=21)
model=lm(cr ~ I(1/(days+1)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")

ts.sub=subset(ts, cohort=='Cohort_21' & days>=13 & days<=30)
model=lm(cr ~ I(1/(days+1)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")

ts.sub=subset(ts, cohort=='Cohort_21' & days>=13 & days<=60)
model=lm(cr ~ I(1/(days+1)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")

ts.sub=subset(ts, cohort=='Cohort_21' & days>=13 & days<=90)
model=lm(cr ~ I(1/(days+1)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")

ts.sub=subset(ts, cohort=='Cohort_21' & days>=13 & days<=120)
model=lm(cr ~ I(1/(days+1)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")

ts.sub=subset(ts, cohort=='Cohort_21' & days>=13 & days<=150)
model=lm(cr ~ I(1/(days+1)), data=ts.sub)
fitting=predict(model, newdata=myrange)
plot(ts.sub$days,ts.sub$cr, type = "l",xlim=c(0, 155), xlab = "Time", ylim=c(0, 0.25), ylab = "Freq")
lines(fitting,col="red")


# library(dynsurv)

# names=list()
# for(i in 1:31){
# names=c(names, paste("Cohort_", i, sep = ""))
# }
# df=data.frame(matrix(ncol = 31, nrow = 31))
# colnames(df)<-names
# 
# for(i in 0:30) {
# denom=as.numeric(nrow(subset(stratops, trial_date == as.Date("2013-05-01")+i)))
# for(j in i:30) {
# df[[i+1]][[j-i+1]]=as.numeric(nrow(subset(stratops, trial_date == as.Date("2013-05-01")+i & !is.na(subscription_date) & subscription_date<=as.Date("2013-05-01")+j)))/denom
# }
# }
# df$day=1:31
# df2=melt(df, id.vars = "day")
# colnames(df2)<-c('day','cohort','count')
# 
# ggplot(data = df2, aes(x=day, y=count)) + geom_line(aes(colour=cohort))+ 
# geom_smooth(method='lm',formula=y~1+I(log(x)))
# 
# df3=data.frame(sapply(df, function(x) ifelse(!is.na(x), x-min(x,na.rm=TRUE), NA)))
# df3$day=1:31
# df4=melt(df3, id.vars = "day")
# colnames(df4)<-c('day','cohort','count')
# 
# ggplot(data = df4, aes(x=day, y=count)) + geom_line(aes(colour=cohort))+ 
# geom_smooth(method='lm',formula=y~I(x^(1/3)))


# library(survival)
# survData=sqldf("select id, case when subscription_date>0 then 1 else 0 end as status, case when subscription_date>0 then subscription_date-trial_date end as days from stratops")
# csurv = with(survData, Surv(days,status==1))
# mean(csurv[,1])
# 
# cfit <- survfit(Surv(days,status)~1, data = survData)
# summary(cfit)

# trainData = df[733:1464,]
# trainData1=sqldf("select Var1, Freq, day, hour, hour_cat from trainData order by Var1")
# predictData =df[1:732,]

# trainedModel=lm(count ~ sqrt(day)+log(day), data=df4)
# summary(trainedModel)
# 
# predictModel=predict(trainedModel, newdata=df4)
# 
# plot(df4$day,df4$count)
# lines(predictModel,col="red")
# 
# model=lm(Freq ~ day*hour_cat, data=df)
# summary(model)
# 
# fcast=predict(model, newdata=df)
# plot(logins_hr, type = "l", xlab = "Time", ylab = "Freq")
# lines(fcast,col="red")