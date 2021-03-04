
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
child=$!
wait "$child"
