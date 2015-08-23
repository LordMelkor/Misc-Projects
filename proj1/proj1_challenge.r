library(sqldf)
library(plyr)
library(ggplot2)
#library(xlsx)

#Import and format data

#filePath = "~/Public/Dropbox/proj1/project_data.tsv"

qdata = data.frame(read.delim(filePath, na.strings = "NULL"))
qdata = rename(qdata, c("Revenue..USD."="RevenueUSD"))
qdata$Date = as.Date(qdata$Date,"%d/%m/%Y") #R date origin is 1970-01-01
qdata$Pageviews = as.numeric(qdata$Pageviews)
qdata$Visits = as.numeric(qdata$Visits)
qdata$Conversions = as.numeric(qdata$Conversions)
qdata=sqldf("select * from qdata order by Date, Country, Device")

qdata1 = sqldf("select *, 
                conversions/visits as ConvRate, 
                pageviews/visits as Engagement, 
                RevenueUSD/Conversions as avg_Order_val
                from qdata")
qdata1$avg_Order_val = as.numeric(qdata1$avg_Order_val)

summary(qdata1)
str(qdata1)

#Overall Stats, by Country in 1 year

OverallStats_country0 = sqldf("select Date, Country, 
                             sum(Conversions) as Conversions, 
                             sum(Visits) as Visits, 
                             sum(pageviews) as Pageviews, 
                             sum(RevenueUSD) as RevenueUSD,
                             sum(Conversions)/sum(Visits) as ConvRate,
                             sum(Pageviews)/sum(Visits) as Engagement,
                             sum(RevenueUSD)/sum(Conversions) as avg_Order_val
                             from qdata1 
                             group by Date, Country")
OverallStats_country0$avg_Order_val = as.numeric(OverallStats_country0$avg_Order_val)

OverallStats_country = sqldf("select Country, 
                             sum(Conversions)/365 as Conversions_avg, 
                             sum(Visits)/365 as Visits_avg, 
                             sum(pageviews)/365 as Pageviews_avg, 
                             sum(RevenueUSD)/365 as Revenue_avg, 
                             sum(Conversions)/sum(Visits) as ConvRate,
                             sum(Pageviews)/sum(Visits) as Engagement, 
                             sum(RevenueUSD)/sum(Conversions) as avg_Order_val, 
                             sum(RevenueUSD) as totRev
                              from OverallStats_country0 
                              group by Country")
OverallStats_country$avg_Order_val = as.numeric(OverallStats_country$avg_Order_val)

#Low Conversion Rate, High Visits

visCutoff = quantile(OverallStats_country$Visits_avg)[[4]]
crCutoff = quantile(OverallStats_country$ConvRate)[[3]]

CR_opp = fn$sqldf("select * 
                    from OverallStats_country 
                  where ConvRate < $crCutoff and Visits_avg > $visCutoff
                  order by ConvRate")

CR_opp1 = fn$sqldf("select *, 
                ($crCutoff-ConvRate)*Visits_avg*avg_Order_val as dailyRevOpp, 
                ($crCutoff-ConvRate)*Visits_avg*avg_Order_val*365 as annualRevOpp
                  from CR_opp
                  order by annualRevOpp desc")

bubblePlot <- ggplot(CR_opp1, aes(x=ConvRate, y=Visits_avg, size=annualRevOpp, label=Country),guide=FALSE)+
  geom_point(colour="white", fill="aquamarine2", shape=21, alpha=0.75)+ 
  scale_size_area(max_size = 25)+
  ggtitle("Conversion Rate Opportunity")+
  scale_x_continuous(name="Conversion Rate", limits=c(0,0.006))+
  scale_y_continuous(name="Average Daily Visits", limits=c(0,12500))+
  geom_text(data=head(CR_opp1,3), aes(ConvRate,Visits_avg,label=Country), size=4)+
  guides(size=guide_legend(title="Potential Annual \nRevenue Lift (USD)"))+
  theme_bw()
#ggsave("bubblePlot.pdf", bubblePlot, scale=1)

#library(xlsx)
#write.xlsx(CR_opp1, "/Users/krishanuar/Public/Dropbox/qubit/cr_opp1.xlsx")


#High Conversion Rate, Low Visits
vc2 = quantile(log(OverallStats_country$Visits_avg))[[2]]
vc3 = quantile(log(OverallStats_country$Visits_avg))[[3]]

views_opp = fn$sqldf("select * 
                    from OverallStats_country 
                    where ConvRate > $crCutoff and (Visits_avg>$vc2 and Visits_avg<$vc3)
                    order by ConvRate desc")

OverallStats_country1 = OverallStats_country[OverallStats_country$Conversions_avg>0,]
#write.xlsx(OverallStats_country1, "C:/Users/KrishanuAR/Dropbox/Qubit/OverallStats_country1.xlsx")

hist(log(OverallStats_country1$Conversions_avg))
hist(OverallStats_country1$Engagement)
hist(log(OverallStats_country1$ConvRate))

cor(log(OverallStats_country1$Conversions_avg),OverallStats_country1$Engagement)

plot(OverallStats_country1$Engagement, log(OverallStats_country1$Conversions_avg),
      xlab="Engagement by Country",
      ylab="log(Avg Conversions) by Country", main="Engagement vs Conversion")
fit = lm(log(OverallStats_country1$Conversions_avg)~OverallStats_country1$Engagement)
summary(fit)
abline(fit, col="red")

#Engagement opportunity: High visits, Low Engagement
engCutoff = quantile(OverallStats_country$Engagement)[[3]]

Eng_opp = fn$sqldf("select * 
                    from OverallStats_country 
                    where Visits_avg > $visCutoff and Engagement < $engCutoff
                    order by Engagement")

Eng_opp$annualRevOpp= exp(1.5933*(engCutoff-Eng_opp$Engagement))*Eng_opp$avg_Order_val*365
#write.xlsx(Eng_opp, "C:/Users/KrishanuAR/Dropbox/Qubit/Eng_opp.xlsx")

#Low Conversion, High Engagement
LcHe_opp = fn$sqldf("select * 
                    from OverallStats_country 
                    where ConvRate < $crCutoff and Engagement > $engCutoff
                    order by ConvRate")

#Low avg_Order_val, High Conversion Rate

ovCutoff=quantile(OverallStats_country1$avg_Order_val)[[3]]

orderVal_opp = fn$sqldf("select * 
                    from OverallStats_country 
                   where ConvRate > $crCutoff and avg_Order_val < $ovCutoff
                   order by avg_Order_val")



#Overall Stats by Device in 1 year

OverallStats_device0 = sqldf("select Country, Device,
                             sum(Conversions)/365 as Conversions_avg, 
                             sum(Visits)/365 as Visits_avg, 
                             sum(pageviews)/365 as Pageviews_avg, 
                             sum(RevenueUSD)/365 as Revenue_avg,
                             sum(Conversions)/sum(Visits) as ConvRate,
                             sum(Pageviews)/sum(Visits) as Engagement,
                             sum(RevenueUSD)/sum(Conversions) as avg_Order_val
                             from qdata1 
                             group by Country, Device
                             having Conversions_avg>0")
OverallStats_device0$avg_Order_val = as.numeric(OverallStats_device0$avg_Order_val)

OverallStats_device = sqldf("select Device,
                            sum(Conversions)/365 as Conversions_avg, 
                            sum(Visits)/365 as Visits_avg, 
                            sum(pageviews)/365 as Pageviews_avg, 
                            sum(RevenueUSD)/365 as Revenue_avg,
                            sum(Conversions)/sum(Visits) as ConvRate,
                            sum(Pageviews)/sum(Visits) as Engagement,
                            sum(RevenueUSD)/sum(Conversions) as avg_Order_val
                            from qdata1 
                            group by Device")
OverallStats_device$avg_Order_val = as.numeric(OverallStats_device$avg_Order_val)

boxplot(log(OverallStats_device0$ConvRate) ~ OverallStats_device0$Device,main="Conversions Rate from Device", xlab="Device", ylab="log(Conversion Rate)", col="cadetblue3")
summary(aov(log(OverallStats_device0$ConvRate) ~ OverallStats_device0$Device))

notMobile=OverallStats_device0[OverallStats_device0$Device!="mobile",]
isMobile=OverallStats_device0[OverallStats_device0$Device=="mobile",]

crDiff=abs(quantile(isMobile$ConvRate)[[3]]-quantile(notMobile$ConvRate)[[3]])
overall_Visits=mean(OverallStats_device0$Visits_avg)
overall_avg_Order_val=mean(OverallStats_device0$avg_Order_val)

crDiff*overall_Visits*overall_avg_Order_val*365




cd0 = na.omit(OverallStats_country0)
cd1 = sqldf("select Country, 
                             sum(log(Conversions))/365 as Conversions_avg, 
                             sum(log(Visits))/365 as Visits_avg, 
                             sum(log(pageviews))/365 as Pageviews_avg, 
                             sum(log(RevenueUSD))/365 as Revenue_avg, 
                             sum(log(Conversions))/sum(log(Visits)) as ConvRate,
                             sum(log(Pageviews))/sum(log(Visits)) as Engagement, 
                             sum(log(RevenueUSD))/sum(log(Conversions)) as avg_Order_val, 
                             sum(log(RevenueUSD)) as totRev
                              from cd0
                              where RevenueUSD>0
                              group by Country")
cd1$avg_Order_val = as.numeric(cd1$avg_Order_val)
cd1 = na.omit(cd1)
cd1 = scale(cd1)
row.names(cd1)<-cd1[, 1]
cd1=cd1[, 2:9]

# Ward Hierarchical Clustering
d <- dist(cd1, method = "euclidean") # distance matrix
fit_cluster <- hclust(d, method="ward")
plot(fit_cluster) # display dendogram
groups <- cutree(fit_cluster, k=9) # cut tree into 5 clusters
# draw dendogram with red borders around the 5 clusters
rect.hclust(fit_cluster, k=9, border="red")