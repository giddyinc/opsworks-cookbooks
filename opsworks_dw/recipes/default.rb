# encoding: UTF-8

directory node[:dw][:path] do
  recursive true
  user node[:dw][:user]
end

cookbook_file 'dw.jar' do
  path node[:dw][:jar_file]
end

dropwizard 'dw' do
  arguments "server #{node[:dw][:config]}"
  jar_file node[:dw][:jar_file]
  user node[:dw][:user]
end

service 'dw' do
  action :nothing
end

#template node[:dw][:config] do
#  source 'dw-config.yml.erb'
#  mode 0644
#  owner node[:dw][:user]
#  variables(node: node)
#
#  subscribes :create, 'dropwizard[dw]', :delayed
#  notifies :restart, 'service[dw]'
#end

