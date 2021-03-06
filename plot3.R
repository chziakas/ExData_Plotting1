# Approximate the size of data
# 1. Read the first 1000 rows and estimate the memory that is being used to store them
f_lines<- read.table(file="household_power_consumption.txt",nrows = 1000, skip = 1, header = F,sep = ";" )
size_f_lines<-object.size(f_lines)
# 2. The file has 2,075,259 rows, so it has (2,075,259/1000)~=2075 1000s of rows 
est_mem<-round(2075259/1000)* size_f_lines

# Loading the dataset, clean it and hold the variables for plot 3
dataset<- read.table(file="household_power_consumption.txt",,header = T,sep = ";",na.strings = "?") %>%
  mutate(Date=as.Date(Date,format='%d/%m/%Y')) %>%
  filter(Date=="2007-02-02" |Date=="2007-02-01") %>%
  mutate(DateTime= paste(Date,Time, sep=" ")) %>%
  select(Sub_metering_1,Sub_metering_2,Sub_metering_3,DateTime)

# Change the date-time variable to appropriate format
dataset$DateTime<-strptime(dataset$DateTime,format ="%Y-%m-%d %H:%M:%S" )

# Create the 3rd plot 
with(dataset, plot(x=DateTime, y=Sub_metering_1,type ="l", xlab = "", ylab = "Energy sub metering", col="black" ))
with(dataset,lines(x=DateTime, y=Sub_metering_2,type ="l", col="red" ))
with(dataset,lines(x=DateTime, y=Sub_metering_3,type ="l", col="blue"))
legend("topright",lty = 1,lwd=1 col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Copy the 3rd plot to plot3.png
dev.copy(png, file = "plot3.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!

