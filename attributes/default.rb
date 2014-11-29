default['opt-mpich2']['version'] = "3.1.3"
default['opt-mpich2']['download_url'] = "http://www.mpich.org/static/downloads/#{node['opt-mpich2']['version']}/mpich-#{node['opt-mpich2']['version']}.tar.gz"
default['opt-mpich2']['download_dir'] = "/tmp"
default['opt-mpich2']['install_dir'] = "/opt/mpich-#{node['opt-mpich2']['version']}"
