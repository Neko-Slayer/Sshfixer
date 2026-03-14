#!/bin/bash

# ===========================================
# SpireCloud MOTD Installer - Clean Version
# ===========================================
# Made by NekoSlayer_
# No Public IP - Local IP Only
# ===========================================

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Clear screen
clear

# SpireCloud Banner
echo -e "${CYAN}"
echo '   _____       _               _____ _                 _ '
echo '  / ____|     (_)             / ____| |               | |'
echo ' | (___  _ __  _  ___ ___    | |    | | ___  _   _  __| |'
echo '  \___ \| '\''_ \| |/ __/ _ \   | |    | |/ _ \| | | |/ _` |'
echo '  ____) | |_) | | (_|  __/   | |____| | (_) | |_| | (_| |'
echo ' |_____/| .__/|_|\___\___|    \_____|_|\___/ \__,_|\__,_|'
echo '        | |                                              '
echo '        |_|                                              '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}         📦 MOTD Installer - Clean Edition (No Public IP)${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Check root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}[✘] Please run as root: sudo bash $0${NC}\n"
   exit 1
fi

# Step 1: Clean default MOTD
echo -e "${BLUE}[1/4] 🧹 Cleaning default MOTD...${NC}"

# Remove all existing MOTD
rm -f /etc/motd
rm -f /etc/update-motd.d/*
rm -f /etc/profile.d/*motd* 2>/dev/null
rm -f /etc/profile.d/*spirecloud* 2>/dev/null

# Disable PAM MOTD
sed -i 's/^session    optional     pam_motd.so/#session    optional     pam_motd.so/' /etc/pam.d/sshd 2>/dev/null
sed -i 's/^session    optional     pam_motd.so/#session    optional     pam_motd.so/' /etc/pam.d/login 2>/dev/null

echo -e "${GREEN}[✓] Default MOTD cleaned${NC}\n"

# Step 2: Create new MOTD
echo -e "${BLUE}[2/4] ✨ Creating SpireCloud MOTD...${NC}"

cat > /etc/profile.d/spirecloud.sh << 'EOF'
#!/bin/bash

# ===========================================
# SpireCloud MOTD - Clean Edition
# ===========================================
# Made by NekoSlayer_
# No Public IP - Fast & Clean
# ===========================================

# Only show once
if [ -n "$BASH" ] && [ -z "$SPIRECLOUD" ]; then
    export SPIRECLOUD=1
    
    # Colors
    RED='\033[1;31m'
    GREEN='\033[1;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[1;34m'
    PURPLE='\033[1;35m'
    CYAN='\033[1;36m'
    WHITE='\033[1;37m'
    NC='\033[0m'
    
    clear
    
    # Header
    echo -e "${CYAN}"
    echo '   _____       _               _____ _                 _ '
    echo '  / ____|     (_)             / ____| |               | |'
    echo ' | (___  _ __  _  ___ ___    | |    | | ___  _   _  __| |'
    echo '  \___ \| '\''_ \| |/ __/ _ \   | |    | |/ _ \| | | |/ _` |'
    echo '  ____) | |_) | | (_|  __/   | |____| | (_) | |_| | (_| |'
    echo ' |_____/| .__/|_|\___\___|    \_____|_|\___/ \__,_|\__,_|'
    echo '        | |                                              '
    echo '        |_|                                              '
    echo -e "${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}                    🚀 Welcome to SpireCloud${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    # System Info
    echo -e "${GREEN}📌 SYSTEM INFORMATION${NC}"
    echo -e "${WHITE}──────────────────────────────────────────────────────${NC}"
    printf " ${WHITE}►${NC} Hostname    : ${CYAN}%s${NC}\n" "$(hostname)"
    printf " ${WHITE}►${NC} OS          : ${CYAN}%s${NC}\n" "$(lsb_release -d 2>/dev/null | cut -f2 || . /etc/os-release && echo "$PRETTY_NAME")"
    printf " ${WHITE}►${NC} Kernel      : ${CYAN}%s${NC}\n" "$(uname -r)"
    printf " ${WHITE}►${NC} Uptime      : ${CYAN}%s${NC}\n" "$(uptime -p | sed 's/up //')"
    printf " ${WHITE}►${NC} Load Avg    : ${CYAN}%s${NC}\n" "$(uptime | awk -F'load average:' '{print $2}')"
    echo ""
    
    # Hardware
    echo -e "${GREEN}💻 HARDWARE STATUS${NC}"
    echo -e "${WHITE}──────────────────────────────────────────────────────${NC}"
    printf " ${WHITE}►${NC} CPU Cores   : ${CYAN}%s${NC}\n" "$(nproc)"
    printf " ${WHITE}►${NC} Memory      : ${CYAN}%s${NC}\n" "$(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    printf " ${WHITE}►${NC} Disk Usage  : ${CYAN}%s${NC}\n" "$(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
    echo ""
    
    # Network - LOCAL IP ONLY
    echo -e "${GREEN}🌐 NETWORK INFO${NC}"
    echo -e "${WHITE}──────────────────────────────────────────────────────${NC}"
    printf " ${WHITE}►${NC} Local IP    : ${CYAN}%s${NC}\n" "$(hostname -I | awk '{print $1}')"
    # PUBLIC IP COMPLETELY REMOVED
    echo ""
    
    # Users
    echo -e "${GREEN}👥 ACTIVE SESSIONS${NC}"
    echo -e "${WHITE}──────────────────────────────────────────────────────${NC}"
    USERS=$(who | wc -l)
    printf " ${WHITE}►${NC} Online Users: ${CYAN}%s${NC}\n" "$USERS"
    if [ $USERS -gt 0 ]; then
        who | while read user tty from rest; do
            printf "   ${WHITE}→${NC} %s from ${YELLOW}%s${NC}\n" "$user" "$from"
        done
    fi
    echo ""
    
    # Last Login
    echo -e "${GREEN}📝 LAST LOGIN${NC}"
    echo -e "${WHITE}──────────────────────────────────────────────────────${NC}"
    last -n 1 | head -n 1 | sed 's/^/   /'
    echo ""
    
    # Quick Tips
    echo -e "${GREEN}⚡ QUICK COMMANDS${NC}"
    echo -e "${WHITE}──────────────────────────────────────────────────────${NC}"
    echo -e " ${WHITE}►${NC} ${YELLOW}htop${NC}        - System monitor"
    echo -e " ${WHITE}►${NC} ${YELLOW}df -h${NC}       - Disk usage"
    echo -e " ${WHITE}►${NC} ${YELLOW}free -h${NC}      - Memory usage"
    echo -e " ${WHITE}►${NC} ${YELLOW}who${NC}          - Active users"
    echo -e " ${WHITE}►${NC} ${YELLOW}exit${NC}         - Logout"
    echo ""
    
    # Footer
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}            Made with ${RED}❤️${WHITE} by NekoSlayer_${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
fi
EOF

chmod +x /etc/profile.d/spirecloud.sh
echo -e "${GREEN}[✓] SpireCloud MOTD created${NC}\n"

# Step 3: Configure SSH
echo -e "${BLUE}[3/4] 🔧 Configuring SSH...${NC}"

# Disable PrintMotd in SSH
sed -i 's/^#PrintMotd.*/PrintMotd no/' /etc/ssh/sshd_config 2>/dev/null
sed -i 's/^PrintMotd.*/PrintMotd no/' /etc/ssh/sshd_config 2>/dev/null
if ! grep -q "^PrintMotd no" /etc/ssh/sshd_config; then
    echo "PrintMotd no" >> /etc/ssh/sshd_config
fi

# Restart SSH
systemctl restart ssh 2>/dev/null || service ssh restart 2>/dev/null
echo -e "${GREEN}[✓] SSH configured${NC}\n"

# Step 4: Final check
echo -e "${BLUE}[4/4] ✅ Finalizing...${NC}"
sleep 1

# Clear screen for final output
clear

# Final banner
echo -e "${CYAN}"
echo '   _____       _               _____ _                 _ '
echo '  / ____|     (_)             / ____| |               | |'
echo ' | (___  _ __  _  ___ ___    | |    | | ___  _   _  __| |'
echo '  \___ \| '\''_ \| |/ __/ _ \   | |    | |/ _ \| | | |/ _` |'
echo '  ____) | |_) | | (_|  __/   | |____| | (_) | |_| | (_| |'
echo ' |_____/| .__/|_|\___\___|    \_____|_|\___/ \__,_|\__,_|'
echo '        | |                                              '
echo '        |_|                                              '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}          ✅ MOTD Installation Complete!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Installation details
echo -e "${YELLOW}📦 INSTALLED FILES:${NC}"
echo -e "   ${WHITE}•${NC} /etc/profile.d/spirecloud.sh"
echo -e "   ${WHITE}•${NC} SSH config updated (PrintMotd no)"
echo ""

# Important notes
echo -e "${GREEN}📌 IMPORTANT NOTES:${NC}"
echo -e "   ${WHITE}•${NC} ${YELLOW}Public IP is REMOVED${NC} - Sirf local IP dikhega"
echo -e "   ${WHITE}•${NC} MOTD will show on ${GREEN}NEXT login${NC} (current session mein nahi)"
echo -e "   ${WHITE}•${NC} To test now: ${CYAN}bash /etc/profile.d/spirecloud.sh${NC}"
echo ""

# Preview option
echo -e "${PURPLE}────────────────────────────────────────────────────────────${NC}"
read -p "   📺 Abhi preview dekhna chahte ho? (y/n): " -n 1 -r preview
echo
if [[ $preview =~ ^[Yy]$ ]]; then
    echo -e "\n${CYAN}📺 PREVIEW:${NC}"
    echo -e "${PURPLE}────────────────────────────────────────────────────────────${NC}"
    bash /etc/profile.d/spirecloud.sh
else
    echo -e "\n${GREEN}✅ Installation complete! Logout aur login karo naya MOTD dekhne ke liye.${NC}\n"
fi

# Logout reminder
echo -e "${YELLOW}⚠️  REMEMBER:${NC} Logout kar ke vapas login karo: ${WHITE}exit${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"
