# /bin/bash

STATUS="$(systemctl is-active openvpn-client@us-free-100060.protonvpn.tcp.ovpn.service)"

if [ "${STATUS}" = "active" ]; then
    echo "Servce running ..... so stop it";
    doas systemctl stop openvpn-client@us-free-100060.protonvpn.tcp.ovpn.service;
    doas ufw default allow outgoing;
    doas ufw reload;
    exit 0;
else 
    echo " Service not running ..... so run it";
    doas systemctl restart openvpn-client@us-free-100060.protonvpn.tcp.ovpn.service;
    doas ufw default deny outgoing;
    doas ufw reload;
    exit 0;
fi
