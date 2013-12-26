::Chef::Node.send(:include, Opscode::OpenSSL::Password)

default['mysql']['server_debian_password']  = secure_password
default['mysql']['server_root_password']    = secure_password
default['mysql']['server_repl_password']    = secure_password
default['mysql']['bind_address']            = ipaddress
default['mysql']['datadir']                 = "/var/lib/mysql"

if attribute?(:ec2)
  default['mysql']['ec2_path']    = "/mnt/mysql"
  default['mysql']['ebs_vol_dev'] = "/dev/sdi"
  default['mysql']['ebs_vol_size'] = 50
end

default['mysql']['key_buffer_size']         = "1G"
default['mysql']['max_connections']         = "450"
default['mysql']['tmpdir']                  = "/mnt/mysqltmp"
default['mysql']['query_cache_limit']       = "20M"
default['mysql']['query_cache_size']        = "512M"
default['mysql']['server_id']               = 10
default['mysql']['innodb_buffer_pool_size'] = "512M"
default['mysql']['innodb_log_buffer_size']  = "8M"
default['mysql']['innodb_log_file_size']    = "256M"

# Unused
default['mysql']['wait_timeout']        = "3600"
default['mysql']['net_read_timeout']    = "30"
default['mysql']['net_write_timeout']   = "30"
default['mysql']['back_log']            = "128"
default['mysql']['table_cache']         = "128"
default['mysql']['max_heap_table_size'] = "32M"
