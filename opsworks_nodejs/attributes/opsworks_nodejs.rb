include_attribute 'deploy'

default[:boxed][:assets_url] = 'https://s3.amazonaws.com/boxed-packages'

default[:opsworks_nodejs][:version] = '0.10.5'
default[:opsworks_nodejs][:pkgrelease] = '1'

arch = RUBY_PLATFORM.match(/64/) ? 'amd64' : 'i386'
default[:opsworks_nodejs][:deb] = "nodejs-#{node[:opsworks_nodejs][:version]}-#{node[:opsworks_nodejs][:pkgrelease]}_#{arch}.deb"
default[:opsworks_nodejs][:deb_url] = "#{node[:boxed][:assets_url]}/packages/#{node[:platform]}/#{node[:platform_version]}/#{node[:opsworks_nodejs][:deb]}"

rhel_arch = RUBY_PLATFORM.match(/64/) ? 'x86_64' : 'i686'
default[:opsworks_nodejs][:rpm] = "nodejs-#{node[:opsworks_nodejs][:version]}-#{node[:opsworks_nodejs][:pkgrelease]}.#{rhel_arch}.rpm"
default[:opsworks_nodejs][:rpm_url] = "#{node[:boxed][:assets_url]}/packages/#{node[:platform]}/#{node[:platform_version]}/#{node[:opsworks_nodejs][:rpm]}"
