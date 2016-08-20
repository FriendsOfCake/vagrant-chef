apt_repository "chris-lea-redis" do
  key "C7917B12"
  uri "ppa:chris-lea/redis-server"
  distribution node["lsb"]["codename"]
end
