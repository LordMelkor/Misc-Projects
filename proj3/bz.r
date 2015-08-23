setwd("C:\\Users\\KrishanuAR\\Documents\\Texts\\bz")
library(sqldf)
library(xlsx)

tu <- read.table("topUIDs.txt", sep="\t", header=TRUE)
topPostDict <- read.table("topPostDict.txt", sep="\t", header=TRUE)
topPostDict <- sqldf("select distinct bzid, bz from topPostDict")
topPosts <- read.table("topPosts.txt", sep="\t", header=TRUE, stringsAsFactors=FALSE)
tp <-sqldf("select a.userid, b.bz, a.bzid, a.count, a.hours from topPosts a left join topPostDict b on a.bzid=b.bzid")

for(i in 1:nrow(tp)) {
  tp$hours[i]<- parse(text=gsub("\\[","c\\(", gsub("\\]","\\)",tp$hours[i])))
}

lateBloomerData <- read.table("lateBloom.txt", sep="\t", header=TRUE, stringsAsFactors=FALSE)
lb <- sqldf("select a.userid, b.bz, a.bzid, a.peak, a.traffic, a.hours from lateBloomerData a left join topPostDict b on a.bzid=b.bzid")

pdf("plots.pdf",width=11,height=8.5)
for (i in 1:nrow(tp)){
  plot(eval(tp$hours[i]), xlab="Hour of Day",ylab="Total Traffic", type="o", col="blue")
  title(main=tp$bz[i],cex.main=0.75, line=1)
  mtext(text=paste("UserID:", tp$userid[i], sep = " "), side=3, line=1.75, font=2) 
}
dev.off()

tp1<- subset(tp, select = c(userid, bz, bzid, count))


wb <- createWorkbook()

sheet1  <- createSheet(wb, sheetName="Top UserIDs")
addDataFrame(tu, sheet1, row.names=FALSE)

sheet2  <- createSheet(wb, sheetName="Top Posts")
addDataFrame(tp1, sheet2, row.names=FALSE)

sheet3  <- createSheet(wb, sheetName="Late Bloomers")
addDataFrame(lb, sheet3, row.names=FALSE)

saveWorkbook(wb, file="Results.xlsx")