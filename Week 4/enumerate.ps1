# 1 - Current user, groups, and privileges
whoami /all | Out-File "C:\temp\01_user_info.txt"

# 2 - Running processes
tasklist /v | Out-File "C:\temp\02_processes.txt"

# 3 - Open network sockets and connections
netstat -ano | Out-File "C:\temp\03_connections.txt"

# 4 - Running services
net start | Out-File "C:\temp\04_services.txt"

# 5 - All local user accounts
net user | Out-File "C:\temp\05_net_users.txt"

# 6 - All local groups
net localgroup | Out-File "C:\temp\06_net_local.txt"

# 7 - Users in Administrators group
net localgroup administrators | Out-File "C:\temp\07_net_admins.txt"

# 8 - Network configuration
ipconfig /all | Out-File "C:\temp\08_ip_config.txt"

# 9 - Firewall policies
netsh advfirewall show allprofiles | Out-File "C:\temp\09_firewall.txt"

# 10 - ARP table
arp -a | Out-File "C:\temp\10_arp.txt"

# 11 - SMB sessions
net session | Out-File "C:\temp\11_smb.txt"

# 12 - System information
systeminfo | Out-File "C:\temp\12_sysinfo.txt"

Set-ExecutionPolicy Bypass -Scope Process
.\enumerate.ps1
