execute "request php55 key" do
  command "gpg --keyserver keyserver.ubuntu.com --recv-keys E5267A6C"
  not_if "gpg --list-keys E5267A6C"
end

execute "install php55 key" do
  command "gpg -a --export E5267A6C | apt-key add -"
  not_if "apt-key list | grep E5267A6C"
end

template "/etc/apt/sources.list.d/php55.list" do
  source "php55.list.erb"
  notifies :run, "execute[apt-get update]", :immediately
end

[
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
  "php5-memcached",
  "php5-mysql",
  "php-apc",
  "php-pear",
].each do |pkg|
  package pkg do
    action :install
  end
end

service "php5-fpm" do
  action :nothing
end

template "/etc/php5/fpm/pool.d/www.conf.erb" do
  source "www.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "php5-fpm"), :immediately
end
