#!/bin/bash

# ===========================================
# Secure SSH Setup + Custom MOTD - SpireCloud
# ===========================================
# Made by NekoSlayer_
# ===========================================

clear

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# SpireCloud Banner
echo -e "${CYAN}"
echo '   _____       _               _____ _                 _ '
echo '  / ____|     (_)             / ____| |               | |'
echo ' | (___  _ __  _  ___ ___    | |    | | ___  _   _  __| |'
echo '  \___ \| '"'"'_ \| |/ __/ _ \   | |    | |/ _ \| | | |/ _` |'
echo '  ____) | |_) | | (_|  __/   | |____| | (_) | |_| | (_| |'
echo ' |_____/| .__/|_|\___\___|    \_____|_|\___/ \__,_|\__,_|'
echo '        | |                                              '
echo '        |_|                                              '
echo -e "${NC}"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}           🔐 Secure SSH Configuration Tool${NC}"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}                 Made by NekoSlayer_${NC}"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

sleep 1

echo -e "${BLUE}[⚡] Starting SpireCloud Security Hardening...${NC}\n"
sleep 1

# Backup original SSH config
echo -e "${YELLOW}[📦] Creating backup of original SSH config...${NC}"
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
echo -e "${GREEN}[✓] Backup created at /etc/ssh/sshd_config.backup${NC}\n"

echo -e "${BLUE}[🔧] Applying SpireCloud SSH Security Settings...${NC}"

# Update SSH config with safer defaults
sudo bash -c 'cat <<EOF > /etc/ssh/sshd_config
# ===========================================
# SpireCloud SSH Server Configuration
# ===========================================
# Made by NekoSlayer_
# ===========================================

# BASIC SETTINGS
Port 22
Protocol 2
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

# AUTHENTICATION SETTINGS
PermitRootLogin yes
PubkeyAuthentication no
PasswordAuthentication yes
PermitEmptyPasswords no
ChallengeResponseAuthentication no
UsePAM yes

# SECURITY HARDENING
X11Forwarding no
AllowTcpForwarding yes
MaxAuthTries 3
MaxSessions 10
ClientAliveInterval 300
ClientAliveCountMax 2
TCPKeepAlive yes
Compression no
PrintMotd no
PrintLastLog yes
AcceptEnv LANG LC_*

# LOGGING
SyslogFacility AUTH
LogLevel INFO

# SFTP CONFIGURATION
Subsystem sftp /usr/lib/openssh/sftp-server

# ===========================================
# End of SpireCloud Configuration
# ===========================================
EOF'

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✓] SSH configuration applied successfully!${NC}"
else
    echo -e "${RED}[✘] Failed to update SSH config!${NC}"
fi

echo -e "\n${BLUE}[🔄] Restarting SSH service...${NC}"
sudo systemctl restart ssh 2>/dev/null || sudo service ssh restart 2>/dev/null

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✓] SSH service restarted successfully!${NC}\n"
else
    echo -e "${RED}[✘] Failed to restart SSH service!${NC}\n"
fi

sleep 1

# Custom MOTD Installation
echo -e "${BLUE}[🎨] Installing SpireCloud Custom MOTD...${NC}"

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo -e "${YELLOW}[!] Installing curl...${NC}"
    sudo apt update &> /dev/null && sudo apt install curl -y &> /dev/null
fi

# Download and install MOTD
bash <(curl -fsSL https://raw.githubusercontent.com/hopingboyz/vps-motd/main/motd.sh) 2>/dev/null

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✓] Custom MOTD installed successfully!${NC}\n"
else
    echo -e "${RED}[✘] Failed to install custom MOTD!${NC}\n"
fi

sleep 1

clear

# Final SpireCloud Banner
echo -e "${CYAN}"
echo '   _____       _               _____ _                 _ '
echo '  / ____|     (_)             / ____| |               | |'
echo ' | (___  _ __  _  ___ ___    | |    | | ___  _   _  __| |'
echo '  \___ \| '"'"'_ \| |/ __/ _ \   | |    | |/ _ \| | | |/ _` |'
echo '  ____) | |_) | | (_|  __/   | |____| | (_) | |_| | (_| |'
echo ' |_____/| .__/|_|\___\___|    \_____|_|\___/ \__,_|\__,_|'
echo '        | |                                              '
echo '        |_|                                              '
echo -e "${NC}"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}          🎉 SpireCloud Setup Complete! 🎉${NC}"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}           Secure SSH Configuration Applied${NC}"
echo -e "${YELLOW}                Made with 💜 by NekoSlayer_${NC}"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Show current SSH status
echo -e "${BLUE}[📊] Current SSH Service Status:${NC}"
systemctl status ssh --no-pager -l 2>/dev/null | grep "Active:" || service ssh status 2>/dev/null | grep "Active:"
echo ""

# Important Information
echo -e "${YELLOW}[⚠️] IMPORTANT INFORMATION:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " • SSH Port: ${GREEN}22${NC}"
echo -e " • Root Login: ${GREEN}Enabled${NC}"
echo -e " • Password Auth: ${GREEN}Enabled${NC}"
echo -e " • Max Auth Tries: ${GREEN}3${NC}"
echo -e " • Backup Config: ${GREEN}/etc/ssh/sshd_config.backup${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Set root password
echo -e "${YELLOW}[🔑] Please set your ROOT password below 👇${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
sudo passwd root

echo -e "\n${GREEN}[✓] Root password updated successfully!${NC}\n"

# Final message
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✨ SpireCloud VPS is now secure and ready to use! ✨${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}📌 Quick Commands:${NC}"
echo -e "   • Check SSH status: ${YELLOW}systemctl status ssh${NC}"
echo -e "   • Test SSH config: ${YELLOW}sudo sshd -t${NC}"
echo -e "   • View MOTD: ${YELLOW}cat /etc/motd${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PURPLE}              🚀 Thank you for using SpireCloud! 🚀${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
