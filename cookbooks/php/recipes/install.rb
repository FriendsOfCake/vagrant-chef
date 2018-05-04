include_recipe "php::apt_repository"

[
  "sqlite",
  "php7.0-cli",
  "php7.0-common",
  "php7.0-curl",
  "php7.0-fpm",
  "php7.0-gd",
  "php-geoip",
  "php7.0-gmp",
  "php-imagick",
  "php7.0-intl",
  "php7.0-json",
  "php7.0-mbstring",
  "php7.0-mcrypt",
  "php-memcache",
  "php-memcached",
  "php7.0-mysql",
  "php7.0-pgsql",
  "php-redis",
  "php7.0-simplexml",
  "php7.0-sqlite",
  "php-xdebug",
  "php7.0-zip",
  "php-apcu",
  "php-pear",
].each do |pkg|
  package pkg do
    action :install
  end
end

service "php7.0-fpm" do
  action :nothing
end

template "/etc/php/7.0/fpm/pool.d/www.conf" do
  source "www.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[php7.0-fpm]", :immediately
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
