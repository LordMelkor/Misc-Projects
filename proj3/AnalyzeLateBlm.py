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

bloomers=['01d67d466030764d09a118d468d10573','02919b82db82473de8a3725041c6a85f','0e7775aa886a24b0a6be6ea8f3a11616','d40b6483005bb07dd6c5b3341b215ed1','26c4c36d576c5d61093fd7034a906460']

bloompost_data=[]
for result in db.bz_daily.find({"bzid": {"$in": bloomers}},{"bzid": 1,"bz": 1,"hours": 1}).limit(5):
    bloompost_data.append([result['bzid'],result['bz'],result['hours'][0]])
