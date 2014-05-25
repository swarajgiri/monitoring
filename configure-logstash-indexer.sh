#!/bin/bash
##
# Configures Logstash as an indexer
#
# Provides:
# - Lumberjack (TCP/5043)
#
# Dependencies:
# - Elasticsearch (any version)
# - Logstash
# - Redis
# - SSL certificate generated with `generate-lumberjack-ssl.sh`
##
BASE_PATH=`pwd`
TMP_PATH=$BASE_PATH/tmp

cp $BASE_PATH/etc/logstash/conf.d/10-input-lumberjack.conf /etc/logstash/conf.d
cp $BASE_PATH/etc/logstash/conf.d/10-input-redis.conf /etc/logstash/conf.d
cp $BASE_PATH/etc/logstash/conf.d/50-filter-* /etc/logstash/conf.d
cp $BASE_PATH/etc/logstash/conf.d/90-output-elasticsearch.conf /etc/logstash/conf.d

cp $TMP_PATH/forwarder.crt $TMP_PATH/forwarder.key /etc/logstash
chown logstash:logstash /etc/logstash/forwarder.key
chmod 640 /etc/logstash/forwarder.key

service logstash restart
