include_recipe "git::apt_repository"

package 'git' do
  action :upgrade
end
