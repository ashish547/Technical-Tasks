# Technical-Tasks

### Script for Automating Security Audits and Server Hardening on Linux Servers

# Linux Server Security Audit and Hardening Script

This Bash script automates the security auditing and hardening process on Linux servers. It checks for common security vulnerabilities and applies hardening measures based on best practices.

## Features

- User and group audits
- File and directory permission audits
- Service audits
- Firewall and network security checks
- Public vs. private IP identification
- Security updates and patching
- Server hardening (SSH, IPv6, bootloader, firewall, etc.)
- Customizable security checks via a configuration file

## Usage

1. Clone this repository to your server:
   ```
   git clone https://github.com/yourusername/security-audit-script.git
   cd security-audit-script
   ```
Configure your security checks by editing `config.sh`.

Run the script:
```
sudo ./security_audit.sh
```
Review the audit log in logs/audit_log.txt.

Optional: Customize firewall rules and SSH configurations located in the templates folder.

**Configuration**
Adjust settings in the config.sh file to tailor the audit and hardening process for your server environment.

**DISABLE_IPV6:** Disable IPv6 if not in use `(yes or no)`
**AUTO_UPDATES:** Enable automatic security updates `(yes or no)`
**ALERT_ON:** Enable email alerts for critical vulnerabilities `(yes or no)`
