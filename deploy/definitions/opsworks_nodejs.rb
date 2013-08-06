define :opsworks_nodejs do
  deploy = params[:deploy_data]
  application = params[:app]

  service 'monit' do
    action :nothing
  end

  node[:dependencies][:npms].each do |npm, version|
    execute "/usr/local/bin/npm install #{npm}" do
      cwd "#{deploy[:deploy_to]}/current"
    end
  end

  template "#{deploy[:deploy_to]}/shared/config/opsworks.js" do
    cookbook 'opsworks_nodejs'
    source 'opsworks.js.erb'
    mode '0660'
    owner deploy[:user]
    group deploy[:group]
    variables(:database => deploy[:database], :memcached => deploy[:memcached], :layers => node[:opsworks][:layers])
  end

  nodejs_env = ""
  unless node[:nodejs_env].nil?
    nodejs_env = "NODE_ENV=#{node[:nodejs_env]}"
  end

  app_main = "server.js"
  unless node[:app_main].nil?
    app_main = "#{node[:app_main]}"
  end

  template "#{node[:monit][:conf_dir]}/node_web_app-#{application}.monitrc" do
    source 'node_web_app.monitrc.erb'
    cookbook 'opsworks_nodejs'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      :deploy => deploy,
      :application_name => application,
      :monitored_script => "#{deploy[:deploy_to]}/current/#{app_main}",
      :nodejs_env => nodejs_env
    )
    notifies :restart, resources(:service => 'monit'), :immediately
  end
end
