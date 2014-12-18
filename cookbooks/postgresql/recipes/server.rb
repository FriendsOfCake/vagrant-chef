package "postgresql" do
  action :install
end

service "postgresql" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

template "#{node['postgresql']['dir']}/postgresql.conf" do
  source "postgresql.conf.erb"
  owner "postgres"
  group "postgres"
  mode 0600
  notifies :restart, 'service[postgresql]', :immediately
end

template "#{node['postgresql']['dir']}/pg_hba.conf" do
  source "pg_hba.conf.erb"
  owner "postgres"
  group "postgres"
  mode 00600
  notifies :restart, 'service[postgresql]', :immediately
  notifies :run, 'execute[add-default-username]', :immediately
end

execute "add-default-username" do
  action :nothing
  user 'postgres'
  command <<-EOH
echo "CREATE USER username WITH ENCRYPTED PASSWORD '#{node['postgresql']['password']['postgres']}' CREATEDB;" | psql
createdb username
  EOH
  creates "/var/chef/postgres_default_username"
end

execute "touch /var/chef/postgres_default_username" do
  action :run
  creates "/var/chef/postgres_default_username"
end

# NOTE: Consider two facts before modifying "assign-postgres-password":
# (1) Passing the "ALTER ROLE ..." through the psql command only works
#     if passwordless authorization was configured for local connections.
#     For example, if pg_hba.conf has a "local all postgres ident" rule.
# (2) It is probably fruitless to optimize this with a not_if to avoid
#     setting the same password. This chef recipe doesn't have access to
#     the plain text password, and testing the encrypted (md5 digest)
#     version is not straight-forward.
execute "assign-postgres-password" do
  action :run
  user 'postgres'
  command <<-EOH
echo "ALTER ROLE postgres ENCRYPTED PASSWORD '#{node['postgresql']['password']['postgres']}';" | psql
  EOH
end
