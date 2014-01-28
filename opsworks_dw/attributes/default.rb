# encoding: UTF-8

##
# Java
##
default[:java][:install_flavor] = 'oracle'
default[:java][:jdk_version] = '7'
default[:java][:oracle] = { 'accept_oracle_download_terms' => true }

default[:dw][:user] = 'root'
default[:dw][:path] = '/opt/dw'
default[:dw][:jar_file] = "#{node[:dw][:path]}/dw.jar"
default[:dw][:config] = "#{node[:dw][:path]}/config.yml"
