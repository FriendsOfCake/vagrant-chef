execute "update apt" do
  command "apt-get update"
end

package "curl" do
	action :install
end

package "aptitude" do
	action :install
end

execute "update apt" do
  command "apt-get upgrade -y"
end

package "git-core" do
	action :install
end

package "subversion" do
	action :install
end
