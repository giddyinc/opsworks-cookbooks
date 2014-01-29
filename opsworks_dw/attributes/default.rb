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
default[:dw][:jar_filename] = 'pensieve-collector-0.0.1.jar'
default[:dw][:jar_remote_path] = "/release/com/boxed/pensieve-collector/0.0.1/#{node[:dw][:jar_filename]}"
default[:dw][:jar_local_file] = "#{node[:dw][:path]}/#{node[:dw][:jar_filename]}"

# config file
default[:dw][:config_filename] = "config.yml"
default[:dw][:config_remote_path] = "/release/com/boxed/pensieve-collector/0.0.1/config/#{node[:dw][:config_filename]}"
default[:dw][:config_local_file] = "#{node[:dw][:path]}/#{node[:dw][:config_filename]}"

# aws - use custom json
default[:dw][:access_key] = ""
default[:dw][:secret_key] = ""
