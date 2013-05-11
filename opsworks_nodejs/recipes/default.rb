case node[:platform]
when 'debian', 'ubuntu'
  execute "Install node.js #{node[:opsworks_nodejs][:version]}" do
    command "apt-get update; apt-get -y install python-software-properties python g++ make; add-apt-repository -y ppa:chris-lea/node.js; apt-get update; apt-get -y install nodejs"

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
