line = "[ -n \"$SSH_CONNECTION\" ] && cd \/vagrant # cd-to-directory"
file = Chef::Util::FileEdit.new("/home/vagrant/.bashrc")
file.insert_line_if_no_match(/#{line}/, line)
file.write_file

cookbook_file "/home/vagrant/.ssh/config" do
  source 'ssh.config'
  owner 'vagrant'
  group 'vagrant'
  mode '0600'
end

cookbook_file "/root/.gemrc" do
  source 'gemrc'
  owner 'root'
  group 'root'
  mode '0644'
end
