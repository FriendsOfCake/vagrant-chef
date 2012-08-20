execute "hostname" do
  command "echo %s > /etc/hostname && hostname -F /etc/hostname" % node['box_name']
  not_if { node['box_name'].nil? || "hostname | grep %s" % node['box_name'] }
  action :run
end