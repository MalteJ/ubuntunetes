# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.define "kuba" do |kuba|
    kuba.vm.hostname = "kuba"
    kuba.vm.network "private_network", ip: "192.168.42.11"
    kuba.vm.provision "shell" do |s|
      s.inline = "/vagrant/install-kubernetes.sh && PEER_ADDR=$1 ETCD_DISCOVERY=$2 /vagrant/start-etcd.sh"
      s.args = "192.168.42.11 #{ENV['ETCD_DISCOVERY']}"
    end
  end
  config.vm.define "kubb" do |kubb|
    kubb.vm.hostname = "kubb"
    kubb.vm.network "private_network", ip: "192.168.42.12"
    kubb.vm.provision "shell" do |s|
      s.inline = "/vagrant/install-kubernetes.sh && PEER_ADDR=$1 ETCD_DISCOVERY=$2 /vagrant/start-etcd.sh"
      s.args = "192.168.42.12 #{ENV['ETCD_DISCOVERY']}"
    end
  end
  config.vm.define "kubc" do |kubc|
    kubc.vm.hostname = "kubc"
    kubc.vm.network "private_network", ip: "192.168.42.13"
    kubc.vm.provision "shell" do |s|
      s.inline = "/vagrant/install-kubernetes.sh && PEER_ADDR=$1 ETCD_DISCOVERY=$2 /vagrant/start-etcd.sh"
      s.args = "192.168.42.13 #{ENV['ETCD_DISCOVERY']}"
    end
  end
end
