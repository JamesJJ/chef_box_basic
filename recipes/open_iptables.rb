#
# Recipe:: open_iptables
#

_iptables_file = '/etc/sysconfig/iptables'

template _iptables_file do
  cookbook node['box_basic']['iptables_template_cookbook']
  source "box_basic_iptables.erb"
  owner 'root'
  group 'root'
  mode '0600'
  notifies :restart, "service[iptables]", :immediately
  only_if do File.exists?(_iptables_file) end
end

service "iptables" do
  supports [ :restart ]
  action :nothing
end

