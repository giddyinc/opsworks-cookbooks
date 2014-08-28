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
  
  
  #some reason bower install won't work under deploy user
  execute "bower install --allow-root" do
    cwd "#{node[:deploy][application][:deploy_to]}/current"
  end
  
  if "#{node[:nodejs_env]}" == "prod"
    execute "grunt release-prod" do
      cwd "#{node[:deploy][application][:deploy_to]}/current"
      user deploy[:user]
      group deploy[:group]
    end
  else
    execute "grunt release-staging" do
      cwd "#{node[:deploy][application][:deploy_to]}/current"
      user deploy[:user]
      group deploy[:group]
    end
  end

  

  ruby_block "restart node.js application #{application}" do
    block do
      Chef::Log.info("restart node.js via: #{node[:deploy][application][:nodejs][:restart_command]}")
      Chef::Log.info(`#{node[:deploy][application][:nodejs][:restart_command]}`)
      $? == 0
    end
  end
end
