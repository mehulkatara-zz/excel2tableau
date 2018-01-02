setwd("T:\\Tableau_BankProject")

url="http://srvmanager.tmsys.in:81/ServerManagerTmspl/dashboardtm/getDataApi"

download.file(url,"datacenter.json",quiet = TRUE, mode = "w")

library(jsonlite)

mydf = fromJSON("datacenter.json",simplifyVector = TRUE)

mydf = mydf[["server_data"]]

library(RMySQL)

mydb = dbConnect(MySQL(), user='tmspl', password='tmsystem@321', dbname='ServerDashboard', host='192.168.52.208')

dbGetQuery(mydb, "DROP TABLE `server_info`;")

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

dbWriteTable(mydb, name='server_info', value=mydf,append=TRUE)

dbDisconnect(mydb)
