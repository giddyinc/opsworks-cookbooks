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

  bower_json_dir = "#{node[:deploy][application][:deploy_to]}/current"
  unless node[:bower_json_subdir].nil?
      bower_json_dir = "#{bower_json_dir}/#{node[:bower_json_subdir]}"
  end

  execute "bower install --allow-root" do
    cwd "#{bower_json_dir}"
    only_if do
      File.exists?("#{bower_json_dir}/bower.json")
    end
  end

  gruntfile_dir = "#{node[:deploy][application][:deploy_to]}/current"
  unless node[:gruntfile_subdir].nil?
    gruntfile_dir = "#{gruntfile_dir}/#{node[:gruntfile_subdir]}"
  end
  
  execute "grunt release" do
    cwd "#{gruntfile_dir}"
    user deploy[:user]
    group deploy[:group]
    only_if do
      File.exists?("#{gruntfile_dir}/Gruntfile.js")
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
