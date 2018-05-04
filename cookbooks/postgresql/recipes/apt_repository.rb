apt_repository "postgresql" do
  key "https://www.postgresql.org/media/keys/ACCC4CF8.asc"
  uri "https://apt.postgresql.org/pub/repos/apt/"
  components ["main", "9.4"]
  distribution "#{node["lsb"]["codename"]}-pgdg"
end
