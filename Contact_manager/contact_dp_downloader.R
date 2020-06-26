# Downloading the pics seperately to assign 
library(curl)
lines = readLines("C:/Users/riyas/Desktop/contacts.vcf")
i=0
setwd("C:/Users/riyas/Desktop/code/")

for (i in 1:(length(lines))){
  if (substring(lines[i],1, 6) == "PHOTO:"){
    #cat(lines[i],file="outfile.txt", append=TRUE,sep="\n")
    var = lines[i+1]
    var1= substring(var,2)
    prim = substring(lines[i],7)
    var2 = paste0(prim,var1)
    cat(var2,file="outfile.txt", append=TRUE,sep="\n")
    #download.file(var2,paste0(getwd(),"/",i))
    curl_download(var2, paste0(i,".jpg"))
    next
  }
}
file.show("outfile.txt")