# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

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

SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network "private_network", ip: "192.168.13.37"

  config.ssh.forward_agent = true

  config.vm.provision :shell, inline: $script

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.roles_path = "cookbooks/roles"
    chef.add_role("vagrant")
  end
end
