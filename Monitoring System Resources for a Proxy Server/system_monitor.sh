#!/bin/bash

# Interval for refreshing the dashboard
INTERVAL=5

# Function to display top 10 most used applications by CPU and memory
top_applications() {
    echo "=== Top 10 Applications by CPU and Memory Usage ==="
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 11
    echo ""
}

# Function to monitor network stats (concurrent connections, packet drops, traffic)
network_monitoring() {
    echo "=== Network Monitoring ==="
    echo "Number of concurrent connections:"
    netstat -an | grep ESTABLISHED | wc -l
    echo ""

    echo "Packet drops:"
    netstat -s | grep "packets dropped"
    echo ""

    echo "Network traffic (MB in and out):"
    ifconfig | grep -E 'RX bytes|TX bytes'
    echo ""
}

# Function to monitor disk usage
disk_usage() {
    echo "=== Disk Usage ==="
    df -h | awk '{ if ($5 >= 80) print $0; }'
    echo ""
}

# Function to display system load averages and CPU usage
system_load() {
    echo "=== System Load and CPU Usage ==="
    uptime
    echo ""
    
    echo "CPU Breakdown (User, System, Idle, etc.):"
    mpstat
    echo ""
}

# Function to display memory usage
memory_usage() {
    echo "=== Memory Usage ==="
    free -h
    echo ""

    echo "Swap Memory Usage:"
    swapon --show
    echo ""
}

# Function to display number of active processes and top 5 by CPU and memory usage
process_monitoring() {
    echo "=== Process Monitoring ==="
    echo "Number of active processes:"
    ps -e --no-header | wc -l
    echo ""

    echo "Top 5 processes by CPU and memory:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    echo ""
}

# Function to monitor essential services (sshd, nginx/apache, iptables)
service_monitoring() {
    echo "=== Service Monitoring ==="
    services=("sshd" "nginx" "apache2" "iptables")

    for service in "${services[@]}"; do
        if systemctl is-active --quiet "$service"; then
            echo "$service is running."
        else
            echo "$service is NOT running."
        fi
    done
    echo ""
}

# Function to display the complete dashboard
dashboard() {
    clear
    while true; do
        top_applications
        network_monitoring
        disk_usage
        system_load
        memory_usage
        process_monitoring
        service_monitoring
        sleep $INTERVAL
        clear
    done
}

# Command-line switches
while [[ $# -gt 0 ]]; do
    case "$1" in
        -cpu)
            top_applications
            shift
            ;;
        -network)
            network_monitoring
            shift
            ;;
        -disk)
            disk_usage
            shift
            ;;
        -load)
            system_load
            shift
            ;;
        -memory)
            memory_usage
            shift
            ;;
        -process)
            process_monitoring
            shift
            ;;
        -services)
            service_monitoring
            shift
            ;;
        -dashboard)
            dashboard
            shift
            ;;
        *)
            echo "Usage: $0 [-cpu] [-network] [-disk] [-load] [-memory] [-process] [-services] [-dashboard]"
            exit 1
            ;;
    esac
done
