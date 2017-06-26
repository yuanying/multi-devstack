# Readme!!

## Controller

```bash
sudo iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
sudo mkdir - p /etc/neutron
sudo chown -R $USER /etc/neutron
echo "dhcp-option-force=26,1400" >> /etc/neutron/dnsmasq.conf
sudo mkdir /opt/stack
sudo chown -R $USER /opt/stack
cd /opt/stack
mkdir logs
cd logs
mkdir keystone nova cinder glance neutron swift heat octavia
cd ~
git clone https://git.openstack.org/openstack-dev/devstack
cd devstack
```

## Logstash

```bash
sudo ip route add 10.254.0.0/16 via 192.168.201.101
sudo ES_URL='http://10.254.0.125:9200' ./install-logstash.sh
```
