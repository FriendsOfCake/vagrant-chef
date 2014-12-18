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

if platform_family?("debian")
  execute "command -v heroku || wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh"
else
  execute "command -v heroku || wget -qO- https://toolbelt.heroku.com/install.sh | sh"
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
  "travis-lint"
].each do |g|
  gem_package g do
    gem_binary("/usr/bin/gem")
    options "--no-ri --no-rdoc --verbose"
    action :upgrade
  end
end
