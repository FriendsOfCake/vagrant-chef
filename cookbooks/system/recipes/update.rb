execute "trigger apt-get update" do
  command "true"
  creates "/var/chef/apt_get_updated"
  notifies :run, "execute[apt-get update]", :immediately
end

execute "apt-get update" do
  action :nothing
  command "apt-get update && touch /var/chef/apt_get_updated"
end

[
  'curl',
  'aptitude',
  'subversion',
  'vim',
].each do |pkg|
  package pkg do
    action :install
  end
end
