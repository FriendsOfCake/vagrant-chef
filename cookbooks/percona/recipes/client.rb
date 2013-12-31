include_recipe "percona::apt_repository"

package "percona-server-common-5.5" do
  action :install
end

package "percona-server-client-5.5" do
  action :install
end
