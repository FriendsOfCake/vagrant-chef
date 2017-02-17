apt_repository "percona" do
  key "8507EFA5"
  uri "https://repo.percona.com/apt"
  components ["main"]
  distribution node["lsb"]["codename"]
end

apt_preference "percona" do
  glob "*"
  pin "origin repo.percona.com"
  pin_priority "700"
end

apt_preference "ubuntu" do
  glob "*"
  pin "origin archive.ubuntu.com"
  pin_priority "600"
end
