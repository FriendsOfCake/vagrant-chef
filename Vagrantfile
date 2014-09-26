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
apt-get install -qq -y --force-yes build-essential unzip libssl-dev libxslt-dev libxml2-dev libreadline-dev zlib1g-dev
apt-get install -qq -y --force-yes binutils-doc gcc autoconf flex bison libtool
apt-get install -qq -y --force-yes ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 libopenssl-ruby1.9.1

SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.forward_agent = true

# Load configuration
  vconfig = {
    "app" => {
      "name" => "app.dev"
    },
    "vm" => {
      "ip_address" => "192.168.13.37"
    }
  }
  vconfig = vconfig.merge(YAML::load_file("vagrant.yml")) if File.exist?("vagrant.yml")

  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.network "private_network", ip: vconfig['vm']['ip_address']
  config.vm.synced_folder ".", "/vagrant"
  config.vm.provision :shell, inline: $script

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.roles_path = "cookbooks/roles"
    chef.json = {"vconfig" => vconfig}
    chef.add_role("vagrant")
  end

  config.vm.provider :vmware_fusion do |v, override|
    override.vm.box = "precise64_vmware_fusion"
    override.vm.box_url = "http://files.vagrantup.com/precise64_vmware_fusion.box"
  end
end
