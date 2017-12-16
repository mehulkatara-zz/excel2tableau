setwd("T:/Repository/Mehul/excel2tableau")
library(log4r)
logger <- create.logger()
logfile(logger) <- file.path('base.log')
level(logger) <- "INFO"

#file1#

info(logger, 'start:TableauAdvancedModulesASP.csv')

library(xlsx)
library(tcltk)
data=read.xlsx("T:\\Tableau_BankProject\\Advanced Modules Implementation Plan vs Status.xlsx" , sheetIndex = 1 , header = FALSE)
Data_Frame = data.frame(data)
Data_Frame <- Data_Frame[-3,-1]
Data_Frame=Data_Frame[-1,]
Data_Frame[] <- lapply(Data_Frame, as.character)
colnames(Data_Frame) <- Data_Frame[1,]



rowlength=length((Data_Frame[1,]))
droprow=max(which(Data_Frame[1,] =="BANKPERSON "))

Data_Frame= Data_Frame[-1,-droprow:-rowlength]

filelength=length(which(Data_Frame[,1] !="NA"))


Data_Frame= Data_Frame[1:filelength,]


Total_Products= length(Data_Frame[3:length(Data_Frame[1,])])


Total_Banks= length(Data_Frame[,1])


product=colnames(Data_Frame)
product=product[3:length(product)]
bank=Data_Frame[,1]



new=data.frame()

b=1
b1=1
p1=1
for (p1 in 1:Total_Banks) 
{
  for (b in 1:Total_Products) 
  {
    new[b1,1]= bank[p1]
    b1=b1+1
  }
  p1=p1+1
  
}

b=1
b1=1
p1=1
p2=1
for (p1 in 1:Total_Banks) 
{
  for (b in 1:Total_Products) 
  {
    new[b1,2]= product[p2]
    b1=b1+1
    p2=p2+1
  }
  b=1
  p2=1
  
  
  
  p1=p1+1}


b=1
b1=1
p1=1
n=1
m=3
for (p1 in 1:Total_Banks) 
{
  for (b in 1:Total_Products) 
  {
    new[b1,3]= Data_Frame[n,m]
    b1=b1+1
    m=m+1
    
  }
  b=1
  m=3
  n=n+1
  
  p1=p1+1}


names(new)[1]<-paste("Bank")
names(new)[2]<-paste("Product")
names(new)[3]<-paste("Status")

write.csv(x = new , file = "T:\\Tableau_BankProject\\TableauAdvancedModulesASP.csv",row.names=FALSE)

info(logger, 'completed:TableauAdvancedModulesASP.csv')

#file2#

info(logger, 'start:TableauAdvancedModulesTBA.csv')

data=read.xlsx("T:\\Tableau_BankProject\\Advanced Modules Implementation Plan vs Status.xlsx" , sheetIndex = 2 , header = FALSE)
Data_Frame = data.frame(data)
Data_Frame <- Data_Frame[-3,-1]
Data_Frame=Data_Frame[-1,]
Data_Frame[] <- lapply(Data_Frame, as.character)
colnames(Data_Frame) <- Data_Frame[1,]



rowlength=length((Data_Frame[1,]))
droprow=max(which(Data_Frame[1,] =="BANKPERSON "))

Data_Frame= Data_Frame[-1,-droprow:-rowlength]

filelength=length(which(Data_Frame[,1] !="NA"))


Data_Frame= Data_Frame[1:filelength,]


Total_Products= length(Data_Frame[3:length(Data_Frame[1,])])


Total_Banks= length(Data_Frame[,1])


product=colnames(Data_Frame)
product=product[3:length(product)]
bank=Data_Frame[,1]



new=data.frame()

b=1
b1=1
p1=1
for (p1 in 1:Total_Banks) 
{
  for (b in 1:Total_Products) 
  {
    new[b1,1]= bank[p1]
    b1=b1+1
  }
  p1=p1+1
  
}

b=1
b1=1
p1=1
p2=1
for (p1 in 1:Total_Banks) 
{
  for (b in 1:Total_Products) 
  {
    new[b1,2]= product[p2]
    b1=b1+1
    p2=p2+1
  }
  b=1
  p2=1
  
  
  
  p1=p1+1}


b=1
b1=1
p1=1
n=1
m=3
for (p1 in 1:Total_Banks) 
{
  for (b in 1:Total_Products) 
  {
    new[b1,3]= Data_Frame[n,m]
    b1=b1+1
    m=m+1
    
  }
  b=1
  m=3
  n=n+1
  
  p1=p1+1}


names(new)[1]<-paste("Bank")
names(new)[2]<-paste("Product")
names(new)[3]<-paste("Status")

write.csv(x = new , file = "T:\\Tableau_BankProject\\TableauAdvancedModulesTBA.csv",row.names=FALSE)

info(logger, 'completed:TableauAdvancedModulesTBA.csv')

