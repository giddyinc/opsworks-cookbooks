include_recipe 'deploy'
include_recipe 'java'
include_recipe 'magic_shell'

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::nodejs for application #{application} as it is not a node.js app")
    next
  end

  magic_shell_environment 'AWS_ACCESS_KEY_ID' do
    value node[:aws_access_key_id]
  end

  magic_shell_environment 'AWS_SECRET_ACCESS_KEY' do
    value node[:aws_secret_access_key]
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

  ruby_block "restart node.js application #{application}" do
    block do
      Chef::Log.info("restart node.js via: #{node[:deploy][application][:nodejs][:restart_command]}")
      Chef::Log.info(`#{node[:deploy][application][:nodejs][:restart_command]}`)
      $? == 0
    end
  end
end
