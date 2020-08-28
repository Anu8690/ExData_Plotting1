data<- fread("./household_power_consumption.txt")
data$Date<- as.Date(data$Date,"%d/%m/%Y")
data<- data%>% filter(Date %in% as.Date(c("2007-02-01","2007-02-02")))
data<-lapply(data, function(x){sub("^(\\?)","NA",x)})
data<- as.data.frame(data)
data$Time <- strptime(as.character(paste(data$Date,data$Time)),"%Y-%m-%d %H:%M:%S")
for(x in 3:9){data[[x]]=as.numeric(data[[x]])}

png("plot2.png")
plot(data$Time,data$Global_active_power,type="n",xlab = "",ylab = "Global Active Power(kilowatts)")
lines(data$Time,data$Global_active_power)
dev.off()