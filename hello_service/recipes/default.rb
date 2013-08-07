#
# Cookbook Name:: hello_service
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nodejs::install_from_binary"

package "git-core"

git node.hello_service.root_path do
  repository node.hello_service.repo_url
end

service "hello_service" do
  provider Chef::Provider::Service::Upstart
  #restart_command "stop hello_service && start hello_service"
end

template "/etc/init/hello_service.conf" do
  source "hello_service.init.conf.erb"
  owner "root"
  group "root"
  mode "0655"
  notifies :restart, resources(:service => "hello_service")
end

