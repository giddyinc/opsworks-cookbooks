include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  if application != 'dw'
    Chef::Log.debug("Skipping deploy::dw for application #{application} as it is not a dropwizard app")
    next
  end

  include_recipe 'opsworks_dw::fetch_s3_files'

  Chef::Log.debug("Restarting dw service")
  service 'dw' do
    action :restart
  end

end
