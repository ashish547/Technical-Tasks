# Technical-Tasks

Set 1: Monitoring System Resources for a Proxy Server

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

```bash
./system_monitor.sh -cpu
./system_monitor.sh -network
./system_monitor.sh -dashboard
