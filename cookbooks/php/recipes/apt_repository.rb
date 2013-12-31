execute "request php55 key" do
  command "gpg --keyserver keyserver.ubuntu.com --recv-keys E5267A6C"
  not_if "gpg --list-keys E5267A6C"
end

execute "install php55 key" do
  command "gpg -a --export E5267A6C | apt-key add -"
  not_if "apt-key list | grep E5267A6C"
end

template "/etc/apt/sources.list.d/php55.list" do
  source "php55.list.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :run, "execute[apt-get update]"
end
