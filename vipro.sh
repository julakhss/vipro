# ================================================
#  VPS Auto Installer by Julak Bantur
#  Support: Ubuntu 20/22+, Debian 10/11+
# ================================================
apt update
apt install curl -y
apt install wget -y
apt install jq -y
apt install shc -y
# ================================================
# ---- Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'

#----Status
print_success() { echo -e "${GREEN}[OK]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_install() { echo -e "${YELLOW}[INFO]${NC} $1"; }

#---Link Github Anda
julak="https://raw.githubusercontent.com/julakhss/vipro/main/"
# ================================================
# Base Setup By ( Julak Bantur) ©2025
# ================================================
clear
# --- Detect OS & Version ---
print_install "Base Setup"
sleep 1
OS=$(lsb_release -is 2>/dev/null || grep ^ID= /etc/os-release | cut -d= -f2 | tr -d '"')
VER=$(lsb_release -rs 2>/dev/null || grep ^VERSION_ID= /etc/os-release | cut -d= -f2 | tr -d '"')

if [[ "$OS" =~ (Debian|debian) ]]; then
    DISTRO="Debian"
elif [[ "$OS" =~ (Ubuntu|ubuntu) ]]; then
    DISTRO="Ubuntu"
else
    echo "❌ Unsupported OS. Only Debian/Ubuntu supported."
    exit 1
fi

# --- Detect Firewall Backend ---#
if update-alternatives --get-selections 2>/dev/null | grep -q iptables-nft; then
    FIREWALL="iptables-nft"
elif update-alternatives --get-selections 2>/dev/null | grep -q iptables-legacy; then
    FIREWALL="iptables-legacy"
else
    FIREWALL="unknown"
fi

echo "=================================="
echo " OS Detected : $DISTRO $VER"
echo " Firewall    : $FIREWALL"
echo " Kernel      : $(uname -r)"
echo "=================================="

# --- Base Packages ---#
apt-get update -y
apt-get install -y wget curl unzip lsb-release cron systemd iptables netfilter-persistent

print_success "Base setup selesai"
sleep 2
clear

print_install "Buat folder penting"
mkdir -p /etc/xray
mkdir -p /var/lib/julak/ >/dev/null 2>&1
echo "IP=" >> /var/lib/julak/ipvps.conf
touch /etc/.{ssh,noobzvpns,vmess,vless,trojan,shadowsocks}.db
mkdir -p /etc/{xray,bot,vmess,vless,trojan,shadowsocks,ssh,noobzvpns,limit,usr}
touch /etc/noobzvpns/users.json
mkdir -p /etc/xray/limit
mkdir -p /etc/xray/limit/{ssh,vmess,vless,trojan,shadowsocks}
mkdir -p /etc/julak/limit/vmess/ip
mkdir -p /etc/julak/limit/vless/ip
mkdir -p /etc/julak/limit/trojan/ip
mkdir -p /etc/julak/limit/ssh/ip
mkdir -p /etc/limit/vmess
mkdir -p /etc/limit/vless
mkdir -p /etc/limit/trojan
mkdir -p /etc/limit/ssh
mkdir -p /etc/vmess
mkdir -p /etc/vless
mkdir -p /etc/trojan
mkdir -p /etc/shadowsocks
mkdir -p /etc/ssh
touch /etc/vmess/.vmess.db
touch /etc/vless/.vless.db
touch /etc/trojan/.trojan.db
touch /etc/shadowsocks/.shadowsocks.db
touch /etc/ssh/.ssh.db
touch /etc/bot/.bot.db
echo "& plughin Account" >>/etc/vmess/.vmess.db
echo "& plughin Account" >>/etc/vless/.vless.db
echo "& plughin Account" >>/etc/trojan/.trojan.db
echo "& plughin Account" >>/etc/shadowsocks/.shadowsocks.db
echo "& plughin Account" >>/etc/ssh/.ssh.db

echo -e ""
clear
echo -e "   =================================="
echo -e "   |\e[1;32mPlease Select a Domain Type Below \e[0m|"
echo -e "   =================================="
echo -e "     \e[1;32m1)\e[0m Use your domain"
echo -e "     \e[1;32m2)\e[0m Use random domain "
echo -e "   =================================="
read -p "   Please select numbers 1-2 or Any Button(Random) : " host
echo ""
if [[ $host == "1" ]]; then
echo -e "   \e[1;32mPlease Enter Your Subdomain $NC"
read -p "   Subdomain: " host1
echo "IP=" >> /var/lib/julak/ipvps.conf
echo $host1 > /etc/xray/domain
echo $host1 > /root/domain
echo ""
elif [[ $host == "2" ]]; then
#Pasang domain random by autoscript
wget ${julak}Jbs/cf.sh && chmod +x cf.sh && ./cf.sh
rm -f /root/cf.sh
clear
else
print_install "Random Subdomain/Domain is Used"
echo -e "Random domain is used"
wget ${julak}Jbs/cf.sh && chmod +x cf.sh && ./cf.sh
rm -f /root/cf.sh
clear
    fi
    
cd
print_install "Process Install Dependencies"
sleep 1
apt update -y
apt install sudo -y
sudo apt-get clean all
apt install -y debconf-utils
apt install p7zip-full -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y
apt-get autoremove -y
apt install at -y
apt install -y --no-install-recommends software-properties-common
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install iptables iptables-persistent netfilter-persistent libxml-parser-perl squid screen curl jq bzip2 gzip coreutils rsyslog zip unzip net-tools sed bc apt-transport-https build-essential dirmngr libxml-parser-perl lsof openvpn easy-rsa fail2ban tmux squid dropbear socat cron bash-completion ntpdate xz-utils apt-transport-https chrony pkg-config bison make git speedtest-cli p7zip-full zlib1g-dev python-is-python3 python3-pip shc build-essential nodejs nginx php php-fpm php-cli php-mysql p7zip-full squid libcurl4-openssl-dev

# remove unnecessary files
sudo apt-get autoclean -y >/dev/null 2>&1
audo apt-get -y --purge removd unscd >/dev/null 2>&1
sudo apt-get -y --purge remove samba* >/dev/null 2>&1
sudo apt-get -y --purge remove bind9* >/dev/null 2>&1
sudo apt-get -y remove sendmail* >/dev/null 2>&1
apt autoremove -y >/dev/null 2>&1
# finishing

print_success "Dependencies successfully installed..."
sleep 1.5

wget -q -O /etc/port.txt "${julak}Jbs/port.txt"

clear
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# ================================================
# Install all modules By (Julak Bantur) ©2025
# ================================================
# --- Download & Run Modules from GitHub ---
cd /root
echo -e "${c}┌──────────────────────────────────────────┐${NC}"
echo -e "${c}│       ${g}PROCESS INSTALL SSH & OPENVPN${NC}      ${c}│${NC}"
echo -e "${c}└──────────────────────────────────────────┘${NC}"
sleep 2
wget -q -O ssh-vpn.sh "https://raw.githubusercontent.com/julakhss/vipro/main/Jbs/ssh-vpn.sh"
chmod +x ssh-vpn.sh && ./ssh-vpn.sh
clear
echo -e "${c}┌──────────────────────────────────────────┐${NC}"
echo -e "${c}│            ${g}PROCESS INSTALL XRAY${NC}          ${c}│${NC}"
echo -e "${c}└──────────────────────────────────────────┘${NC}"
sleep 2
wget -q -O ins-xray.sh "https://raw.githubusercontent.com/julakhss/vipro/main/Jbs/ins-xray.sh"
chmod +x ins-xray.sh && ./ins-xray.sh
clear
echo -e "${c}┌──────────────────────────────────────────┐${NC}"
echo -e "${c}│        ${g}PROCESS INSTALL WEBSOCKET SSH${NC}     ${c}│${NC}"
echo -e "${c}└──────────────────────────────────────────┘${NC}"
sleep 2
wget -q -O insshws.sh "https://raw.githubusercontent.com/julakhss/vipro/main/Jws/insshws.sh"
chmod +x insshws.sh && ./insshws.sh
clear
echo -e "${c}┌──────────────────────────────────────────┐${NC}"
echo -e "${c}│        ${g}PROCESS INSTALL BACKUP MENU${NC}${c}       │${NC}"
echo -e "${c}└──────────────────────────────────────────┘${NC}"
sleep 2
wget -q -O installbckp.sh "https://raw.githubusercontent.com/julakhss/vipro/main/Jbs/installbckp.sh"
chmod +x installbckp.sh && ./installbckp.sh
clear
echo -e "${c}┌──────────────────────────────────────────┐${NC}"
echo -e "${c}│           ${g}PROCESS INSTALL OHP${NC}${c}          │${NC}"
echo -e "${c}└──────────────────────────────────────────┘${NC}"
#sleep 2
#wget -q -O installbckp.sh "https://raw.githubusercontent.com/julakhss/vipro/main/installbckp.sh"
#chmod +x installbckp.sh && ./installbckp.sh
clear
echo -e "${c}┌──────────────────────────────────────────┐${NC}"
echo -e "${c}│          ${g}PROCESS INSTALL SLOWDNS${NC}${c}                │${NC}"
echo -e "${c}└──────────────────────────────────────────┘${NC}"
#sleep 2
#wget -q -O installbckp.sh "https://raw.githubusercontent.com/julakhss/vipro/main/installbckp.sh"
#chmod +x installbckp.sh && ./installbckp.sh
clear
echo -e "${c}┌──────────────────────────────────────────┐${NC}"
echo -e "${c}│           ${g}PROCESS INSTALL UDP CUSTOM${NC}${c}             │${NC}"
echo -e "${c}└──────────────────────────────────────────┘${NC}"
sleep 2
wget -q -O udp-custom.sh "https://raw.githubusercontent.com/julakhss/vipro/main/Jbs/udp-custom.sh"
chmod +x udp-custom.sh && ./udp-custom.sh
clear
echo -e "${c}┌──────────────────────────────────────────┐${NC}"
echo -e "${c}│           ${g}PROCESS INSTALL THEME .......${NC}${c}             │${NC}"
echo -e "${c}└──────────────────────────────────────────┘${NC}"
sleep 2
wget -q -O tm.sh "https://raw.githubusercontent.com/kdg-hss/tm/main/tm.sh"
chmod +x tm.sh && ./tm.sh
clear
echo -e "${c}┌──────────────────────────────────────────┐${NC}"
echo -e "${c}│           ${g}PROCESS INSTALL MENU ........${NC}${c}             │${NC}"
echo -e "${c}└──────────────────────────────────────────┘${NC}"
sleep 2
wget -q -O up.sh "https://raw.githubusercontent.com/julakhss/vipro/main/Jbs/up.sh"
chmod +x up.sh && ./up.sh
clear

# ================================================
# Final stage By (Julak Bantur) ©2025
# ================================================
# Tentukan nilai baru yang diinginkan untuk fs.file-max
NEW_FILE_MAX=65535  # Ubah sesuai kebutuhan Anda

# Nilai tambahan untuk konfigurasi netfilter
NF_CONNTRACK_MAX="net.netfilter.nf_conntrack_max=262144"
NF_CONNTRACK_TIMEOUT="net.netfilter.nf_conntrack_tcp_timeout_time_wait=30"

# File yang akan diedit
SYSCTL_CONF="/etc/sysctl.conf"

# Ambil nilai fs.file-max saat ini
CURRENT_FILE_MAX=$(grep "^fs.file-max" "$SYSCTL_CONF" | awk '{print $3}' 2>/dev/null)

# Cek apakah nilai fs.file-max sudah sesuai
if [ "$CURRENT_FILE_MAX" != "$NEW_FILE_MAX" ]; then
    # Cek apakah fs.file-max sudah ada di file
    if grep -q "^fs.file-max" "$SYSCTL_CONF"; then
        # Jika ada, ubah nilainya
        sed -i "s/^fs.file-max.*/fs.file-max = $NEW_FILE_MAX/" "$SYSCTL_CONF" >/dev/null 2>&1
    else
        # Jika tidak ada, tambahkan baris baru
        echo "fs.file-max = $NEW_FILE_MAX" >> "$SYSCTL_CONF" 2>/dev/null
    fi
fi

# Cek apakah net.netfilter.nf_conntrack_max sudah ada
if ! grep -q "^net.netfilter.nf_conntrack_max" "$SYSCTL_CONF"; then
    echo "$NF_CONNTRACK_MAX" >> "$SYSCTL_CONF" 2>/dev/null
fi

# Cek apakah net.netfilter.nf_conntrack_tcp_timeout_time_wait sudah ada
if ! grep -q "^net.netfilter.nf_conntrack_tcp_timeout_time_wait" "$SYSCTL_CONF"; then
    echo "$NF_CONNTRACK_TIMEOUT" >> "$SYSCTL_CONF" 2>/dev/null
fi

# Terapkan perubahan
sysctl -p >/dev/null 2>&1

cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
mukung1
END
chmod 644 /root/.profile
if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
history -c
serverV=$( curl -sS ${repo}versi  )
echo $serverV > /root/.versi

echo "00" > /home/daily_reboot
aureb=$(cat /home/daily_reboot)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
cd

rm -f /root/*.sh
rm -f /root/*.txt

# DATA 
IPKU=$(wget -qO- ipinfo.io/ip)
HOST=$(cat /etc/xray/domain)
TIMES="10"
CHATID="2118266757"
KEY="6561892159:AAEfW_wh32WA3KzJDVrvFDDbtazjcmA2Cc4"
URL="https://api.telegram.org/bot$KEY/sendMessage"
UCLIENT=$(wget -qO- https://raw.githubusercontent.com/cibut2d/reg/main/ip | grep $ipsaya | awk '{print $2}')
EXSC=$(wget -qO- https://raw.githubusercontent.com/cibut2d/reg/main/ip | grep $ipsaya | awk '{print $3}')
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")
TIMEZONE=$(printf '%(%H:%M:%S)T')

# Pesan notifikasi Telegram
    TEXT="
<code>────────────────────</code>
<b>⚡AUTOSCRIPT PREMIUM VIPRO⚡</b>
<code>────────────────────</code>
<code>ID     : </code><code>$UCLIENT</code>
<code>Domain : </code><code>$HOST</code>
<code>Date   : </code><code>$TIME</code>
<code>Time   : </code><code>$TIMEZONE</code>
<code>Ip vps : </code><code>$IPKU</code>
<code>Exp Sc : </code><code>$EXSC</code>
<code>────────────────────</code>
<i>Automatic Notification from Github</i>
"'&reply_markup={"inline_keyboard":[[{"text":"ORDER🐳","url":"https://t.me/Cibut2d"},{"text":"GROUP🐬","url":"https://chat.whatsapp.com/IMwXEDPHxatHBg9bOk7iME"}]]}'
    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

cd
rm ~/.bash_history
rm -f openvpn
rm -f key.pem
rm -f cert.pem
rm -f $0
history -c

sleep 3
echo  ""
cd
clear
echo -e "${c}┌────────────────────────────────────────────┐${NC}"
echo -e "${c}│  ${g}INSTALL SCRIPT SELESAI..${NC}                  ${c}│${NC}"
echo -e "${c}└────────────────────────────────────────────┘${NC}"
echo  ""
sleep 4
    echo -e ""
    echo -e "    ┌───────────────────────────────────────────────┐"
    echo -e " ───│                                               │───"
    echo -e " ───│    $Green┌─┐┬ ┬┌┬┐┌─┐┌─┐┌─┐┬─┐┬┌─┐┌┬┐  ┬  ┬┌┬┐┌─┐$VC   │───"
    echo -e " ───│    $Green├─┤│ │ │ │ │└─┐│  ├┬┘│├─┘ │   │  │ │ ├┤ $VC   │───"
    echo -e " ───│    $Green┴ ┴└─┘ ┴ └─┘└─┘└─┘┴└─┴┴   ┴   ┴─┘┴ ┴ └─┘$VC   │───"
    echo -e "    │    ${YELLOW}Copyright${FONT} (C)${GRAY}https://t.me/rajaganjil93$VC   │"
    echo -e "    └───────────────────────────────────────────────┘"
    echo -e "         ${BLUE}Autoscript xray vpn lite (multi port)${FONT}    "
    echo -e "${BLUE}Make sure the internet is smooth when installing the script${FONT}"
    echo -e "        "
    echo "    ┌─────────────────────────────────────────────────────┐"
    echo "    │       >>> Service & Port                            │"
    echo "    │   - Open SSH                : 22                    │"
    echo "    │   - UDP SSH                 : 1-65535               │"
    echo "    │   - Dropbear                : 443, 109, 143         │"
    echo "    │   - Dropbear Websocket      : 443, 109              │"
    echo "    │   - SSH Websocket SSL       : 443                   │"
    echo "    │   - SSH Websocket           : 80                    │"
    echo "    │   - OpenVPN SSL             : 443                   │"
    echo "    │   - OpenVPN Websocket SSL   : 443                   │"
    echo "    │   - OpenVPN TCP             : 443, 1194             │"
    echo "    │   - OpenVPN UDP             : 2200                  │"
    echo "    │   - Nginx Webserver         : 443, 89, 81           │"
    echo "    │   - Haproxy Loadbalancer    : 443, 80               │"
    echo "    │   - XRAY Vmess TLS          : 443                   │"
    echo "    │   - XRAY Vmess gRPC         : 443                   │"
    echo "    │   - XRAY Vmess None TLS     : 80                    │"
    echo "    │   - XRAY Vless TLS          : 443                   │"
    echo "    │   - XRAY Vless gRPC         : 443                   │"
    echo "    │   - XRAY Vless None TLS     : 80                    │"
    echo "    │   - Trojan gRPC             : 443                   │"
    echo "    │   - Trojan WS               : 443                   │"
    echo "    │                                                     │"
    echo "    │      >>> Server Information & Other Features        │"
    echo "    │   - Timezone                : Asia/Jakarta (GMT +7) │"
    echo "    │   - Autoreboot On           : $AUTOREB:05 $TIME_DATE GMT +7        │"
    echo "    │   - Auto Delete Expired Account                     │"
    echo "    │   - Fully automatic script                          │"
    echo "    │   - VPS settings                                    │"
    echo "    │   - Admin Control                                   │"
    echo "    │   - Restore Data                                    │"
    echo "    │   - Simple BOT Telegram                             │"
    echo "    │   - Full Orders For Various Services                │"
    echo "    └─────────────────────────────────────────────────────┘"
    secs_to_human "$(($(date +%s) - ${start}))"
    read -e -p "         Please Reboot Your Vps [y/n] " -i "y" str
    if [ "$str" = "y" ]; then

        reboot

    fi