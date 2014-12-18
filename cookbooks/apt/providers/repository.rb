action :add do
  r = execute "request #{new_resource.name} key" do
    command "gpg --keyserver keyserver.ubuntu.com --recv-keys #{new_resource.key}"
    not_if "gpg --list-keys #{new_resource.key}"
  end
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?

  r = execute "install #{new_resource.name} key" do
    command "gpg -a --export #{new_resource.key} | apt-key add -"
    not_if "apt-key list | grep #{new_resource.key}"
  end
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?

  r = template "/etc/apt/sources.list.d/#{new_resource.source}.list" do
    cookbook "apt"
    source "list.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
      :distribution => node['lsb']['codename'],
      :url => new_resource.url
    )
    notifies :run, "execute[apt-get update]", :immediately
  end
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?

  r = execute "apt-get update" do
    action :nothing
    command "apt-get update && touch /var/chef/apt_get_updated"
  end
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end

action :remove do
  r = file "/etc/apt/sources.list.d/#{new_resource.source}.list" do
    action :delete
  end
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end
