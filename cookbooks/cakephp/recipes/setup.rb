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

git '/var/virtual/cakephp-1.3' do
  repository 'git://github.com/cakephp/cakephp.git'
  revision '1.3'
  action :checkout
end

git '/var/virtual/cakephp-2.0' do
  repository 'git://github.com/cakephp/cakephp.git'
  revision '2.3'
  action :checkout
end