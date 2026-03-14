#!/bin/bash

# ===========================================
# SpireCloud Custom MOTD Installer
# ===========================================
# Made by NekoSlayer_
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

clear

# Banner
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
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}              🎨 Custom MOTD Installer${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

sleep 1

# Check root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}[✘] Please run as root: sudo bash $0${NC}\n"
   exit 1
fi

# ===========================================
# Disable Default MOTD
# ===========================================
echo -e "${BLUE}[1/3] Disabling default MOTD...${NC}"

# Remove static MOTD
rm -f /etc/motd
touch /etc/motd

# Disable update-motd scripts
if [ -d "/etc/update-motd.d" ]; then
    chmod -x /etc/update-motd.d/* 2>/dev/null
    echo -e "${GREEN}[✓] Update-motd scripts disabled${NC}"
fi

# Disable PAM MOTD
sed -i 's/^session    optional     pam_motd.so/#session    optional     pam_motd.so/' /etc/pam.d/sshd 2>/dev/null
sed -i 's/^session    optional     pam_motd.so/#session    optional     pam_motd.so/' /etc/pam.d/login 2>/dev/null
echo -e "${GREEN}[✓] PAM MOTD disabled${NC}\n"

# ===========================================
# Install SpireCloud MOTD
# ===========================================
echo -e "${BLUE}[2/3] Installing SpireCloud MOTD...${NC}"

# Create MOTD script
cat > /etc/profile.d/spirecloud-motd.sh << 'EOF'
#!/bin/bash

# SpireCloud MOTD
# Made by NekoSlayer_
# Public IP Removed - Clean Version

# Only show once per session
if [ -n "$BASH" ] && [ -z "$SPIRECLOUD_SHOWN" ]; then
    export SPIRECLOUD_SHOWN=1
    
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
    echo -e "${WHITE}                    Welcome to SpireCloud${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # System Info
    echo -e "${GREEN}📊 SYSTEM INFORMATION${NC}"
    echo -e "${CYAN}───────────────────────────────────────────────────────────${NC}"
    echo -e " ${WHITE}Hostname:${NC}     $(hostname)"
    echo -e " ${WHITE}OS:${NC}          $(lsb_release -d 2>/dev/null | cut -f2 || cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
    echo -e " ${WHITE}Kernel:${NC}       $(uname -r)"
    echo -e " ${WHITE}Uptime:${NC}       $(uptime -p | sed 's/up //')"
    echo -e " ${WHITE}Load:${NC}         $(uptime | awk -F'load average:' '{print $2}')"
    echo ""
    
    # Hardware
    echo -e "${GREEN}🖥️  HARDWARE STATUS${NC}"
    echo -e "${CYAN}───────────────────────────────────────────────────────────${NC}"
    echo -e " ${WHITE}CPU Cores:${NC}    $(nproc)"
    echo -e " ${WHITE}Memory:${NC}       $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    echo -e " ${WHITE}Disk (/):${NC}     $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
    echo ""
    
    # Network Info - LOCAL IP ONLY (Public IP Removed)
    echo -e "${GREEN}🌐 NETWORK INFO${NC}"
    echo -e "${CYAN}───────────────────────────────────────────────────────────${NC}"
    echo -e " ${WHITE}Local IP:${NC}     $(hostname -I | awk '{print $1}')"
    # PUBLIC IP PART HATAYA - ab sirf local IP dikhega
    echo ""
    
    # Users
    echo -e "${GREEN}👥 ACTIVE USERS${NC}"
    echo -e "${CYAN}───────────────────────────────────────────────────────────${NC}"
    USERS=$(who | wc -l)
    echo -e " ${WHITE}Users online:${NC} $USERS"
    [ $USERS -gt 0 ] && who | awk '{printf "   → %s from %s\n", $1, $5}'
    echo ""
    
    # Last Login
    echo -e "${GREEN}📝 LAST LOGIN${NC}"
    echo -e "${CYAN}───────────────────────────────────────────────────────────${NC}"
    last -n 1 | head -n 1 | sed 's/^/   /'
    echo ""
    
    # Footer
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}            🚀 Made with ${RED}❤️${WHITE} by NekoSlayer_ 🚀${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
fi
EOF

# Make executable
chmod +x /etc/profile.d/spirecloud-motd.sh
echo -e "${GREEN}[✓] SpireCloud MOTD installed${NC}\n"

# ===========================================
# Configure SSH to not show default MOTD
# ===========================================
echo -e "${BLUE}[3/3] Configuring SSH settings...${NC}"

# Update SSH config
if [ -f "/etc/ssh/sshd_config" ]; then
    sed -i 's/^#PrintMotd.*/PrintMotd no/' /etc/ssh/sshd_config
    sed -i 's/^PrintMotd.*/PrintMotd no/' /etc/ssh/sshd_config
    echo -e "${GREEN}[✓] SSH PrintMotd disabled${NC}"
    
    # Restart SSH
    systemctl restart ssh 2>/dev/null || service ssh restart 2>/dev/null
    echo -e "${GREEN}[✓] SSH restarted${NC}"
fi

echo ""

# ===========================================
# Done
# ===========================================
clear

# Final Banner
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
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}          ✅ SpireCloud MOTD Installed Successfully!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Instructions
echo -e "${YELLOW}📌 NOTES:${NC}"
echo -e "   • ${WHITE}MOTD will appear on NEXT login${NC}"
echo -e "   • ${WHITE}Current session mein nahi dikhega${NC}"
echo -e "   • ${WHITE}Logout kar ke vapas login karo${NC}"
echo -e "   • ${WHITE}Public IP removed - sirf local IP dikhega${NC}\n"

# Test command
echo -e "${GREEN}⚡ Manual test:${NC}"
echo -e "   bash /etc/profile.d/spirecloud-motd.sh\n"

# Exit message
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${PURPLE}           🚀 Thank you for using SpireCloud! 🚀${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}\n"

# Optional: Show preview
read -p "Abhi preview dekhna chahte ho? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash /etc/profile.d/spirecloud-motd.sh
fi
