include_recipe "ruby::apt_repository"

["ruby2.3", "ruby2.3-dev"].each do |pkg|
  package pkg do
    action :install
  end
end

["wget", "ssl-cert", "curl"].each do |pkg|
  package pkg do
    action :install
  end
end

execute "update rubygems" do
  action :run
  command "gem update --system && touch /var/chef/gems_updated"
  creates "/var/chef/gems_updated"
  environment({
    "REALLY_GEM_UPDATE_SYSTEM" => "yes"
  })
end

remote_file '/var/chef/heroku-install.sh' do
  source node['ruby']['heroku']['install_url']
end

execute "install heroku" do
  action :run
  command "sh /var/chef/heroku-install.sh && touch /var/chef/heroku_installed"
  creates "/var/chef/heroku_installed"
end

# TODO: Fix travis
[
  "hub",
  "ffi",
  "pusher-client",
  "pry",
  "launchy",
  "highline",
  "faraday",
  "faraday_middleware",
  "backports",
  "addressable",
  "gh",
  "travis",
].each do |g|
  gem_package g do
    gem_binary("/usr/bin/gem")
    options "--no-document --verbose"
    action :upgrade
  end
end
