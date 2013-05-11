case node[:platform]
when 'debian', 'ubuntu'
  execute "Install node.js #{node[:opsworks_nodejs][:version]}" do
    command "apt-get update"
    command "apt-get install python-software-properties python g++ make"
    command "add-apt-repository ppa:chris-lea/node.js"
    command "apt-get update"
    command "apt-get install nodejs"

    cwd "/tmp"
    command "dpkg -i /tmp/#{node[:opsworks_nodejs][:deb]}"

    not_if do
      ::File.exists?("/usr/local/bin/node")
    end
  end

when 'centos','redhat','fedora','amazon'
  remote_file "/tmp/#{node[:opsworks_nodejs][:rpm]}" do
    source node[:opsworks_nodejs][:rpm_url]
    action :create_if_missing
    not_if do
      ::File.exists?("/usr/local/bin/node") &&
      system("/usr/local/bin/node -v | grep -q '#{node[:opsworks_nodejs][:version]}'")
    end
  end

  rpm_package 'nodejs' do
    source "/tmp/#{node[:opsworks_nodejs][:rpm]}"
    only_if do
     ::File.exists?("/tmp/#{node[:opsworks_nodejs][:rpm]}")
    end
  end
end
