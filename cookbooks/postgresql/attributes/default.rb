default['postgresql']['version'] = 9.1
default['postgresql']['password']['postgres'] = 'password'

default['postgresql']['config']['data_directory'] = "/var/lib/postgresql/#{node['postgresql']['version']}/main"
default['postgresql']['config']['hba_file'] = "/etc/postgresql/#{node['postgresql']['version']}/main/pg_hba.conf"
default['postgresql']['config']['ident_file'] = "/etc/postgresql/#{node['postgresql']['version']}/main/pg_ident.conf"
default['postgresql']['config']['external_pid_file'] = "/var/run/postgresql/#{node['postgresql']['version']}-main.pid"
default['postgresql']['config']['listen_addresses'] = 'localhost'
default['postgresql']['config']['port'] = 5432
default['postgresql']['config']['max_connections'] = 100
default['postgresql']['config']['unix_socket_directory'] = '/var/run/postgresql' if node['postgresql']['version'].to_f < 9.3
default['postgresql']['config']['unix_socket_directories'] = '/var/run/postgresql' if node['postgresql']['version'].to_f >= 9.3
default['postgresql']['config']['shared_buffers'] = '24MB'
default['postgresql']['config']['max_fsm_pages'] = 153600 if node['postgresql']['version'].to_f < 8.4
default['postgresql']['config']['log_line_prefix'] = '%t '
default['postgresql']['config']['datestyle'] = 'iso, mdy'
default['postgresql']['config']['default_text_search_config'] = 'pg_catalog.english'
default['postgresql']['config']['ssl'] = true

default['postgresql']['pg_hba'] = [
  {:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'ident'},
  {:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'ident'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'}
]