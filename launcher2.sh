
#!/bin/bash
_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$child"
}
trap _term SIGTERM
env
#Next script needed for enb setup
#./dns_replace.sh 
iptables -t nat -A POSTROUTING -o tun+ -j MASQUERADE
cat /etc/srslte/enb.conf
./srsLTE/build/srsepc/src/srsepc &
./srsenb/src/srsenb --rf.device_name=zmq --rf.device_args="fail_on_disconnect=true,tx_port=tcp://*:2000,rx_port=tcp://localhost:2001,id=enb,base_srate=23.04e6" &
child=$!
wait "$child"
