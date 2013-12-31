include_recipe "redis::apt_repository"
include_recipe "percona::apt_repository"
include_recipe "php::apt_repository"

execute "trigger apt-get update" do
  command "true"
  creates "/var/chef/apt_get_updated"
  notifies :run, "execute[apt-get update]", :immediately
end

execute "apt-get update" do
  action :nothing
  command "apt-get update && touch /var/chef/apt_get_updated"
end

package "curl" do
	action :install
end

package "aptitude" do
	action :install
end

package "git-core" do
	action :install
end

package "subversion" do
	action :install
end
