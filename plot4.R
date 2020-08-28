data<- fread("./household_power_consumption.txt")
data$Date<- as.Date(data$Date,"%d/%m/%Y")
data<- data%>% filter(Date %in% as.Date(c("2007-02-01","2007-02-02")))
data<-lapply(data, function(x){sub("^(\\?)","NA",x)})
data<- as.data.frame(data)
data$Time <- strptime(as.character(paste(data$Date,data$Time)),"%Y-%m-%d %H:%M:%S")
for(x in 3:9){data[[x]]=as.numeric(data[[x]])}

png("plot4.png")
par(mfrow=c(2,2))
with(data,
     {
       plot(Time,Global_active_power,type="n",xlab = "",ylab="Global Active Power")
       lines(Time,Global_active_power)
       
       plot(Time,Voltage,type="n",xlab = "datetime",ylab="Voltage")
       lines(Time,Voltage)
       
       plot(data$Time,data$Sub_metering_1,xlab="",ylab="Energy sub metering",type="n")
       lines(data$Time,data$Sub_metering_1)
       lines(data$Time,data$Sub_metering_2,col="red")
       lines(data$Time,data$Sub_metering_3,col="blue")
       legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
              col = c("black","red","blue"),lwd = c(1,1,1),
              bty="n")
       
       
       plot(Time,Global_reactive_power,type="n",xlab = "datetime",ylab="Global_reactive_power")
       lines(Time,Global_reactive_power)
     })
dev.off()