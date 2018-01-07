# Approximate the size of data
# 1. Read the first 1000 rows and estimate the memory that is being used to store them
f_lines<- read.table(file="household_power_consumption.txt",nrows = 1000, skip = 1, header = F,sep = ";" )
size_f_lines<-object.size(f_lines)
# 2. The file has 2,075,259 rows, so it has (2,075,259/1000)~=2075 1000s of rows 
est_mem<-round(2075259/1000)* size_f_lines

# Loading the dataset, clean it and hold the variables for plot 1
dataset<- read.table(file="household_power_consumption.txt",,header = T,sep = ";",na.strings = "?") %>%
  mutate(Date=as.Date(Date,format='%d/%m/%Y')) %>%
  filter(Date=="2007-02-02" |Date=="2007-02-01") %>%
  select(Global_active_power)

# Create the 1st plot 
with(dataset,hist(Global_active_power,main ="Global Active Power",col = "red",xlab = "Global Active Power (kilowatts)" ))

# Copy the 1st plot to plot1.png
dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!