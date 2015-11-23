
Chef::Log.debug("Fetching file from s3: #{node[:dw][:jar_remote_path]}")
s3_file "#{node[:dw][:jar_local_file]}" do
  remote_path "#{node[:dw][:jar_remote_path]}"
  bucket "#{node[:dw][:s3_bucket]}"
  aws_access_key_id "#{node[:dw][:access_key]}"
  aws_secret_access_key "#{node[:dw][:secret_key]}"
  owner "#{node[:dw][:user]}"
  mode "0644"
  action :create
end

Chef::Log.debug("Fetching file from s3: #{node[:dw][:config_remote_path]}")
s3_file "#{node[:dw][:config_local_file]}" do
  remote_path "#{node[:dw][:config_remote_path]}"
  bucket "#{node[:dw][:s3_bucket]}"
  aws_access_key_id "#{node[:dw][:access_key]}"
  aws_secret_access_key "#{node[:dw][:secret_key]}"
  owner "#{node[:dw][:user]}"
  mode "0644"
  action :create
end

if ( not node[:dw][:more_remote_file].nil? and not node[:dw][:more_local_file].nil? )  
  Chef::Log.debug("Fetching more file from s3: #{node[:dw][:more_remote_file]}")
  s3_file "#{node[:dw][:more_local_file]}" do
    remote_path "#{node[:dw][:more_remote_file]}"
    bucket "#{node[:dw][:s3_bucket]}"
    aws_access_key_id "#{node[:dw][:access_key]}"
    aws_secret_access_key "#{node[:dw][:secret_key]}"
    owner "#{node[:dw][:user]}"
    mode "0644"
    action :create
  end
end
