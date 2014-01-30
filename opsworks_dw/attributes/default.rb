# encoding: UTF-8

##
# Java
##
default[:java][:install_flavor] = 'oracle'
default[:java][:jdk_version] = '7'
default[:java][:oracle] = { 'accept_oracle_download_terms' => true }

default[:dw][:user] = 'root'
default[:dw][:path] = '/opt/dw'
default[:dw][:s3_bucket] = 'boxed-maven'

# jar
default[:dw][:app_name] = ''
default[:dw][:app_version] = '0.0.1'
default[:dw][:jar_filename] = "#{node[:dw][:app_name]}-#{node[:dw][:app_version]}.jar"
default[:dw][:jar_remote_path] = "/release/com/boxed/#{node[:dw][:app_name]}/#{node[:dw][:app_version]}/#{node[:dw][:jar_filename]}"
default[:dw][:jar_local_file] = "#{node[:dw][:path]}/#{node[:dw][:jar_filename]}"

# config file
default[:dw][:config_filename] = "config.yml"
default[:dw][:config_remote_path] = "/release/com/boxed/#{node[:dw][:app_name]}/#{node[:dw][:app_version]}/config/#{node[:dw][:config_filename]}"
default[:dw][:config_local_file] = "#{node[:dw][:path]}/#{node[:dw][:config_filename]}"

# aws - use custom json
default[:dw][:access_key] = ""
default[:dw][:secret_key] = ""
