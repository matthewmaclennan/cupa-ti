#public consultation codes plotting etc...
ecpc<-as.matrix(read.csv("C:\\Users\\dmmaclennan\\Desktop\\consulting with canadians.csv"))
colnames(ecpc)<-c("title","open_date","close_date","url")
#strsplit the dates and as.numeric
#today's date in the same format
today<-as.Date(date(),"%a %b %d %H:%M:%S %Y");
timeleft<-as.matrix(difftime(as.Date(ecpc[,3],"%B %d, %Y"),today));colnames(timeleft)<-"time_left"
range<-as.matrix(difftime(as.Date(ecpc[,3],"%B %d, %Y"),as.Date(ecpc[,2],"%B %d, %Y")));colnames(range)<-"range"
ecpc<-cbind(ecpc,range,timeleft)
percent_complete<-as.matrix(as.numeric(timeleft)/as.numeric(range));colnames(percent_complete)<-"percent_complete"
#currently open consultations that have days remaining, cbind with 
lbls<-paste0(round(as.numeric(ecpc[ecpc[,"time_left"]>0,][,"time_left"])/as.numeric(ecpc[ecpc[,"time_left"]>0,][,"range"])*100)," % left")
piedata<-cbind(as.numeric(ecpc[ecpc[,"time_left"]>0,][,"time_left"]),as.numeric(ecpc[ecpc[,"time_left"]>0,][,"range"])-as.numeric(ecpc[ecpc[,"time_left"]>0,][,"time_left"]))


pdf(file=paste0(format(Sys.Date(),format="%Y%m%d"),".pdf"))
#plot 4 pie charts per page
par(mfrow=c(2,2))
for(i in 1:length(lbls)){
 pie(piedata[i,],labels=lbls[i],col=c("green","red"))
title(main=paste(strwrap(ecpc[i,1],width=35),collapse="\n"))
 }
dev.off()
