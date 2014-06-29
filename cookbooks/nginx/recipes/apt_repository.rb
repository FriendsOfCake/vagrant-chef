execute "request nginx key" do
  command "gpg --keyserver keyserver.ubuntu.com --recv-keys C300EE8C"
  not_if "gpg --list-keys C300EE8C"
end

execute "install nginx key" do
  command "gpg -a --export C300EE8C | apt-key add -"
  not_if "apt-key list | grep C300EE8C"
end

template "/etc/apt/sources.list.d/nginx.list" do
  source "nginx.list.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :run, "execute[apt-get update]", :immediately
end
