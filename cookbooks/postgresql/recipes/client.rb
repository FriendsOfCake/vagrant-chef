include_recipe "postgresql::apt_repository"

package "postgresql-client-9.6" do
  action :install
end
