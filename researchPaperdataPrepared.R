#load the library needed for this study
library(rjson)
library(reshape)
library(ggplot2)

#set the path to the folder of the data and load the data.
setwd("C:/Users/leirhyh/Documents/Rdata/NASA_GISS_data")
ZoneGistemp <- read.csv("ZonAnn_Ts_dSST.csv")
head(ZoneGistemp)
write.csv(ZoneGistemp,file="ZonAnn_Ts_dSSTnew.csv", sep=",", row.names =TRUE)
ZoneGistemp <- read.csv("ZonAnn_Ts_dSST.csv")
head(ZoneGistemp)
GLBGistemp <- read.csv("GLB_Ts_dSSTnew.csv")
head(GLBGistemp)
annualTemp <- GLBGistemp[c(1,14)]
colnames(annualTemp)[2] <- "annual"
head(annualTemp)
write.csv(annualTemp,file="annualTemp.csv", sep=",", row.names =TRUE)
#convert the csv file to json file for region temperatural data visualization

x <- toJSON(unname(split(ZoneGistemp, 1:nrow(ZoneGistemp))))
cat(x)
write(x, "ZonAnn_Ts_dSST.JSON")
GLB_Ts_DSSTnew   <- read.csv("GLB_Ts_DSSTnew.csv")
head(GLB_Ts_DSSTnew)
GLB_Ts_DSSTnewjs <- toJSON(unname(split(GLB_Ts_DSSTnew , 1:nrow(GLB_Ts_DSSTnew ))))
cat(GLB_Ts_DSSTnewjs)
write(GLB_Ts_DSSTnewjs, "GLB_Ts_DSSTnew.JSON")

#transform the csv file to format the monthly temperatural data visualization
Year <- GLBGistemp$Year
GLBGistempnew <- GLBGistemp[,1:13]
head(GLBGistempnew)
GLBGistempnew["day"] <- NA
GLBGistempnew$day <- 1
head(GLBGistempnew)
sapply(GLBGistempnew, class) # check the type of the variables.
GLBGistempnewTF <- melt(GLBGistempnew, id.vars = c("Year", "day"), variable.name="Month",
                        value.name="TempAnomality")

colnames(GLBGistempnewTF)[3]  <- "Month"
colnames(GLBGistempnewTF)[4]  <- "TempAnomality"
head(GLBGistempnewTF)
tail(GLBGistempnewTF)

write.csv(GLBGistempnewTF,file="GLBGistempnewTF.csv", sep=",", row.names =TRUE)

# change month abbr to month numeric
numMonth<-function(x)  c(jan=1,feb=2,mar=3,apr=4,may=5,jun=6,jul=7,aug=8,sep=9,oct=10,nov=11,dec=12)[tolower(x)]
GLBGistempnewTF$Month <-numMonth(GLBGistempnewTF$Month)
head(GLBGistempnewTF)
tail(GLBGistempnewTF)
GLBGistempnewTFnew <- GLBGistempnewTF [c("Year","Month", "day","TempAnomality")]
colnames(GLBGistempnewTFnew)[4] <- "temperature"
colnames(GLBGistempnewTFnew)[1] <- "year"
colnames(GLBGistempnewTFnew)[2] <- "month"
head(GLBGistempnewTFnew)
write.csv(GLBGistempnewTFnew,file="temperaturenew.csv", sep=",", row.names =TRUE)



