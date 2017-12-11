#file1#
library(xlsx)
library(tcltk)
data=read.xlsx("T:\\Advanced Modules Implementation Plan vs Status.xlsx" , sheetIndex = 2 , header = FALSE)
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
write.xlsx(x = new , file = "T:\\Tableau_BankProject\\AdvancedModulesTBA.xlsx",sheetName = "TestSheet",row.names=FALSE)

#file2#

data=read.xlsx("T:\\Advanced Modules Implementation Plan vs Status.xlsx" , sheetIndex = 1 , header = FALSE)
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
write.xlsx(x = new , file = "T:\\Tableau_BankProject\\AdvancedModulesASP.xlsx",sheetName = "TestSheet",row.names=FALSE)

#file3#

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
write.xlsx(x = new , file = "T:\\Tableau_BankProject\\Summary of QA In (QA Allotted).xlsx",sheetName = "Summary of QA In (QA Allotted)",row.names=FALSE)

#file4#

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
write.xlsx(x = new , file = "T:\\Tableau_BankProject\\Summary of QA Out (QA Release).xlsx",sheetName = "Summary of QA Out (QA Release)",row.names=FALSE)

msgBox <- tkmessageBox(title = "Hello, Tableau Developer",
                       message = "Mehul Katara : Tableau datasource refreshed", icon = "info", type = "ok")
