include_recipe "percona::default"

package "percona-server-client-5.5" do
  action :install
end
