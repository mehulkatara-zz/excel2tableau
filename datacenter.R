setfolder="Z://Software Change Management Documents//Daily Software Dev Dept Reports//powerbidashboard//data"
dir=list.dirs(setfolder ,recursive = FALSE) #find all folder in directory
dir <- dir[!grepl("[_]", basename(dir))]
cat(paste0("\n Setting directory to "),setfolder)
Sys.sleep(1)
cat("\n Scaning folder and files")
Sys.sleep(1)
cat(paste0("\n Loading ",length(dir)," folder and ",length(list.files(dir))," Files"))
Sys.sleep(1)
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
      
      d[,2]=d[1,2] # saving date in every coloum
      datacenter=substr(file[i],0,4)
      d=cbind(d,datacenter)
      
      number=nrow(d) #find number of row in dataframe
      number=number-3 #logic to remove 3 line in data fram
      d=d[5:number,] #reducing data fram
      d<-gsub("\\s+", ";", gsub("^\\s+|\\s+$", "",d)) # remove space
      d<- gsub('\\s+',',',d) # replacing with ','
      
      write.table(d,file="all.csv",append = TRUE,col.names=FALSE) # save and apped in csv
      
      
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
cat("\n Successfully Append")
cat(paste0("\n Date saved in ",setfolder,"/all.csv"))
Sys.sleep(sleep)
sleep=0
}
{cat("\n None of files has been updated \n No folder found with new data")
cat(paste0("\n Date saved in ",setfolder,"/all.csv"))
}
Sys.sleep(sleep)
#library(reshape2)
#test <- data.frame(df, colsplit(df$VESSELID,pattern = ":",names=c("vesselID","DATE")))
