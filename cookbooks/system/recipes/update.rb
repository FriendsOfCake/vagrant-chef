execute "apt-get update" do
  action :run
  command "apt-get update && touch /var/chef/apt_get_updated"
  creates "/var/chef/apt_get_updated"
end

[
  'apt-transport-https',
  'curl',
  'aptitude',
  'subversion',
  'unzip',
  'vim',
  'postfix',
].each do |pkg|
  package pkg do
    action :install
  end
end
