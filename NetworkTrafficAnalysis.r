options(repos = c(CRAN = "https://cloud.r-project.org"))
#this helps in install.packages thing

#my first R project. Network traffic analyssis Visualization

#my first dummy data generation
set.seed(123) #dk what this means
num_records <- 1000

timestamps <- seq.POSIXt(from = as.POSIXct("2024-06-03 00:00:00"),
                        by = "hour",
                        length.out = num_records) #as far as i have understood this is like generating random time stamps from this point onwards

generate_ipv4 <- function(n) {
    paste(sample(0:255, n, replace = TRUE), sample(0:255, n, replace = TRUE),
    sample(0:255, n, replace = TRUE), sample(0:255, n, replace=TRUE), sep=".") # as far as i understood this, we are making a sample and the seperator is ".", so its like generating 4 random nums from 0-255(including 0 and 255), and these 4 are seperated by dots
}
# a new way to make function i suppose, at least more understadable than JS funcn syntax
source_ips <- generate_ipv4(num_records)
destination_ips <- generate_ipv4(num_records)

bytes_transferred <- sample(100:10000, num_records, replace=TRUE)

traffic_data <- data.frame(
    timestamp = timestamps,
    source_ip = source_ips,
    destination_ip = destination_ips,
    bytes_transferred = bytes_transferred
)

print(head(traffic_data))


#now time for visualization yeahhh

install.packages("ggplot2")
library(ggplot2)

options(repr.plot.width=10, repr.plot.height=6)

ggplot(traffic_data, aes(x = timestamp, y = bytes_transferred)) +
  geom_line() +
  labs(title = "Network Traffic Over Time",
       x = "Timestamp",
       y = "Bytes Transferred")


#now something called top talkers analysis, basically which ip address generates most traffic

top_talkers <- aggregate(bytes_transferred ~ source_ip, data = traffic_data, FUN = sum) #dk what this fun is, and why ~ is used plus there is an aggregate function 
top_talkers <- top_talkers[order(top_talkers$bytes_transferred, decreasing = TRUE), ] #and this is decreasing sure, but what top_taler$bytes_transferred
top_talkers <- head(top_talkers, 10) #these are the top 10 talkers for visualization

ggplot(top_talkers, aes(x = reorder(source_ip, bytes_transferred), y = bytes_transferred, fill = bytes_transferred)) + #this is like basic x and y +
  geom_bar(stat = "identity", color = "black") + #this is for the geometric bar +
  labs(title = "Top 10 Source IP Addresses by Traffic",
       x = "Source IP",
       y = "Bytes Transferred") +
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust  =1), #no idea what hijust means
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        axis.title.x = element_text(size=12, face="bold"),
        axis.title.y = element_text(size=12, face="bold"),
        legend.position = "none")+#these are all just like specifications for dispaly
    geom_text(aes(label = scales::comma(bytes_transferred)), vjust = -0.3, size = 3.5) #dk what vjust is