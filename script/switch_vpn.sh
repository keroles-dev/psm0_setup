# /bin/bash

file=$1
conf_file=/etc/openvpn/client/$file

proto=$(cat $conf_file | grep -oP '(?<=proto )[^\n]*')
res=($(cat $conf_file | grep -Pzo '(?<=[^\#]remote )[^\n]*'))

remotes=()
res_length=${#res[@]}

# concatenate ip and port
for (( i=0; i<$res_length; i+=2 ));
do
  remotes+=("${res[$i]} ${res[$i+1]}")
done

service_name=$(echo $file | grep -oP '.*(?=.conf)')

STATUS="$(systemctl is-active openvpn-client@$service_name.service)"

if [ "${STATUS}" = "active" ]; then
    echo "$service_name running ..... so stop it";
    doas systemctl stop openvpn-client@$service_name.service;

    # allow connection to vpn servers
    for remote in "${remotes[@]}"
    do
      ip_port=($remote)
      doas ufw delete allow out from any to ${ip_port[0]} port ${ip_port[1]} proto $proto
    done

    doas ufw delete allow out on tun0 from any to 0.0.0.0/0
    doas ufw default allow outgoing;
    doas ufw reload;
    exit 0;
else 
    echo "$service_name not running ..... so run it";
    doas systemctl restart openvpn-client@$service_name.service;

    # allow connection to vpn servers
    for remote in "${remotes[@]}"
    do
      ip_port=($remote)
      doas ufw allow out from any to ${ip_port[0]} port ${ip_port[1]} proto $proto
    done

    doas ufw allow out on tun0 from any to 0.0.0.0/0
    doas ufw default deny outgoing;
    doas ufw reload;
    exit 0;
fi
