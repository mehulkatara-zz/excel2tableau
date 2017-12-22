setwd("T:\\Tableau_BankProject")
url="http://srvmanager.tmsys.in:81/ServerManagerTmspl/dashboardtm/getDataApi"
download.file(url,"datacenter.json",quiet = TRUE, mode = "w")
