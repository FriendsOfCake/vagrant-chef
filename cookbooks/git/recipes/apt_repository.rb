apt_repository "git" do
  key "E1DF1F24"
  uri "ppa:git-core/ppa"
  distribution node["lsb"]["codename"]
end
