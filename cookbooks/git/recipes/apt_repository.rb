execute "request git key" do
  command "gpg --keyserver keyserver.ubuntu.com --recv-keys E1DF1F24"
  not_if "gpg --list-keys E1DF1F24"
end

execute "install git key" do
  command "gpg -a --export E1DF1F24 | apt-key add -"
  not_if "apt-key list | grep E1DF1F24"
end

template "/etc/apt/sources.list.d/git.list" do
  source "git.list.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :run, "execute[apt-get update]", :immediately
end
