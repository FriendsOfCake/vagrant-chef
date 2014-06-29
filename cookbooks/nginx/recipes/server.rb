include_recipe "nginx::apt_repository"

package "nginx"  do
  action :install
end

service "nginx"  do
  supports :status => true, :restart => true, :reload => true
  action :nothing
end

directory '/etc/nginx/app' do
  owner "www-data"
  group "www-data"
  mode  0755
  recursive true
  action :create
end

template "/etc/nginx/app/index.html" do
  source "index.html.erb"
  owner "www-data"
  group "www-data"
  mode 0644
end

template "/etc/nginx/fastcgi_params" do
  source "fastcgi_params.erb"
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
