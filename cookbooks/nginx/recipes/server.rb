package "nginx"  do
  action :install
end

service "nginx"  do
  action :nothing
end


[
  'etc/nginx/common.conf',
  'etc/nginx/fastcgi_params',
  'etc/nginx/php.conf',
  'etc/nginx/cakephp.conf',
  'etc/nginx/nginx.conf',
  'etc/nginx/sites-available/default',
  'etc/nginx/sites-available/cakephp.example',
].each do |t|
  template "/#{t}" do
    source "#{t}.erb"
    owner "root"
    group "root"
    mode 0644
    notifies :restart, resources(:service => "nginx"), :immediately
  end
end