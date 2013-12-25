directory "/var/virtual" do
  owner "www-data"
  group "www-data"
  mode  0755
  recursive true
  action :create
end

directory "/var/www" do
  owner "www-data"
  group "www-data"
  mode  0755
  recursive true
  action :create
end

node['cakephp']['versions'].each do | version, should_install |
  git "/var/virtual/cakephp-#{version}" do
    repository 'git://github.com/cakephp/cakephp.git'
    revision version
    action :checkout
    only_if { should_install }
  end
end
