log=data.frame()
log[1,1]=data.frame(startdatetime=format(Sys.time(), "%y-%m-%d %X"))
log[1,2]=data.frame(scriptname="datacenter.r")

library(RMySQL)
mydb = dbConnect(MySQL(), user='tmspl', password='tmsystem@321', dbname='ServerDashboard', host='192.168.52.208')
library(reshape2)
setfolder="T:\\Tableau_BankProject\\email"
dir=list.dirs(setfolder ,recursive = FALSE) #find all folder in directory
dir <- dir[!grepl("[_]", basename(dir))]
cat(paste0("\n Setting directory to "),setfolder)

cat("\n Scaning folder and files")

cat(paste0("\n Loading ",length(dir)," folder and ",length(list.files(dir))," Files"))

check=length(dir)
sleep=5
if (check>0)
{
   
dirnum=length(dir)#find number of folder in directory
allfiles=length(list.files(dir))
for(j in 1: dirnum)#loop for folder
  {
  file=list.files(dir[j])#find list of files in specifc directory
  filenum=length(list.files(dir[j]))#find number of files in specifc directory
    for (i in 1 : filenum)#loop for file
    {
  
  
      d=read.ftable(paste0(dir[j],"/",file[i]),sep = ",") #read file
  
      d <- stats:::format.ftable(d, quote=FALSE) #format files
      
      d[,2] = d[1,2] # saving date in every coloum
      datacenter=substr(file[i],0,4)
      d=cbind(d,datacenter)
      
      number=nrow(d) #find number of row in dataframe
      number=number-3 #logic to remove 3 line in data fram
      d=d[5:number,] #reducing data fram
      d<-gsub("\\s+", ";", gsub("^\\s+|\\s+$", "",d)) # remove space
      d<- gsub('\\s+',',',d) # replacing with ','
      
      d=as.data.frame(d)
      d <- data.frame(d, colsplit(d$V1,pattern = ";",names=c("Bank User","Space Occupied(GB)")))
      
      drop <- c("V1")
      d=d[ , !(names(d) %in% drop)]
      
      names(d)[1]=paste("Date")
      names(d)[2]=paste("Data Center")
      names(d)[3]=paste("Bank User")
      names(d)[4]=paste("Space Occupied(GB)")
      d$Date=as.Date(d$Date,format = "%d-%b-%y")
      
      #write.table(d,file="T:\\Tableau_BankProject\\all.csv",append = TRUE,col.names=FALSE,sep = ",",row.names = FALSE) # save and apped in csv
      
      #saving dataframe to mysql
      dbWriteTable(mydb, name='SpaceUtilization', value=d,append=TRUE,row.names = FALSE)
      
      
      cat(paste0("\n ",allfiles," ","Files remaing to append"))
	    allfiles=allfiles-1
      i = i + 1
    }
  dirfolder<-dir(setfolder)
  dirfolder <- dirfolder[!grepl("[_]", basename(dirfolder))]
  k=1
  file.rename(from = file.path(setfolder,dirfolder[k]), to = file.path(setfolder, paste0(dirfolder[k],"_")))
  
  j = j + 1
}

}

log[1,3]=data.frame(stopdatetime=format(Sys.time(), "%y-%m-%d %X"))

dbWriteTable(mydb, name='R log', value=log,append=TRUE,row.names = FALSE)

dbDisconnect(mydb)
