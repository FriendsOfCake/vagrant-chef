[
  "sqlite",
  "php5-sqlite",
  "php5-fpm",
  "php5-cli",
  "php5-common",
  "php5-curl",
  "php5-gd",
  "php5-geoip",
  "php5-gmp",
  "php5-imagick",
  "php5-intl",
  "php5-json",
  "php5-mcrypt",
  "php5-memcache",
  "php5-memcached",
  "php5-redis",
  "php5-mysql",
  "php5-pgsql",
  "php5-xdebug",
  "php-apc",
  "php-pear",
].each do |pkg|
  package pkg do
    action :install
  end
end

link "/etc/php5/cli/conf.d/mcrypt.ini" do
  to "/etc/php5/mods-available/mcrypt.ini"
end

link "/etc/php5/fpm/conf.d/mcrypt.ini" do
  to "/etc/php5/mods-available/mcrypt.ini"
end

service "php5-fpm" do
  action :nothing
end

template "/etc/php5/fpm/pool.d/www.conf" do
  source "www.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[php5-fpm]", :immediately
end

remote_file node['php']['composer']['bin'] do
  source node['php']['composer']['url']
  mode "0755"
  action :create
  not_if { ::File.exists?(node['php']['composer']['bin']) }
end

remote_file node['php']['phpunit']['bin'] do
  source node['php']['phpunit']['url']
  mode "0755"
  action :create
  not_if { ::File.exists?(node['php']['phpunit']['bin']) }
end
