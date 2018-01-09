log=data.frame()
log[1,1]=data.frame(startdatetime=format(Sys.time(), "%y-%m-%d %X"))
log[1,2]=data.frame(scriptname="jsontomysql.r")

library(RMySQL)

mydb = dbConnect(MySQL(), user='tmspl', password='tmsystem@321', dbname='ServerDashboard', host='192.168.52.208')


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

#extract hours,minutes and seconds
hours <- as.numeric(gsub('^(?:.* )?([0-9]+)h.*$','\\1',mydf[,5]))
minutes <- as.numeric(gsub('^.* ([0-9]+)m.*$','\\1',mydf[,5]))
seconds <- as.numeric(gsub('^.* ([0-9]+)s.*$','\\1',mydf[,5]))

#convert to seconds
mydf[,5] <- seconds + 60*minutes + 60*60*hours

#adding seconds in last update time
mydf[,9] <- mydf[,5]+as.POSIXct(mydf[,6])

# Converting remaining bytes in numeric format
mydf$remaining_bytes=as.numeric(mydf$remaining_bytes) 

#Converting the bytes into KB,MB,GB,TB
mydf$convert<-ifelse(mydf$remaining_bytes>=0&mydf$remaining_bytes<1024,rr2<-mydf$remaining_bytes,
                     ifelse(mydf$remaining_bytes>=1024&mydf$remaining_bytes<(1024*1024),rr2<-mydf$remaining_bytes/1024,
                            ifelse(mydf$remaining_bytes>=(1024*1024)&mydf$remaining_bytes<(1024*1024*1024),rr2<-mydf$remaining_bytes/(1024*1024), 
                                   ifelse(mydf$remaining_bytes>=(1024*1024*1024)&mydf$remaining_bytes<(1024*1024*1024*1024),rr2<-mydf$remaining_bytes/(1024*1024*1024), rr2<-mydf$remaining_bytes/(1024*1024*1024*1024)))))



mydf$convert=formatC(mydf$convert, format="f", digits=2) #Converting into float upto 2 decimal points.

#for Naming

mydf$unit<-ifelse(mydf$remaining_bytes>=0&mydf$remaining_bytes<1024,rr2<-"Bytes",
                  ifelse(mydf$remaining_bytes>=1024&mydf$remaining_bytes<(1024*1024),rr2<-"KB",
                         ifelse(mydf$remaining_bytes>=(1024*1024)&mydf$remaining_bytes<(1024*1024*1024),rr2<-"MB", 
                                ifelse(mydf$remaining_bytes>=(1024*1024*1024)&mydf$remaining_bytes<(1024*1024*1024*1024),rr2<-"GB", rr2<-"TB"))))

mydf$new_remaining_bytes <- paste(mydf$convert,mydf$unit)
names(mydf)[9]<-paste("estimated_time")
names(mydf)[10]<-paste("converted_data")

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
           `remaining_time` int(225) DEFAULT NULL,
           `last_update_date_time` datetime DEFAULT NULL,
           `replication_status` varchar(225) DEFAULT NULL,
           `prev_last_updated_time` datetime DEFAULT NULL,
           `estimated_time` datetime DEFAULT NULL,
           `converted_data` float DEFAULT NULL,
           `unit` char(1) DEFAULT NULL,
           `new_remaining_bytes` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
           ")

#saving dataframe to mysql
dbWriteTable(mydb, name='server_info', value=mydf,append=TRUE)

log[1,3]=data.frame(stopdatetime=format(Sys.time(), "%y-%m-%d %X"))

dbWriteTable(mydb, name='R log', value=log,append=TRUE,row.names = FALSE)
#closeing database connection
dbDisconnect(mydb)
