include_recipe "redis::apt_repository"

package "redis-server" do
  action :install
end

service "redis-server" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
