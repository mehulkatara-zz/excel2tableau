#setting working directory 
setwd("T:\\Tableau_BankProject")

#link of the json file
url="http://srvmanager.tmsys.in:81/ServerManagerTmspl/dashboardtm/getDataApi"

#download json file
download.file(url,"datacenter.json",quiet = TRUE, mode = "w")

library(jsonlite)

#reading json file
mydf = fromJSON("datacenter.json",simplifyVector = TRUE)

# removeing unnecessary data and store to dataframe
mydf = mydf[["server_data"]]

#Replace N/A with blank
mydf[] <- lapply(mydf[], gsub, pattern = 'N/A', replacement='')

#Replace space with :
mydf[5]=lapply(mydf[5],gsub, pattern=' ', replacement = ':')

#Replace alpha with blank
mydf[5]=lapply(mydf[5],gsub, pattern='[[:alpha:]]', replacement = '')

#Get current date
date=format(Sys.time(), "%Y-%m-%d")

#Current date store in dataframe
mydf[5]=lapply(mydf[5],function(x) paste(date, x,sep=" "))


library(RMySQL)

mydb = dbConnect(MySQL(), user='tmspl', password='tmsystem@321', dbname='ServerDashboard', host='192.168.52.208')

#delete existed table
dbGetQuery(mydb, "DROP TABLE `server_info`;")

#Create database table
dbGetQuery(mydb, "CREATE TABLE `server_info` (
  `row_names` int(225) DEFAULT NULL,
           `id` int(225) DEFAULT NULL,
           `lable` varchar(225) DEFAULT NULL,
           `status` varchar(225) DEFAULT NULL,
           `remaining_bytes` int(225) DEFAULT NULL,
           `remaining_time` time DEFAULT NULL,
           `last_update_date_time` datetime DEFAULT NULL,
           `replication_status` varchar(225) DEFAULT NULL,
           `prev_last_updated_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
           ")

#saving dataframe to mysql
dbWriteTable(mydb, name='server_info', value=mydf,append=TRUE)

#closeing database connection
dbDisconnect(mydb)
