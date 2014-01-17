define :opsworks_deploy_dir do

  directory "#{params[:path]}/shared" do
    group params[:group]
    owner params[:user]
    mode 0770
    action :create
    recursive true
  end

  # create shared/ directory structure
  shared_dirs = ['log','config','system','pids','scripts','sockets']
  if params[:shared_dirs]
    shared_dirs << params[:shared_dirs]
  end

  shared_dirs.each do |dir_name|
    directory "#{params[:path]}/shared/#{dir_name}" do
      group params[:group]
      owner params[:user]
      mode 0770
      action :create
      recursive true
    end
  end

end
