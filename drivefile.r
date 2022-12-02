drivefile <- function(id,fileType,deleteTempFile) {

if(!require("googledrive")){

    install.packages("googledrive")

    library(googledrive)

}

library(googledrive)
temp <- tempfile(fileext = fileType)
dl <- drive_download(as_id(id), path = temp, overwrite = TRUE)

if(fileType == ".txt") {

table <- read.table(temp, header = T, sep="", dec = ".", na.strings="NA")

} else if (fileType == ".tsv") {

table <- read.table(temp, sep = "\t", header = TRUE, fill = TRUE)

} else if (fileType == ".csv") {

table <- read.csv(temp, sep = ",")

} else {

table <- read.table(temp)

}

if(deleteTempFile=="TRUE"){
        if(file.remove(temp)=="TRUE"){

                message(paste("Temporary file",temp,"removed successfully"))

        } else {

                message(paste("Encountered problem with the deletion of",temp,"temporary file."))

        }

} else {

        message(paste("File",temp,"is not deleted.\nWrite",dQuote("TRUE"),"in a future use to delete the file."))
        Sys.sleep(2)
}

return(table)

}