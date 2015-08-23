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

db.tester.aggregate([{$group:{
                                _id:{name:"$name",state:"$state"},
                                min:{$min:"$value"},
                                max:{$max:"$value"},
                               } },
                       {$out:"tester_max_min"}
                     ])