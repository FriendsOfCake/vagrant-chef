apt_repository "percona" do
  source "percona"
  key "CD2EFD2A"
  url "http://repo.percona.com/apt"
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
