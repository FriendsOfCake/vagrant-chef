execute "request percona key" do
  command "gpg --keyserver subkeys.pgp.net --recv-keys 1C4CBDCDCD2EFD2A"
  not_if "gpg --list-keys CD2EFD2A"
end

execute "install percona key" do
  command "gpg -a --export CD2EFD2A | apt-key add -"
  not_if "apt-key list | grep CD2EFD2A"
end

template "/etc/apt/sources.list.d/percona.list" do
  source "etc/apt/sources.list.d/percona.list.erb"
end

execute "update apt" do
  command "apt-get update"
  subscribes :run, resources(:template => "/etc/apt/sources.list.d/percona.list"), :immediately
  action :nothing
end
