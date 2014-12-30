chef_box_basic
==============

Centos6.5 + new box cookbook - it's not supposed to do everything, just very basic things,
reday for you to move on to more advanced security + role based config using other cookbooks.

These actions will be performed once a day only:
* yum -q -y clean all
* yum -q -y makecache
* yum groupremove -q -y { node['box_basic']['yum_groups_remove'].each ... }
* yum -y update
* pip install --upgrade awscli

These actions occur at every run:
* cookbook_file /etc/ssh/sshd_config
* include_recipe 'yum-epel'
* install packages  { node['box_basic']['install_packages'].each ... }
* include_recipe "shell_preferences" if (node['box_basic']['set_shell_preferences'] == true)
* include_recipe "users::default"
* users_manage group { node['authorization']['groups'].each ... }
* add daily cronjob: "yum -y update" 
* add month cronjob: "reboot" unless node['box_basic']['cron_no_reboot']

"It works for me" - If it doesn't work for you: fork it, change it, test it, submit pull request ;)

  
