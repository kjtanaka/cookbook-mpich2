mpich2_install_dir = node['mpich2']['install_dir']
mpich2_version = node['mpich2']['version']
mpich2_modulefile_dir = node['mpich2']['modulefile_dir']

directory mpich2_modulefile_dir do
  owner "root"
  group "root"
  mode 00755
	action :create
	recursive true
end

template "#{mpich2_modulefile_dir}/#{mpich2_version}" do
  source "modulefile.erb"
  owner "root"
  group "root"
  mode 00644
	action :create
end
