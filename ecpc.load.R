#download webpage http://www1.canada.ca/consultingcanadians/currentconsultationsbycalendar onto your computer. This will bypass the Javascript
#and allow all <li> members to be read. The file is saved on computer ########### at "C:\\Users\\###########\\Desktop\\Current consultations by calendar - Canada.ca.html"
current<-xpathApply(htmlTreeParse("C:\\Users\\###########\\Desktop\\Current consultations by calendar - Canada.ca.html",useInternalNode=T),"//section[@class='mrgn-bttm-lg']/*",xmlValue)
bob<-current
bobm<-matrix(unlist(bob),ncol=2,byrow=T)
bobm<-cbind(bobm[,2],matrix(unlist(strsplit(bobm[,1]," - ")),ncol=2,byrow=T))
#bobm[,2]<-unlist(lapply(strsplit(bobm[,2],"[ ,]"),function(x) paste0(c(match(x[1],months),x[c(2,4)]),collapse="/")))
#bobm[,3]<-unlist(lapply(strsplit(bobm[,3],"[ ,]"),function(x) paste0(c(match(x[1],months),x[c(2,4)]),collapse="/")))
bobm<-cbind(bobm,unlist(xpathApply(htmlTreeParse("C:\\Users\\dmmaclennan\\Desktop\\Current consultations by calendar - Canada.ca.html",useInternalNode=T),"//section[@class='mrgn-bttm-lg']//a",xmlAttrs)))
current<-bobm
current[,2]<-as.Date(current[,2],format="%B %d, %Y")
current[,3]<-as.Date(current[,3],format="%B %d, %Y")
write.csv(bobm,row.names=F,"C:\\Users\\dmmaclennan\\Desktop\\consulting with canadians.csv")



ongoing<-as.matrix(unlist(xpathApply(htmlTreeParse("C:\\Users\\dmmaclennan\\Desktop\\Current consultations by calendar - Canada.ca.html",useInternalNode=T),"//h2[text()='Ongoing consultation']/following-sibling::*/*/a",xmlValue)))
bob<-as.matrix(unlist(xpathApply(htmlTreeParse("C:\\Users\\dmmaclennan\\Desktop\\Current consultations by calendar - Canada.ca.html",useInternalNode=T),"//h2[text()='Ongoing consultation']/following-sibling::*/*/a",xmlAttrs)))
ongoing<-cbind(ongoing,bob)

