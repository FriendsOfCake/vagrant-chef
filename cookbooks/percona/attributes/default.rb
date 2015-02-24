default['mysql']['server_debian_password']  = 'password'
default['mysql']['server_root_password']    = 'password'
default['mysql']['server_repl_password']    = 'password'
default['mysql']['bind_address']            = '0.0.0.0'
default['mysql']['datadir']                 = "/var/lib/mysql"

default['mysql']['key_buffer']              = "1G"
default['mysql']['max_connections']         = "450"
default['mysql']['tmpdir']                  = "/tmp"
default['mysql']['query_cache_limit']       = "20M"
default['mysql']['query_cache_size']        = "512M"
default['mysql']['server_id']               = 1
default['mysql']['innodb_buffer_pool_size'] = "512M"
default['mysql']['innodb_log_buffer_size']  = "8M"
default['mysql']['innodb_log_file_size']    = false

default['mysql']['users']                   = {}

default['mysql']['databases']               = {}

# Unused
default['mysql']['wait_timeout']        = "3600"
default['mysql']['net_read_timeout']    = "30"
default['mysql']['net_write_timeout']   = "30"
default['mysql']['back_log']            = "128"
default['mysql']['table_cache']         = "128"
default['mysql']['max_heap_table_size'] = "32M"
