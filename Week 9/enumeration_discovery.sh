#!/bin/bash

OUTDIR="command_output"
mkdir -p "$OUTDIR"

# Enumeration Commands:

# 1: Current user, groups, and privileges
id > "$OUTDIR/01_user_info.txt" 2>&1

# 2: Running processes
ps aux > "$OUTDIR/02_running_processes.txt" 2>&1

# 3: Open network sockets and connections
sudo ss -tupna > "$OUTDIR/03_network_sockets.txt" 2>&1

# 4: Running Services
systemctl list-units --type=service --state=running > "$OUTDIR/04_running_services.txt" 2>&1

# 5: All user accounts
cat /etc/passwd > "$OUTDIR/05_user_accounts.txt" 2>&1

# 6: All local groups 
cat /etc/group > "$OUTDIR/06_local_groups.txt" 2>&1

# 7: Users in sudo group
members sudo > "$OUTDIR/07_sudo_users.txt" 2>&1

# 8: Network configuration
ip address show > "$OUTDIR/08_network_config.txt" 2>&1

# 9: Firewall policies
sudo firewall-cmd --list-all > "$OUTDIR/09_firewall_policies.txt" 2>&1

# 10: ARP tables
ip neigh show > "$OUTDIR/10_ARP_tables.txt" 2>&1

# 11: SMB sessions
sudo smbstatus > "$OUTDIR/11_SMB_sessions.txt" 2>&1

# 12: System information
uname -a > "$OUTDIR/12_system_info.txt" 2>&1

# Discovery Commands:

# 13: Sudo privileges granted to the current account, including NOPASSWD entries
sudo -l > "$OUTDIR/13_sudo_priv.txt" 2>&1

# 14: Logged-in users, active sessions, and login history
w > "$OUTDIR/14_logged-in_users.txt" 2>&1

# 15: Shell command history left behind by local users
cat ~/.bash_history > "$OUTDIR/15_shell_history.txt" 2>&1

# 16: Environment variables of the current shell and running processes
env > "$OUTDIR/16_env_variables.txt" 2>&1

# 17: SUID and SGID binaries on the filesystem
find / -perm -4000 -type f 2>/dev/null > "$OUTDIR/17_SUID_binaries.txt" 2>&1

# 18: File capabilities assigned to installed binaries
getcap -r / 2>/dev/null > "$OUTDIR/18_file_capabilities.txt" 2>&1

# 19: Scheduled tasks: cron jobs and systemd timers
systemctl list-timers --all > "$OUTDIR/19_scheduled_tasks.txt" 2>&1

# 20: Installed security tools and EDR agents, and whether they are running
ssystemctl list-units --type=service --state=running > "$OUTDIR/20_installed_security_tools.txt" 2>&1

# 21: Installed software package inventory
dpkg -l > "$OUTDIR/21_installed_software.txt" 2>&1
 
# 22: Kernel version and build information
uname -a > "$OUTDIR/22_kernel_version.txt" 2>&1

# 23: Mounted filesystems and free disk space
df -h > "$OUTDIR/23_mounted_file_systems.txt" 2>&1

# 24: SSH keys, authorized_keys files, and SSH client/server configuration
cat ~/.ssh/authorized_keys > "$OUTDIR/24_key_config.txt" 2>&1

# 25: Password hash store - permissions and readability
ls -l /etc/shadow > "$OUTDIR/25_password_hash_store.txt" 2>&1

# 26: Authentication events and failed login attempts recorded in system logs
cat /var/log/auth.log > "$OUTDIR/26_authentication_logs.txt" 2>&1

# 27: Running containers and container runtime socket permissions
docker ps > "$OUTDIR/27_containers.txt" 2>&1

# 28: SELinux or AppArmor status
sestatus > "$OUTDIR/28_SELinux.txt" 2>&1

# 29: Exported NFS / network file shares
showmount -e localhost > "$OUTDIR/29_exported_NFS.txt" 2>&1

# 30: Hostname, FQDN, and configured domain membership
hostnamectl > "$OUTDIR/30_hostname.txt" 2>&1

# 31: World-writable files and directories in system locations
find / -xdev -type f -perm -0002 2>/dev/null > "$OUTDIR/31_writable_files.txt" 2>&1

# 32: Files opened by running processes, including deleted-but-still-open files
lsof > "$OUTDIR/32_files_and_processes.txt" 2>&1

# Compression: 

tar -czvf enum_out.tar.gz "$OUTDIR/"   
7z a enum_out.7z "$OUTDIR/"  
pwsh -Command "Compress-Archive -Path $OUTDIR -DestinationPath enum_out_pscompress.zip -Force"


