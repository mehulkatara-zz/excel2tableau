library(xlsx)
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