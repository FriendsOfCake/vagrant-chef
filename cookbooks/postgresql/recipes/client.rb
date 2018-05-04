include_recipe "postgresql::apt_repository"

package "postgresql-client-9.4" do
  action :install
end
