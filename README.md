# Technical-Tasks

### Set 1: Monitoring System Resources for a Proxy Server

**Top 10 Most Used Applications:** The `top_applications` function uses `ps` to display the top 10 processes sorted by memory usage and shows their CPU and memory usage.

**Network Monitoring:** The `network_monitoring` function uses `netstat` to count established connections, display dropped packets, and network traffic stats (received/transmitted data).

**Disk Usage:** The `disk_usage` function checks for any partitions using more than 80% of the disk space using the df command.

**System Load:** The `system_load` function shows the system load average using the `uptime` command and a breakdown of CPU usage using `mpstat`.

**Memory Usage**: The `memory_usage` function uses `free` to display memory and swap usage.

**Process Monitoring:** The `process_monitoring` function displays the number of active processes and lists the top 5 processes by CPU usage.

**Service Monitoring:** The `service_monitoring` function checks whether essential services like `sshd`, `nginx`, and `iptables` are running.

**Custom Dashboard:** The dashboard continuously refreshes the data every few seconds (configurable by the `INTERVAL variable`) and displays all the metrics in one view.

# System Resource Monitoring Script

This Bash script monitors various system resources on a proxy server and presents the data in a dashboard format. The script can also be used to monitor specific resources using command-line switches.

## Features

- **Top 10 Most Used Applications**: Displays the top 10 processes by CPU and memory usage.
- **Network Monitoring**: Displays the number of concurrent connections, packet drops, and network traffic statistics.
- **Disk Usage**: Shows disk usage for mounted partitions and highlights partitions using more than 80% of space.
- **System Load**: Displays the current load average and a breakdown of CPU usage.
- **Memory Usage**: Displays total, used, and free memory, along with swap memory usage.
- **Process Monitoring**: Displays the number of active processes and top 5 processes by CPU usage.
- **Service Monitoring**: Monitors the status of essential services like `sshd`, `nginx/apache`, and `iptables`.

## Usage

Run the script using the following command-line options:

- `-cpu`: Monitor top 10 applications by CPU and memory usage.
- `-network`: Monitor network statistics (connections, packet drops, traffic).
- `-disk`: Monitor disk usage.
- `-load`: Monitor system load and CPU breakdown.
- `-memory`: Monitor memory usage.
- `-process`: Monitor processes.
- `-services`: Monitor essential services.
- `-dashboard`: Launch the full monitoring dashboard with real-time updates.

Example usage:

./system_monitor.sh -cpu
./system_monitor.sh -network
./system_monitor.sh -dashboard

### Installation

1. Clone this repository to your server:
```
git clone https://github.com/yourusername/system-monitor.git
cd system-monitor
```
2. Make the script executable:
```
chmod +x system_monitor.sh
```
3. You can just run the script with your desired options.
```
./system_monitor.sh -cpu
./system_monitor.sh -network
./system_monitor.sh -dashboard
```
