#!/bin/bash
set -e
set -x

GO_VERSION=1.3.3
ETCD_VERSION=0.4.6
KUBERNETES_VERSION=0.5.4

if [ ! -e /usr/bin/wget ]; then
	echo "Installing wget..."
	apt-get update
	apt-get install -y wget
fi

echo "Installing Go..."
cd /usr/local
wget --quiet https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz
tar xzf go$GO_VERSION.linux-amd64.tar.gz
echo PATH=$PATH:/usr/local/go/bin >> /etc/profile
source /etc/profile

echo "Installing Docker..."
if [ ! -e /usr/lib/apt/methods/https ]; then
	apt-get update
	apt-get install -y apt-transport-https
fi
echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
apt-get update
apt-get install -y lxc-docker

echo "Installing etcd..."
cd /usr/local
wget --quiet https://github.com/coreos/etcd/releases/download/v$ETCD_VERSION/etcd-v$ETCD_VERSION-linux-amd64.tar.gz
tar xzf etcd-v$ETCD_VERSION-linux-amd64.tar.gz
mv etcd-v$ETCD_VERSION-linux-amd64 etcd
chown -R root:root etcd

echo "Installing Kubernetes..."
cd /usr/local
wget --quiet https://github.com/GoogleCloudPlatform/kubernetes/releases/download/v$KUBERNETES_VERSION/kubernetes.tar.gz
tar xzf kubernetes.tar.gz
