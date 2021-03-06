#Load Data
source("LoadAndPrepareData.R")

#Configure plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subsetData, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (KW/Kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (KW/Kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Green')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (KW/Kilowatts)",xlab="")
})

#Save plot to respective file
dev.copy(png,"Plot4.png", width=480, height=480)
#Close the device
dev.off()