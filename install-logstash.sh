#!/usr/bin/env bash

set -eu
export LC_ALL=C

script_dir=$(dirname "${BASH_SOURCE}")
pushd ${script_dir} > /dev/null
script_dir=`pwd`
popd > /dev/null

export ES_URL=${ES_URL:-"http://elasticsearch:9200"}
export ES_USER=${ES_USER:-"elastic"}
export ES_PASSWORD=${ES_PASSWORD:-"changeme"}

echo "Elasticsearch Configuration"
echo "  URL: ${ES_URL}"
echo "  User: ${ES_USER}"
echo "  Password: ${ES_PASSWORD}"
echo

rm -rf ${script_dir}/temp
cp -rp ${script_dir}/logstash ${script_dir}/temp

sed -i='' -e "s|__ES_URL__|${ES_URL}|g" ${script_dir}/temp/config/logstash.yml
sed -i='' -e "s|__ES_USER__|${ES_USER}|g" ${script_dir}/temp/config/logstash.yml
sed -i='' -e "s|__ES_PASSWORD__|${ES_PASSWORD}|g" ${script_dir}/temp/config/logstash.yml

sed -i='' -e "s|__ES_URL__|${ES_URL}|g" ${script_dir}/temp/pipeline/openstack.conf
sed -i='' -e "s|__ES_USER__|${ES_USER}|g" ${script_dir}/temp/pipeline/openstack.conf
sed -i='' -e "s|__ES_PASSWORD__|${ES_PASSWORD}|g" ${script_dir}/temp/pipeline/openstack.conf


docker run -ti -d \
           --name logstash \
           --hostname $(hostname) \
           -v /opt/stack/logs:/opt/stack/logs \
           -v ${script_dir}/temp/config:/usr/share/logstash/config \
           -v ${script_dir}/temp/pipeline:/usr/share/logstash/pipeline \
           docker.elastic.co/logstash/logstash:5.3.0
