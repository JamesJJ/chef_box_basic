#
# Recipe:: yum_group_development_tools
#

_once_only_file = '/tmp/chef_box_basic_yum_group_install_development_tools'

bash "yum install 'Development tools' group" do
  user "root"
  cwd "/"
  umask "033"
  environment "PATH" => "/bin:/usr/bin:/sbin:/usr/sbin"
  creates _once_only_file
  code <<-EOH
    touch '#{_once_only_file}'
    yum groupinstall 'Development tools' > /tmp/#{_once_only_file}_groupinstall
    if [ $? -ne 0 ]
    then
      yum groups mark convert  > /tmp/#{_once_only_file}_groups_mark_convert
      yum groups install 'Development tools' > /tmp/#{_once_only_file}_groups_install
    fi
  EOH
end

