
#!/bin/bash
_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$child"
}
trap _term SIGTERM
env

# check if install mode has been provided
if ([ ! $1 ])
then
  echo "Please call script with the right EPC IP."
  echo ""
  echo "E.g. 172.17.0.2"
  exit
fi

EPC_IP = $1

echo "EPC IP: $EPC_IP"

ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)

echo "srsLTE local interface ip: $ip4"

#Next script needed for enb setup
#./dns_replace.sh 
iptables -t nat -A POSTROUTING -o tun+ -j MASQUERADE

sed -i 's/EPC_IP/'$1'/g' /etc/srslte/enb.conf
sed -i 's/LOCAL_INTERFACE_IP/'$ip4'/g' /etc/srslte/enb.conf

cat /etc/srslte/enb.conf
#./srsLTE/build/srsepc/src/srsepc &
./srsLTE/build/srsenb/src/srsenb --rf.device_name=zmq --rf.device_args="fail_on_disconnect=true,tx_port=tcp://*:2000,rx_port=tcp://localhost:2001,id=enb,base_srate=23.04e6" &
child=$!
wait "$child"