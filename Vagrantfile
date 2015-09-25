# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

$script = <<-SCRIPT
if ! grep -q cd-to-directory "/home/vagrant/.bashrc"; then
  echo "- setting up auto chdir on ssh"
  echo "\n[ -n \\"\\$SSH_CONNECTION\\" ] && cd /vagrant # cd-to-directory" >> "/home/vagrant/.bashrc"
fi

cat > /home/vagrant/.ssh/config <<'EOF'
Host *
  CheckHostIP yes
  ControlMaster auto
  ControlPath ~/.ssh/master-%r@%h:%p
  SendEnv LANG LC_*
  HashKnownHosts yes
  GSSAPIAuthentication no
  GSSAPIDelegateCredentials no
  RSAAuthentication yes
  PasswordAuthentication yes
  StrictHostKeyChecking no
EOF

cat > /root/.gemrc << 'EOF'
gem: --no-ri --no-rdoc
EOF

echo "- updating deb repository"
apt-get update > /dev/null

echo "- installing build requirements"
export DEBIAN_FRONTEND=noninteractive
apt-get install -qq -y --force-yes build-essential unzip libssl-dev libxslt-dev libxml2-dev libreadline-dev zlib1g-dev > /dev/null
apt-get install -qq -y --force-yes binutils-doc gcc autoconf flex bison libtool > /dev/null

if [ ! -f /etc/apt/sources.list.d/brightbox-ruby-ng-trusty.list ]; then
  echo "- installing latest ruby version"
  apt-get install -qq -y --force-yes software-properties-common python-software-properties > /dev/null
  add-apt-repository --yes ppa:brightbox/ruby-ng >> /dev/null 2>&1
  apt-get update > /dev/null
  apt-get install -qq -y --force-yes ruby2.1 ruby2.1-dev > /dev/null
fi

command -v foo >/dev/null 2>&1 || {
  echo "- installing chef"
  gem install chef --quiet --version 12.0.3 > /dev/null
}
SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.forward_agent = true

  config.vm.box = "bento/ubuntu-14.04"
  config.vm.network "private_network", ip: "192.168.13.37"
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider "virtualbox" do |v, override|
    v.customize ["modifyvm", :id, "--rtcuseutc", "on"]
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "90"]
    v.customize ["modifyvm", :id, "--memory", "1024"]
    v.customize ["modifyvm", :id, "--cpus", "1"]
  end

  config.vm.provider :vmware_fusion do |v, override|
    v.vmx["memsize"] = "1024"
    v.vmx["numvcpus"] = "1"
  end

  config.vm.provider :parallels do |v, override|
    v.memory = 1024
    v.cpus = 1
  end

  config.vm.provision :shell, inline: $script

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.roles_path = "cookbooks/roles"
    chef.add_role("vagrant")
  end

  config.vm.provision :shell, inline: "/usr/local/bin/composer self-update"
end
