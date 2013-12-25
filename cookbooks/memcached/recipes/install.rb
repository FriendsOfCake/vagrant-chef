package "memcached" do
  action :install
end

package "libmemcache-dev" do
  action :install
end

service "memcached" do
  action :nothing
  supports :status => true, :restart => true, :reload => true
end

template '/etc/memcached.conf' do
  source 'memcached.conf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  variables(
    :listen          => node['memcached']['listen'],
    :user            => node['memcached']['user'],
    :port            => node['memcached']['port'],
    :udp_port        => node['memcached']['udp_port'],
    :maxconn         => node['memcached']['maxconn'],
    :memory          => node['memcached']['memory'],
    :max_object_size => node['memcached']['max_object_size']
  )
  notifies :restart, 'service[memcached]'
end