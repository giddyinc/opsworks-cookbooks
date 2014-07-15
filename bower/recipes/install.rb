node[:deploy].each do |app_name, deploy|
  Chef::Log.debug("Installing bower dependencies #{app_name}")

  script "install_bower" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    npm install -g bower
    EOH
  end

  execute "bower install" do
    cwd "#{deploy[:deploy_to]}/current/"
    user "deploy"
    environment ({'HOME' => '/home/deploy'})
  end
end