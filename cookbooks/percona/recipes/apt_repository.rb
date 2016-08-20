apt_repository "percona" do
  key "CD2EFD2A"
  uri "http://repo.percona.com/apt"
  components ["main"]
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
