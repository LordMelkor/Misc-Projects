library(XML)
library(sqldf)
library(plyr)
options(digits=10)

# convert list to data frame from:
# http://stackoverflow.com/a/17309310/2305709
rbind.named.fill <- function(x) {
  nam <- sapply(x, names)
  unam <- unique(unlist(nam))
  len <- sapply(x, length)
  out <- vector("list", length(len))
  for (i in seq_along(len)) {
    out[[i]] <- unname(x[[i]])[match(unam, nam[[i]])]
  }
  setNames(as.data.frame(do.call(rbind, out), stringsAsFactors=FALSE), unam)
}

workDir = "C:/Users/KrishanuAR/Documents/Texts/dataincubator"

setwd(workDir)

xmlfile=xmlParse("Posts.xml")
xml_data=xmlToList(xmlRoot(xmlfile))
posts=rbind.named.fill(xml_data)

posts <- transform(posts, Id = as.integer(Id),
                   PostTypeId = as.factor(as.integer(PostTypeId)),
                   AcceptedAnswerId = as.integer(AcceptedAnswerId),
                   Score = as.integer(Score),
                   ViewCount = as.integer(ViewCount),
                   OwnerUserId = as.integer(OwnerUserId),
                   AnswerCount = as.integer(AnswerCount),
                   CommentCount = as.integer(CommentCount),
                   FavoriteCount = as.integer(FavoriteCount),
                   LastEditorUserId = as.integer(LastEditorUserId),
                   ParentId = as.integer(ParentId),
                   CreationDate = as.POSIXct(strptime(CreationDate, "%Y-%m-%dT%H:%M:%S",tz="GMT")),
                   LastActivityDate = as.POSIXct(strptime(LastActivityDate, "%Y-%m-%dT%H:%M:%S",tz="GMT")),
                   LastEditDate = as.POSIXct(strptime(LastEditDate, "%Y-%m-%dT%H:%M:%S",tz="GMT")),
                   CommunityOwnedDate = as.POSIXct(strptime(CommunityOwnedDate, "%Y-%m-%dT%H:%M:%S",tz="GMT")),
                   ClosedDate = as.POSIXct(strptime(ClosedDate, "%Y-%m-%dT%H:%M:%S",tz="GMT")))

xmlfile=xmlParse("Users.xml")
xml_data=xmlToList(xmlRoot(xmlfile))
users=rbind.named.fill(xml_data)

users <- transform(users, Id = as.integer(Id),
                   Reputation = as.integer(Reputation),
                   Views = as.integer(Views),
                   UpVotes = as.integer(UpVotes),
                   DownVotes = as.integer(DownVotes),
                   AccountId = as.integer(AccountId),
                   Age = as.integer(Age),
                   CreationDate = as.POSIXct(strptime(CreationDate, "%Y-%m-%dT%H:%M:%S",tz="GMT")),
                   LastAccessDate = as.POSIXct(strptime(LastAccessDate, "%Y-%m-%dT%H:%M:%S",tz="GMT")))



xmlfile=xmlParse("Tags.xml")
xml_data=xmlToList(xmlRoot(xmlfile))
tags=rbind.named.fill(xml_data)

tags <- transform(tags, Id = as.integer(Id),
                  TagName = paste("<",TagName,">",sep=""),
                  Count = as.integer(Count),
                  ExcerptPostId = as.integer(ExcerptPostId),
                  WikiPostId = as.integer(WikiPostId))

# What fraction of posts contain the 5th most popular tag?

tag5=sqldf("select TagName, Count from tags order by Count desc")[5,1]
fn$sqldf("select  cast(count(*) as real)/(select count(*) from posts) as frac from posts where Tags like '%`tag5`%'")

# How much higher is the average answer's score than the average question's?

qScore=sqldf("select avg(score) from posts where PostTypeId=1")[1,1]
aScore=sqldf("select avg(score) from posts where PostTypeId=2")[1,1]
aScore-qScore


# What is the Pearson's correlation between a user's reputation and total score from posts (for valid users)?

users1=sqldf("select *, UpVotes-DownVotes as Score from users where Id>0")

cor(users1$Reputation, users1$Score, method="pearson")

# How many more upvotes does the average answer receive than the average question?
#????


# We are interested in what time of the day one should post to get a fast accepted response. Look at the median response time of the accepted answer as a function of the question post hour (from 0 to 23 inclusive). The response time is the length of time in between when the question was first posted and when the accepted answer was first posted in hours (as a decimal). What is the difference between the largest and smallest median response times across question post hours?

# We would like to understand which actions lead to which other actions on stats overflow. For each valid user, create a chronological history of when the user took one of these three actions: posing questions, answering questions, or commenting. For each of these three possible actions, compute the unconditional probability of each action (three total) as well as the probability conditioned on the immediately preceding action (nine total). What is the largest quotient of the conditional probability of an action divided by its unconditioned probability?




