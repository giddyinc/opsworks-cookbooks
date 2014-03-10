include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  if application != 'dw'
    Chef::Log.debug("Skipping deploy::dw for application #{application} as it is not a dropwizard app")
    next
  end

  include_recipe 'opsworks_dw::fetch_s3_files'

  service 'dw' do
    action :restart
  end

  template "/etc/logrotate.d/opsworks_app_#{application}" do
    backup false
    source "logrotate-dw.erb"
    cookbook 'deploy'
    owner "root"
    group "root"
    mode 0644
    variables( :log_file => "/var/log/dw.log" )
  end

end
