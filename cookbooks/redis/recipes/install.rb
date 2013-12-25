execute "request redis key" do
  command "gpg --keyserver keyserver.ubuntu.com --recv-keys C7917B12"
  not_if "gpg --list-keys C7917B12"
end

execute "install redis key" do
  command "gpg -a --export C7917B12 | apt-key add -"
  not_if "apt-key list | grep C7917B12"
end

template "/etc/apt/sources.list.d/chris-lea.list" do
  source "chris-lea.list.erb"
  notifies :run, "execute[apt-get update]", :immediately
end

package "redis-server" do
  action :install
end

service "redis-server" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
