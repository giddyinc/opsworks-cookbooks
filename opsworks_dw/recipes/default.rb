# encoding: UTF-8

directory node[:dw][:path] do
  recursive true
  user node[:dw][:user]
end

include_recipe 'opsworks_dw::fetch_s3_files'

dropwizard 'dw' do
  arguments "server #{node[:dw][:config_local_file]}"
  jar_file node[:dw][:jar_local_file]
  user node[:dw][:user]
  jvm_options node[:dw][:jvm_options]
end

service 'dw' do
  action :nothing
end

