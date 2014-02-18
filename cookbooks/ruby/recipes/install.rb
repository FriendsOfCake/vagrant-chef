["ruby1.9.1-full", "build-essential", "wget", "ssl-cert", "curl"].each do |pkg|
  package pkg do
    action :install
  end
end

execute "gem-update" do
  action :run
  command "gem update --system && touch /var/cache/.gem-updated"
  environment({
    "REALLY_GEM_UPDATE_SYSTEM" => "yes"
  })
  not_if { ::FileTest.exists?("/var/cache/.gem-updated") }
end

["heroku", "hub", "travis", "travis-lint"].each do |g|
  execute "gem-install-#{g}" do
    command "gem install #{g}"
    not_if "gem list | grep #{g}"
  end
end
