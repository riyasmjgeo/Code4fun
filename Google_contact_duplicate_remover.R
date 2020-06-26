# This code is for remove duplicate contacts occurs which comes while syncing with Google contacts 
# or when importing VCF file.
# The duplication was not because there are two actual contacts but due to conversion issues. 
# Export Google contacts from contacts.google.com as vcf file

lines = readLines("C:/Users/riyas/Desktop/contacts.vcf")
i=0
setwd("C:/Users/riyas/Desktop/code/")

for (i in 1:(length(lines))){
  # Appending BEGIN AND END LINES
  if (lines[i]=="BEGIN:VCARD" | lines[i]=="END:VCARD"){
    cat(lines[i],file="outfile.txt", append=TRUE, sep="\n")
    next
  }
  # Get numbers
  if (substring(lines[i],1,4)=="TEL;" & lines[i] != lines[i-1]){
    if (i>3){
      if (lines[i] != lines[i-2] & lines[i] != lines[i-3]){
        cat(lines[i],file="outfile.txt", append=TRUE, sep="\n")
        next
  }}}
  if (substring(lines[i],1,3) == "FN:"){
    cat(lines[i],file="outfile.txt", append=TRUE, sep="\n")
    next
  }
  ## Couldn't get the photos properly
  #if (substring(lines[i],1, 6) == "PHOTO:" | substring(lines[i],1,4) == "URL:"){
  #  cat(lines[i],file="outfile.txt", append=TRUE,sep="\n")
   # cat(lines[i+1],file="outfile.txt", append=TRUE,sep="\n")
    #next
    #}}
  # Adding e-mail contacts while removing email contacts without telephone number
  if (substring(lines[i],1,6) == "EMAIL;"){
    var1 = lines[i+1]
    if (substring(var1, 1 ,4) == "TEL;" | substring(var1, 1 ,6) == "EMAIL;"){
      cat(lines[i],file="outfile.txt", append=TRUE, sep="\n")
  }}
}
file.show("outfile.txt")