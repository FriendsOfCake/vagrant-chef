directory '/vagrant/app' do
  owner "vagrant"
  group "vagrant"
  mode  0755
  recursive true
  action :create
  not_if { ::FileTest.exists?("/vagrant/app/app/webroot/index.php") }
end

directory '/vagrant/app/app' do
  owner "vagrant"
  group "vagrant"
  mode  0755
  recursive true
  action :create
  not_if { ::FileTest.exists?("/vagrant/app/app/webroot/index.php") }
end

directory '/vagrant/app/app/webroot' do
  owner "vagrant"
  group "vagrant"
  mode  0755
  recursive true
  action :create
  not_if { ::FileTest.exists?("/vagrant/app/app/webroot/index.php") }
end


template "/vagrant/app/app/webroot/index.php" do
  source "index.php.erb"
  owner "vagrant"
  group "vagrant"
  mode 0644
  not_if { ::FileTest.exists?("/vagrant/app/app/webroot/index.php") }
end

package "nginx"  do
  action :install
end

service "nginx"  do
  supports :status => true, :restart => true, :reload => true
  action :nothing
end

template "/etc/nginx/common.conf" do
  source "common.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[nginx]"
end

template "/etc/nginx/fastcgi_params" do
  source "fastcgi_params.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[nginx]"
end

template "/etc/nginx/php.conf" do
  source "php.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[nginx]"
end

template "/etc/nginx/cakephp.conf" do
  source "cakephp.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[nginx]"
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[nginx]"
end

template "/etc/nginx/sites-available/default" do
  source "app.dev.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :server_name => node['nginx']['server_name']
  )
  notifies :restart, "service[nginx]"
end
