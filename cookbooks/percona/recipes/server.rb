include_recipe "percona::default"

directory '/var/lib/mysql/binlogs' do
  owner "root"
  group "root"
  mode  0755
  recursive true
  action :create
end

package "percona-server-server-5.5" do
  action :install
end

package "xtrabackup" do
  action :upgrade
end

service "mysql" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

execute 'set-mysql-root' do
  command "mysqladmin -u root password #{node['mysql']['server_root_password']}"
  only_if "/usr/bin/mysql -u root -e 'show databases;'"
end

template "/etc/mysql/my.cnf" do
  source "my.cnf.erb"
  variables :mysql => node['mysql']
end
