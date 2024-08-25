#!/bin/bash

# Configuration file for custom checks and hardening settings
source ./config.sh

# Log file for storing audit results
LOG_FILE="./audit_log.txt"
exec > >(tee -a $LOG_FILE) 2>&1

# Function to list all users and groups
user_group_audit() {
    echo "=== User and Group Audit ==="
    echo "All Users:"
    cut -d: -f1 /etc/passwd
    echo ""

    echo "All Groups:"
    cut -d: -f1 /etc/group
    echo ""

    echo "Users with UID 0 (Root Privileges):"
    awk -F: '($3 == 0) {print}' /etc/passwd
    echo ""

    echo "Users without passwords or with weak passwords:"
    awk -F: '($2 == "" || $2 == "x") {print $1}' /etc/shadow
    echo ""
}

# Function to audit file and directory permissions
file_permission_audit() {
    echo "=== File and Directory Permissions Audit ==="
    echo "World-writable files and directories:"
    find / -perm -o+w -type f -exec ls -ld {} \;
    echo ""

    echo "Checking .ssh directory permissions:"
    for user in $(cut -d: -f1 /etc/passwd); do
        if [ -d "/home/$user/.ssh" ]; then
            ls -ld /home/$user/.ssh
        fi
    done
    echo ""

    echo "Files with SUID/SGID bits set:"
    find / -perm /6000 -type f -exec ls -ld {} \;
    echo ""
}

# Function to audit services
service_audit() {
    echo "=== Service Audit ==="
    echo "Running services:"
    systemctl list-units --type=service --state=running
    echo ""

    echo "Checking critical services (sshd, iptables):"
    systemctl is-active sshd
    systemctl is-active iptables
    echo ""

    echo "Checking for services on non-standard ports:"
    netstat -tuln | grep -v ':22'
    echo ""
}

# Function to check firewall and network security
firewall_audit() {
    echo "=== Firewall and Network Security Audit ==="
    echo "Checking if firewall is active:"
    if systemctl is-active firewalld >/dev/null 2>&1 || systemctl is-active iptables >/dev/null 2>&1; then
        echo "Firewall is active."
    else
        echo "Firewall is not active."
    fi
    echo ""

    echo "Open ports and associated services:"
    netstat -tuln
    echo ""

    echo "Checking for IP forwarding:"
    sysctl net.ipv4.ip_forward
    echo ""
}

# Function to identify public vs. private IPs
ip_check() {
    echo "=== IP Address Check ==="
    echo "Public vs. Private IP Addresses:"
    ip addr show | grep "inet"
    echo ""
}

# Function to check for security updates and patching
security_updates() {
    echo "=== Security Updates ==="
    echo "Checking for available security updates:"
    if command -v yum >/dev/null 2>&1; then
        yum check-update --security
    elif command -v apt-get >/dev/null 2>&1; then
        apt-get -s upgrade | grep "^Inst"
    fi
    echo ""
}

# Function for log monitoring (e.g., SSH login attempts)
log_monitor() {
    echo "=== Log Monitoring ==="
    echo "Checking for recent SSH login attempts:"
    grep "Failed password" /var/log/auth.log
    echo ""
}

# Function for server hardening steps
server_hardening() {
    echo "=== Server Hardening ==="
    
    # SSH Configuration: Disable password-based login for root
    echo "Disabling password-based login for root in SSH:"
    sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
    systemctl reload sshd
    echo "Root login disabled."
    echo ""

    # Disabling IPv6 (if not required)
    if [ "$DISABLE_IPV6" = "yes" ]; then
        echo "Disabling IPv6:"
        sysctl -w net.ipv6.conf.all.disable_ipv6=1
        sysctl -w net.ipv6.conf.default.disable_ipv6=1
        echo "IPv6 disabled."
    fi
    echo ""

    # Securing the GRUB bootloader
    echo "Securing GRUB bootloader with a password:"
    grub2-mkpasswd-pbkdf2
    echo "GRUB secured."
    echo ""

    # Firewall Configuration
    echo "Applying firewall rules:"
    iptables-restore < /etc/iptables/rules.v4
    echo "Firewall rules applied."
    echo ""

    # Enabling automatic security updates
    echo "Enabling automatic security updates:"
    if [ "$AUTO_UPDATES" = "yes" ]; then
        if command -v apt-get >/dev/null 2>&1; then
            apt-get install unattended-upgrades -y
        elif command -v yum >/dev/null 2>&1; then
            yum install yum-cron -y
            systemctl enable --now yum-cron
        fi
        echo "Automatic updates enabled."
    fi
    echo ""
}

# Function to generate audit and hardening report
generate_report() {
    echo "=== Audit and Hardening Report ==="
    echo "Summary of findings and actions taken can be found in $LOG_FILE."
}

# Function to send email alerts (optional)
send_alert() {
    echo "=== Sending Alerts ==="
    echo "Security audit completed. Check the attached report." | mail -s "Security Audit Report" -A $LOG_FILE youremail@example.com
    echo "Alert sent."
}

# Main function to run the audit and hardening tasks
main() {
    user_group_audit
    file_permission_audit
    service_audit
    firewall_audit
    ip_check
    security_updates
    log_monitor
    server_hardening
    generate_report
    if [ "$ALERT_ON" = "yes" ]; then
        send_alert
    fi
}

# Run the script
main
