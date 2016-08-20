apt_repository "nginx" do
  key "C300EE8C"
  uri "ppa:nginx/stable"
  distribution node["lsb"]["codename"]
end
