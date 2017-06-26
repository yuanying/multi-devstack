# Controller

## Routing

```bash
sudo ip route add 10.254.0.0/16 via 192.168.201.101
```

## Start logstash

```bash
docker run -ti --rm \
           -v /opt/stack/logs:/opt/stack/logs \
           -v ~/multi-devstack/compute/logstash/config:/usr/share/logstash/config \
           -v ~/multi-devstack/compute/logstash/pipeline:/usr/share/logstash/pipeline \
           docker.elastic.co/logstash/logstash:5.3.0
```
