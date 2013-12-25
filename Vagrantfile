# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<-SCRIPT
if ! grep -q cd-to-directory "/home/vagrant/.bashrc"; then
  echo "- setting up auto chdir on ssh"
  echo "\n[ -n \\"\\$SSH_CONNECTION\\" ] && cd /vagrant # cd-to-directory" >> "/home/vagrant/.bashrc"
fi
SCRIPT

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Use this IP so that we can share folders
  # You can use this IP to access the instance
  config.vm.network :hostonly, "192.168.13.37"

  config.vm.provision :shell, inline: $script

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.roles_path = "cookbooks/roles"
    chef.add_role("vagrant")
  end
end
