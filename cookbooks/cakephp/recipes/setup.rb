directory "/var/virtual" do
  owner "www-data"
  group "www-data"
  mode  0755
  recursive true
  action :create
end

directory "/var/log/app" do
  owner "vagrant"
  group "www-data"
  mode  0755
  recursive true
  action :create
end

directory "/etc/service-envs/" do
  owner "vagrant"
  group "www-data"
  mode  0755
  recursive true
  action :create
end

node['cakephp']['versions'].each do | version, should_install |
  git "/var/virtual/cakephp-#{version}" do
    repository 'git://github.com/cakephp/cakephp.git'
    revision version
    action :checkout
    only_if { should_install }
  end
end

template "/etc/service-envs/app.env" do
  source "env.erb"
  owner "vagrant"
  group "www-data"
  mode 0644
end
