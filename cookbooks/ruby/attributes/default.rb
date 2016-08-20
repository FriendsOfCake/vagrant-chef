if platform_family?("debian")
  default["ruby"]["heroku"]["install_url"] = 'https://toolbelt.heroku.com/install-ubuntu.sh'
else
  default["ruby"]["heroku"]["install_url"] = 'https://toolbelt.heroku.com/install.sh'
end
