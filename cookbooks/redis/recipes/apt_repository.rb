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
  owner "root"
  group "root"
  mode 0644
  notifies :run, "execute[apt-get update]"
end
