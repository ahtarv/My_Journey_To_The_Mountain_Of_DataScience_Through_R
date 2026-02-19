
# 📊 R Learning Projects

![R](https://img.shields.io/badge/R-4.x-blue?logo=r)
![ggplot2](https://img.shields.io/badge/ggplot2-visualization-orange)
![Beginner Project](https://img.shields.io/badge/level-beginner-brightgreen)
![Dummy Data](https://img.shields.io/badge/data-simulated-lightgrey)
![Status](https://img.shields.io/badge/status-learning-success)
![License](https://img.shields.io/badge/license-MIT-green)

This repository documents my journey learning **R** through small, practical projects focused on data generation, analysis, and visualization.

Each project is designed to be simple, reproducible, and beginner-friendly, while still reflecting real-world problem styles.

---

## 🎯 Repository Goals

- Learn core R syntax and workflow  
- Understand data structures and functions  
- Practice data visualization using `ggplot2`  
- Simulate realistic datasets when real data is unavailable  
- Build clean, well-documented projects  

---

## 🚀 Projects

### 1️⃣ Network Traffic Analysis & Visualization

**Description**  
This project simulates network traffic logs using dummy data and visualizes traffic behavior over time. Since real network data is sensitive, synthetic data is generated to mimic realistic patterns such as timestamps, IP addresses, and traffic volume.

**What This Project Covers**
- Generating reproducible dummy data
- Working with timestamps and time series
- Creating custom functions in R
- Visualizing trends using line plots
- Identifying top network talkers using aggregation
- Bar chart visualization with labels and styling

---

## 📂 Project Structure

```

network-traffic-analysis/
├── data/
│   └── dummy_network_traffic.csv
├── scripts/
│   └── network_traffic_analysis.R
├── plots/
│   ├── traffic_over_time.png
│   └── top_talkers.png
└── README.md

````

---

## 🧪 Dataset Details

All data in this project is **artificially generated**.

**Fields**
- `timestamp` – sequential hourly timestamps  
- `source_ip` – randomly generated IPv4 addresses  
- `destination_ip` – randomly generated IPv4 addresses  
- `bytes_transferred` – simulated traffic volume per event  

The random seed is fixed to ensure reproducibility.

---

## 📊 Visualizations Included

- **Network Traffic Over Time**  
  Line plot showing how traffic volume changes across timestamps.

- **Top 10 Source IPs (Top Talkers)**  
  Bar chart identifying which source IP addresses generated the most traffic.

---

## 🛠 Tools & Libraries Used

- **R**
- **ggplot2**
- Base R functions (`data.frame`, `aggregate`, `sample`, `order`)

---

## ▶️ How to Run the Project

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/r-learning-projects.git
````

2. Open the script in R or RStudio.

3. Install required packages:

   ```r
   install.packages("ggplot2")
   ```

4. Run the script to:

   * Generate dummy network traffic data
   * Visualize traffic over time
   * Identify and plot top talkers

---

## 📈 Learning Outcomes

By completing this project, I learned:

* How reproducibility works using `set.seed()`
* How to generate structured dummy datasets
* How grouping and aggregation works in R
* How to build and customize plots using `ggplot2`
* How to organize a small R project properly

---

## 🔮 Future Plans

* Add protocol-level analysis (TCP / UDP / ICMP)
* Use `dplyr` instead of base `aggregate`
* Export datasets and plots automatically
* Add anomaly detection
* Build interactive dashboards with `shiny`

---

## ⚠️ Disclaimer

This project is for **educational purposes only**.
All datasets are simulated and do **not** represent real network activity.

---

## 📌 License

This project is licensed under the **MIT License**.

```
