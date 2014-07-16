include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::nodejs for application #{application} as it is not a node.js app")
    next
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
    shared_dirs 'node_modules'
  end

  #deploy[:purge_before_symlink] = %w{log tmp/pids public/system node_modules}
  #deploy[:symlinks] = {"system" => "public/system", "pids" => "tmp/pids", "log" => "log", "node_modules" => "node_modules"}
  opsworks_deploy do
    deploy_data deploy
    app application
  end

  opsworks_nodejs do
    deploy_data deploy
    app application
  end
  
  #do some bower install and grunt release
  # execute "bower install" do
  #   command "#{node[:deploy][application][:deploy_to]}/current/bower install"
  # end
  
  # execute "grunt release" do
  #   command "#{node[:deploy][application][:deploy_to]}/current/grunt release"
  # end
  
  execute "bower install" do
    cwd "#{node[:deploy][application][:deploy_to]}/current"
    user deploy[:user]
    group deploy[:group]
  end
  
  execute "grunt release" do
    cwd "#{node[:deploy][application][:deploy_to]}/current"
    user deploy[:user]
    group deploy[:group]
  end
  

  ruby_block "restart node.js application #{application}" do
    block do
      Chef::Log.info("restart node.js via: #{node[:deploy][application][:nodejs][:restart_command]}")
      Chef::Log.info(`#{node[:deploy][application][:nodejs][:restart_command]}`)
      $? == 0
    end
  end
end
