# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # do not deploy a gui, use `vagrant ssh` instead
  # config.vm.boot_mode = :gui

  # Use this IP so that we can share folders
  # You can use this IP to access the instance
  config.vm.network :hostonly, "192.168.13.37"

  # dont share folders
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # dont bridge the vm
  # config.vm.network :bridged

  # dont forward ports
  # config.vm.forward_port 80, 8080

  # Provision the instance using chef since we're awesome
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.roles_path = "cookbooks/roles"
    chef.add_role("vagrant")
    # chef.log_level = :info
  end
end
