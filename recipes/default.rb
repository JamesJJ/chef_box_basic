#
# Recipe:: default
#
require 'date'

execute "yum-clean-all" do
  command "yum -q -y clean all"
  environment "PATH" => "/bin:/usr/bin:/usr/sbin:/sbin"
  action :nothing
end

execute "yum-makecache" do
  command "yum -q -y makecache"
  environment "PATH" => "/bin:/usr/bin:/usr/sbin:/sbin"
  action :nothing
end

node['box_basic']['yum_groups_remove'].each do |_grp|
  execute "remove-unwanted-os-package-group (#{_grp})" do
    command "yum groupremove -q -y \"#{_grp}\""
    environment "PATH" => "/bin:/usr/bin:/usr/sbin:/sbin"
    action :nothing
  end
end

execute "yum-update" do
  command "yum -y update"
  environment "PATH" => "/bin:/usr/bin:/usr/sbin:/sbin"
  action :nothing
end

file "/tmp/chef_basic_box_lastrun" do
  owner 'root'
  group 'root'
  mode '0600'
  content Date.today().to_s
  notifies :run, "execute[yum-clean-all]", :immediately
  notifies :run, "execute[yum-makecache]", :immediately
  node['box_basic']['yum_groups_remove'].each do |_grp|
    notifies :run, "execute[remove-unwanted-os-package-group (#{_grp})]", :immediately
  end
  notifies :run, "execute[yum-update]", :immediately
end

cookbook_file "sshd_config" do
  path "/etc/ssh/sshd_config"
  group "root"
  user "root"
  mode 0644
end

include_recipe 'yum-epel'

node['box_basic']['install_packages'].each do |_pkg|
  package _pkg do
    action :install
  end
end

execute "install AWS CLI" do
  command "pip install --upgrade awscli"
  environment "PATH" => "/bin:/usr/bin:/usr/sbin:/sbin"
end

include_recipe "users::default"
# install users by groups
node['authorization']['groups'].each { |group,gid|
  users_manage group do
    action [ :remove, :create ]
    group_id gid unless gid.nil?
  end
}

cron "yum-update" do
  minute "30"
  hour "06"
  command "yum -q check-update || yum -y update"
  path "/bin:/usr/bin:/usr/sbin:/sbin"
end unless node['box_basic']['cron_no_yum']

cron "reboot" do
  minute "30"
  hour "8"
  day "2"
  command "reboot"
  path "/bin:/usr/bin:/usr/sbin:/sbin"
end unless node['box_basic']['cron_no_reboot']

