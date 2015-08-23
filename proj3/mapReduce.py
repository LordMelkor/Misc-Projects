import os
import sys
from pymongo import MongoClient
from bson.code import Code

#Set Working Directory
os.chdir("C:\\Users\\KrishanuAR\\Documents\\Texts\\bz")
stdoutShell = sys.stdout

#Open a connection to MongDB (localhost)
client = MongoClient()
db = client.test

#Part 1

#load map and reduce
map = Code(open('uidMap.js','r').read())
reduce = Code(open('uidReduce.js','r').read())

#run map-reduce
db.bf_daily.map_reduce(map,reduce, "UIDresults")
UIDresults = db.UIDresults

#Print top UIDs to CSV

sys.stdout = open('topUIDs.txt', 'w')
print("userid\tcount")
for result in UIDresults.find().sort('value.count',-1).limit(5):
	print('{0}\t{1}'.format(result['_id']['userid'],result['value']['count']))
sys.stdout.close()
sys.stdout = stdoutShell

#Part 2

topUIDs=[]
for result in db.UIDresults.find().sort('value.count',-1).limit(5):
    topUIDs.append([result['_id']['userid'],result['value']['count']])

#Load Map and Reduce - pt2

#map = Code(open('postMap.js','r').read())
mapString = "function postMap()\n{\n\tvar key = {userid: this.userid, bzid: this.bzid};\n\tif (this.userid=="+repr(topUIDs[0][0])+" || this.userid=="+repr(topUIDs[1][0])+" || this.userid=="+repr(topUIDs[2][0])+" || this.userid=="+repr(topUIDs[3][0])+" || this.userid=="+repr(topUIDs[4][0])+")\n\t{\n\t\temit(key, {count: this.total, hours: this.hours});\n\t}\n\telse\n\t{\n\t\treturn;\n\t}\n}"
map = Code(mapString)

reduce = Code(open('postReduce.js','r').read())

#Run Map-Reduce
db.bf_daily.map_reduce(map,reduce, "postResults")

sys.stdout = open('topPosts.txt', 'w')
print("userid\tbzid\tcount\thours")
for i in range(len(topUIDs)):
    for result in db.postResults.find({"_id.userid": topUIDs[i][0]}).sort('value.count',-1).limit(5):
        print('{0}\t{1}\t{2}\t{3}'.format(result['_id']['userid'],result['_id']['bzid'],result['value']['count'],result['value']['hours']))
sys.stdout.close()
sys.stdout = stdoutShell

#Build Top Post Title Dictionary
topPostList=[]
for i in range(len(topUIDs)):
    for result in db.postResults.find({"_id.userid": topUIDs[i][0]}).sort('value.count',-1).limit(5):
        topPostList.append(result['_id']['bzid'])
topPostDict=[]
for result in db.bf_info.find({"bzid": {"$in": topPostList}},{"bzid": 1,"bz": 1}):
    topPostDict.append([result['bzid'],result['bz']])
#Entires in topPostDict aren't unique, but not important.
sys.stdout = open('topPostDict.txt', 'w')
print("bzid\tbz")
for i in range(len(topPostDict)):
    print('{0}\t{1}'.format(topPostDict[i][0],topPostDict[i][1]))
sys.stdout.close()
sys.stdout = stdoutShell

#Part 3

#load map and reduce
map = Code(open('blmMap.js','r').read())
reduce = Code(open('blmReduce.js','r').read())

db.postResults.map_reduce(map,reduce, "blmResults")

sys.stdout = open('lateBloom.txt', 'w')
print("userid\tbzid\tpeak\ttraffic\thours")
for i in range(len(topUIDs)):
    for result in db.blmResults.find({"_id.userid": topUIDs[i][0],}).sort('value.peak',-1).limit(1):
        print('{0}\t{1}\t{2}\t{3}\t{4}'.format(result['_id']['userid'],result['_id']['bzid'],result['value']['peak'],result['value']['views'],result['value']['hours']))
sys.stdout.close()
sys.stdout = stdoutShell

#Build Top Post Title Dictionary
topPostList=[]
for i in range(len(topUIDs)):
    for result in db.postResults.find({"_id.userid": topUIDs[i][0]}).sort('value.count',-1).limit(5):
        topPostList.append(result['_id']['bzid'])
    for result in db.blmResults.find({"_id.userid": topUIDs[i][0],}).sort('value.peak',-1).limit(1):
        topPostList.append(result['_id']['bzid'])

topPostDict=[]
for result in db.bf_info.find({"bzid": {"$in": topPostList}},{"bzid": 1,"bz": 1}):
    topPostDict.append([result['bzid'],result['bz']])

sys.stdout = open('topPostDict.txt', 'w')
print("bzid\tbz")
for i in range(len(topPostDict)):
    print('{0}\t{1}'.format(topPostDict[i][0],topPostDict[i][1]))
sys.stdout.close()
sys.stdout = stdoutShell