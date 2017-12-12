library(xlsx)
data=read.xlsx("T:\\Tableau_BankProject\\Support App Usage.xlsx", sheetIndex = 1 , header = TRUE)
Data_Frame = data.frame(data)
Data_Frame[] <- lapply(Data_Frame, as.character)
category= colnames(Data_Frame)
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

write.xlsx(x = new , file = "T:\\Tableau_BankProject\\SupportAppUsage.xlsx",sheetName = "Category wise support app usage",row.names=FALSE)
