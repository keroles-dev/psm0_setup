# /bin/bash

STATUS="$(systemctl is-active openvpn-client@vpn-client.service)"

if [ "${STATUS}" = "active" ]; then
    echo "Service running ..... so stop it";
    doas systemctl stop openvpn-client@vpn-client.service;

    doas ufw default allow outgoing;
    doas ufw reload;
    exit 0;
else 
    echo " Service not running ..... so run it";
    doas systemctl restart openvpn-client@vpn-client.service;
    doas ufw default deny outgoing;
    doas ufw reload;
    exit 0;
fi
