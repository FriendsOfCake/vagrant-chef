include_recipe "percona::apt_repository"

package "percona-server-common-5.6" do
  action :install
end

package "percona-server-server-5.6" do
  action :install
end

directory '/var/lib/mysql/binlogs' do
  owner "mysql"
  group "mysql"
  mode  0755
  recursive true
  action :create
end

package "xtrabackup" do
  action :upgrade
end

service "mysql" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

server_root_password = node['mysql']['server_root_password']
execute 'set-mysql-root' do
  command <<-EOH
    mysqladmin -u root password #{server_root_password}
    mysql -uroot -p#{server_root_password} -e "SET PASSWORD FOR 'root'@'vagrant'   = PASSWORD('#{server_root_password}')"
    mysql -uroot -p#{server_root_password} -e "SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('#{server_root_password}')"
    mysql -uroot -p#{server_root_password} -e "SET PASSWORD FOR 'root'@'::1'       = PASSWORD('#{server_root_password}')"
    mysql -uroot -p#{server_root_password} -e "CREATE USER 'root'@'%' IDENTIFIED BY '#{server_root_password}'"
    mysql -uroot -p#{server_root_password} -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION"
    mysql -uroot -p#{server_root_password} -e "DELETE FROM mysql.user WHERE user=''"
    mysql -uroot -p#{server_root_password} -e "FLUSH PRIVILEGES;"
  EOH
  only_if "/usr/bin/mysql -u root -e 'show databases;'"
end

template "/etc/mysql/my.cnf" do
  source "my.cnf.erb"
  variables :mysql => node['mysql']
  notifies :restart, 'service[mysql]', :immediately
end

node['mysql']['databases'].each do |database_name, enabled|
  execute "create-mysql-database-#{database_name}" do
    command "mysql -uroot -p#{server_root_password} -e 'CREATE DATABASE #{database_name}' && touch /etc/mysql/database-#{database_name}"
    creates "/etc/mysql/database-#{database_name}"
  end
end

node['mysql']['users'].each do |user, password|
  execute "create-mysql-user-#{user}" do
  command <<-EOH
    mysql -uroot -p#{server_root_password} -e "CREATE USER '#{user}'@'127.0.0.1' IDENTIFIED BY '#{password}'; GRANT ALL PRIVILEGES ON *.* TO '#{user}'@'127.0.0.1' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    mysql -uroot -p#{server_root_password} -e "CREATE USER '#{user}'@'::1'       IDENTIFIED BY '#{password}'; GRANT ALL PRIVILEGES ON *.* TO '#{user}'@'::1'       WITH GRANT OPTION; FLUSH PRIVILEGES;"
    mysql -uroot -p#{server_root_password} -e "CREATE USER '#{user}'@'localhost' IDENTIFIED BY '#{password}'; GRANT ALL PRIVILEGES ON *.* TO '#{user}'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    mysql -uroot -p#{server_root_password} -e "CREATE USER '#{user}'@'vagrant'   IDENTIFIED BY '#{password}'; GRANT ALL PRIVILEGES ON *.* TO '#{user}'@'vagrant'   WITH GRANT OPTION; FLUSH PRIVILEGES;"
    mysql -uroot -p#{server_root_password} -e "CREATE USER '#{user}'@'%'         IDENTIFIED BY '#{password}'; GRANT ALL PRIVILEGES ON *.* TO '#{user}'@'%'         WITH GRANT OPTION; FLUSH PRIVILEGES;"
    touch /etc/mysql/user-#{user}
  EOH
    creates "/etc/mysql/user-#{user}"
  end
end
