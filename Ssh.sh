#!/bin/bash

# ===========================================
# Secure SSH Setup + Custom MOTD - SpireCloud
# ===========================================
# Modified for SpireCloud by NekoSlayer_
# ===========================================

clear

echo -e "\033[1;36m🔐 SpireCloud - Secure SSH Configuration\033[0m"
echo -e "\033[1;37m--------------------------------------\033[0m"

sleep 1

echo -e "\033[1;34m▶ Updating SSH settings...\033[0m"

# Update SSH config with safer defaults
sudo bash -c 'cat <<EOF > /etc/ssh/sshd_config
# SSH LOGIN SETTINGS
PasswordAuthentication yes
PermitRootLogin yes
PubkeyAuthentication no
ChallengeResponseAuthentication no
UsePAM yes

# SECURITY IMPROVEMENTS
X11Forwarding no
AllowTcpForwarding yes

# SFTP SETTINGS
Subsystem sftp /usr/lib/openssh/sftp-server
EOF'

if [ $? -eq 0 ]; then
    echo -e "\033[1;32m✔ SSH configuration applied successfully!\033[0m"
else
    echo -e "\033[1;31m✘ Failed to update SSH config!\033[0m"
fi

echo -e "\033[1;34m▶ Restarting SSH service...\033[0m"
sudo systemctl restart ssh || sudo service ssh restart

echo -e "\033[1;32m✔ SSH service restarted successfully!\033[0m"
sleep 1

# Custom MOTD Install - UPDATED LINK
echo -e "\033[1;34m▶ Installing SpireCloud Custom MOTD...\033[0m"
bash <(curl -fsSL https://raw.githubusercontent.com/Neko-Slayer/Sshfixer/main/Motd.sh)

echo -e "\033[1;32m✔ SpireCloud MOTD Installed!\033[0m"
sleep 1

clear

# SpireCloud ASCII Banner
cat << "EOF"

   _____       _               _____ _                 _  
  / ____|     (_)             / ____| |               | |  
 | (___  _ __  _  ___ ___    | |    | | ___  _   _  __| |  
  \___ \| '_ \| |/ __/ _ \   | |    | |/ _ \| | | |/ _` |  
  ____) | |_) | | (_|  __/   | |____| | (_) | |_| | (_| |  
 |_____/| .__/|_|\___\___|    \_____|_|\___/ \__,_|\__,_|  
        | |                                                
        |_|                                                

EOF

echo -e "\033[1;32m🎉 SSH Configuration Completed Successfully!\033[0m"
echo -e "\033[1;37m📌 SpireCloud VPS setup completed.\033[0m"
echo -e "\033[1;35m   Made by NekoSlayer_\033[0m"

echo -e "\n\033[1;33m🔑 Please set your ROOT password below 👇\033[0m"
sudo passwd root

echo -e "\n\033[1;36m✨ All done! Enjoy your secure SpireCloud server! 🚀\033[0m"
