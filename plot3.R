library("data.table")
library("dplyr")
library("lubridate")


project_path <- getwd()
url <-
  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(project_path, "Electric power consumption.zip"))
unzip(zipfile = "Electric power consumption.zip")
epc_db <-
  tbl_df(fread(file = "household_power_consumption.txt", , na.strings = "?"))

epc_db$Date <- dmy(epc_db$Date)
epc_db$Time <- hms(epc_db$Time)
ecpDataRequested <-
  filter(epc_db, Date >= "2007-02-01", Date <= "2007-02-02")
ecpDataRequested$date_time = ymd_hms(paste(ecpDataRequested$Date, ecpDataRequested$Time))
png(
  filename = "plot3.png",
  width = 480,
  height = 480,
  units = "px"
  
)
plot(
  x =  ecpDataRequested$date_time
  ,
  y = ecpDataRequested$Sub_metering_1
  ,
  type = "l",
  xlab = "",
  ylab = "Energy sub metering"
)
lines(ecpDataRequested$date_time,
      ecpDataRequested$Sub_metering_2,
      col = "red")
lines(ecpDataRequested$date_time,
      ecpDataRequested$Sub_metering_3,
      col = "blue")

legend(
  "topright"
  ,
  col = c("black", "red", "blue")
  ,
  c("Sub_metering_1  ", "Sub_metering_2  ", "Sub_metering_3  ")
  ,
  lty = c(1, 1),
  lwd = c(1, 1)
)
dev.off()