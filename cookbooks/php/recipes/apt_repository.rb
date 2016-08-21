apt_repository "php" do
  key "E5267A6C"
  uri "ppa:ondrej/php"
  distribution node["lsb"]["codename"]
end
