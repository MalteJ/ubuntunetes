#!/bin/bash
set -e
set -x

if [ -z $PEER_ADDR ]; then
  PEER_ADDR=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`

  if [ `echo "$PEER_ADDR" | wc -l` -gt 1 ]; then
    echo "Detected more than one IP address."
    echo "Please provide IP address via PEER_ADDR variable!"
    exit 1
  fi
fi
echo "Local IP address: $PEER_ADDR"

if [ -z $ETCD_MACHINE_NAME ]; then
  ETCD_MACHINE_NAME=`hostname`
fi

if [ -z $ETCD_DISCOVERY ]; then
  echo "You have to provide an etcd discovery url via ETCD_DISCOVERY variable!"
  echo "Create one at https://discovery.etcd.io/new"
  exit 1
fi

mkdir -p /var/local/etcd
touch /var/log/etcd

nohup /usr/local/etcd/etcd \
    -peer-addr $PEER_ADDR:7001 \
    -addr $PEER_ADDR:4001 \
    -data-dir /var/local/etcd \
    -name $ETCD_MACHINE_NAME \
    >> /var/log/etcd 2>&1 &
echo $! > /run/etcd.pid

tail -f /var/log/etcd &
sleep 5
