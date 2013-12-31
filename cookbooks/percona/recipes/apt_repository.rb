execute "request percona key" do
  command "gpg --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A"
  not_if "gpg --list-keys CD2EFD2A"
end

execute "install percona key" do
  command "gpg -a --export CD2EFD2A | apt-key add -"
  not_if "apt-key list | grep CD2EFD2A"
end

template "/etc/apt/sources.list.d/percona.list" do
  source "percona.list.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :run, "execute[apt-get update]"
end

apt_preference "percona" do
  glob "*"
  pin "origin repo.percona.com"
  pin_priority "700"
end

apt_preference "ubuntu" do
  glob "*"
  pin "origin archive.ubuntu.com"
  pin_priority "600"
end