#file3#

info(logger, 'start:TableauQAAllotted.csv')

data=read.xlsx("T:\\Tableau_BankProject\\QA Daily Report.xlsx", sheetIndex = 1 , header = TRUE)
Data_Frame = data.frame(data)

Data_Frame[] <- lapply(Data_Frame, as.character)
category= colnames(Data_Frame) 
category=category[-1]

new= data.frame()


p1=1
p2=1
p3=1
for(p1 in 1:length(Data_Frame[,1]))
{
  for(p2 in 1:length(category))
  {
    new[p3,1]=Data_Frame[p1,1]
    p3=p3+1
  }
  p1=p1+1
}

p1=1
p2=1
p3=1
for(p1 in 1:length(Data_Frame[,1]))
{
  for(p2 in 1:length(category))
  {
    new[p3,2]=category[p2]
    p3=p3+1
  }
  p1=p1+1
}

p1=1
p2=1
p3=1
n=1
m=2
for(p1 in 1:length(Data_Frame[,1]))
{
  for(p2 in 1:length(category))
  {
    new[p3,3]= Data_Frame[n,m]
    p3=p3+1
    m=m+1
  }
  p1=p1+1
  n=n+1
  m=2
}
names(new)[1]<-paste("Date")
names(new)[2]<-paste("Category")
names(new)[3]<-paste("Count")
write.csv(x = new , file = "T:\\Tableau_BankProject\\TableauQAAllotted.csv",row.names=FALSE)

info(logger, 'completed:TableauQAAllotted.csv')

#file4#

info(logger, 'start:TableauQARelease.csv')

data=read.xlsx("T:\\Tableau_BankProject\\QA Daily Report.xlsx", sheetIndex = 2 , header = TRUE)
Data_Frame = data.frame(data)

Data_Frame[] <- lapply(Data_Frame, as.character)
category= colnames(Data_Frame) 
category=category[-1]

new= data.frame()


p1=1
p2=1
p3=1
for(p1 in 1:length(Data_Frame[,1]))
{
  for(p2 in 1:length(category))
  {
    new[p3,1]=Data_Frame[p1,1]
    p3=p3+1
  }
  p1=p1+1
}

p1=1
p2=1
p3=1
for(p1 in 1:length(Data_Frame[,1]))
{
  for(p2 in 1:length(category))
  {
    new[p3,2]=category[p2]
    p3=p3+1
  }
  p1=p1+1
}

p1=1
p2=1
p3=1
n=1
m=2
for(p1 in 1:length(Data_Frame[,1]))
{
  for(p2 in 1:length(category))
  {
    new[p3,3]= Data_Frame[n,m]
    p3=p3+1
    m=m+1
  }
  p1=p1+1
  n=n+1
  m=2
}
names(new)[1]<-paste("Date")
names(new)[2]<-paste("Category")
names(new)[3]<-paste("Count")
write.csv(x = new , file = "T:\\Tableau_BankProject\\TableauQARelease.csv",row.names=FALSE)

info(logger, 'completed:TableauQARelease.csv')

#File5#

info(logger, 'start:TableauSupportAppUsage.csv')

data=read.xlsx("T:\\Tableau_BankProject\\Support App Usage.xlsx", sheetIndex = 1 , header = TRUE)
Data_Frame = data.frame(data)
Data_Frame[] <- lapply(Data_Frame, as.character)
category= colnames(Data_Frame)
category=category[-6]
category=category[-5]
category=category[-1]
new= data.frame()

p1=1
p2=1
p3=1
for(p1 in 1:length(Data_Frame[,1]))
{
  for(p2 in 1:length(category))
  {
    new[p3,1]=Data_Frame[p1,1]
    p3=p3+1
  }
  p1=p1+1
}

p1=1
p2=1
p3=1
for(p1 in 1:length(Data_Frame[,1]))
{
  for(p2 in 1:length(category))
  {
    new[p3,2]=category[p2]
    p3=p3+1
  }
  p1=p1+1
}

p1=1
p2=1
p3=1
n=1
m=2
for(p1 in 1:length(Data_Frame[,1]))
{
  for(p2 in 1:length(category))
  {
    new[p3,3]= Data_Frame[n,m]
    p3=p3+1
    m=m+1
  }
  p1=p1+1
  n=n+1
  m=2
}

new[,4]= Data_Frame[1,6]


names(new)[1]<-paste("Bank")
names(new)[2]<-paste("Category")
names(new)[3]<-paste("Count")
names(new)[4]<-paste("Total Bank")
new[is.na(new)] <- 0  #replacing NA with 0
new[5]<-(cumsum(new[,3]))  #adding new column with running count
names(new)[5]<-paste("run sum")

write.csv(x = new , file = "T:\\Tableau_BankProject\\TableauSupportAppUsage.csv",row.names=FALSE)

info(logger, 'completed:TableauSupportAppUsage.csv')
