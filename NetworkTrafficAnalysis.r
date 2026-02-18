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

