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

if (!require("ggplot2")) {
  install.packages("ggplot2")
}
library(ggplot2)

options(repr.plot.width=10, repr.plot.height=6)

p1 <- ggplot(traffic_data, aes(x = timestamp, y = bytes_transferred)) +
  geom_line() +
  labs(title = "Network Traffic Over Time",
       x = "Timestamp",
       y = "Bytes Transferred")
print(p1)


#now something called top talkers analysis, basically which ip address generates most traffic

top_talkers <- aggregate(bytes_transferred ~ source_ip, data = traffic_data, FUN = sum) #dk what this fun is, and why ~ is used plus there is an aggregate function 
top_talkers <- top_talkers[order(top_talkers$bytes_transferred, decreasing = TRUE), ] #and this is decreasing sure, but what top_taler$bytes_transferred
top_talkers <- head(top_talkers, 10) #these are the top 10 talkers for visualization

p2 <- ggplot(top_talkers, aes(x = reorder(source_ip, bytes_transferred), y = bytes_transferred, fill = bytes_transferred)) + #this is like basic x and y +
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
print(p2)


#destination analysis

destination_summary <- aggregate(bytes_transferred ~ destination_ip, data = traffic_data, FUN = sum) # ig the ~ is for the aggregate function to understand what it is taking aggregat of
destination_summary <- destination_summary[order(destination_summary$bytes_transferred, decreasing = TRUE), ] #no idea what this for tho
top_destinations <- head(destination_summary, 10)
#bruh i think my eyes are like not working properly a bit today ngl. maybe i just need to sleep for like 30 mins, but fine i'll do it in the afternoon

p3 <- ggplot(top_destinations, aes(x = bytes_transferred, y = reorder(destination_ip, bytes_transferred))) +
    geom_segment(aes(x = 0, xend = bytes_transferred, y = reorder(destination_ip, bytes_transferred), yend = reorder(destination_ip, bytes_transferred)),
        color = "grey") + 
        geom_point(aes(color = bytes_transferred), size = 4) + 
        scale_color_gradient(low = "lightgreen", high = "darkgreen") + #this is for the color gradient, we just like give the least color and most color
        labs(title = "top 10 network destination", 
            x = "Bytes transferred",
            y = "destination IP address") + # this is to declare the x and y values of the graph like what do they represent
        theme_minimal() + 
        theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
              axis.title.x = element_text(size=12, face = "bold"),
              axis.title.y = element_text(size=12, face = "bold"))
print(p3)


#this is for the map, using leaflet

if (!require("leaflet")) {
    install.packages("leaflet")
}
library(leaflet)

set.seed(123)
num_records <- nrow(traffic_data)#i think this like talking about the rows. and also like when i focus on screen like one individual section is clear but the rest of the things are getting blurry, its workable i dont think a huge issue.
traffic_data$source_latitude<- runif(n = num_records, min = -90, max = 90) #here we are keeping the minimum and maximum for the latitude
traffic_data$source_longitude <- runif(n = num_records, min = -180, max = 180)
traffic_data$destination_latitude <- runif(n = num_records, min = -90, max = 90) #this is for the destination nodes. also if this continues to happen the eye thing, i will have to be very careful on the road,
traffic_data$destination_longitude <- runif(n = num_records, min = -180, max=180)

my_map <- leaflet(data = traffic_data) %>% #no idea what this % sign does
    addTiles() %>% #this is for the tiles in the map background i guess
    addCircleMarkers(~source_longitude, ~source_latitude, radius = 5, color= "blue", fillOpacity = 0.5, label = ~paste("Source:", source_ip )) %>% #this is for the source nodes but no idea what the % is for once again
    addCircleMarkers(~destination_longitude, ~destination_latitude, radius=5, color="red", fillOpacity = 0.5, label = ~paste("Destination:", destination_ip)) %>% #once again this is for destination nodes
    addPolylines(lng = ~c(source_longitude, destination_longitude), lat = ~c(source_latitude, destination_latitude), color = "green", weight = 2, opacity = 0.7) %>% #ok so this for the lines like what color and weight each line is. this is becoming more workable ngl, although its a defect of the eyes, most probably gone by like tomorrow, its workable and good for foucs cause i cant see my peripheral vision unless i turn
    addLegend("bottomright", colors = c("blue", "red", "green"), labels = c("Source IP", "Destination IP", "traffic path"), title = "Legend") %>% #once again the same % thing, this is declaring the legend, but not sure where we declare this is the world map and all
    setView(lng = mean(traffic_data$source_longitude), lat = mean(traffic_data$source_latitude), zoom = 1) #why not destination longitude and latitude tho, plus i dont think we are generation longitude or latitude so where are we getting this data from?

if (!require("htmlwidgets")) {
    install.packages("htmlwidgets")
}
saveWidget(my_map, "network_traffic_map.html", selfcontained = TRUE)#so the final output for the world map thing is a html, and its a mess. 