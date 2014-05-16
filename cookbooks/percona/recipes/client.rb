include_recipe "percona::apt_repository"

package "percona-server-common-5.6" do
  action :install
end

package "percona-server-client-5.6" do
  action :install
end
