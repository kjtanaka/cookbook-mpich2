default['opt-mpich']['version'] = "3.1.3"
default['opt-mpich']['download_url'] = "http://www.mpich.org/static/downloads/#{node['opt-mpich']['version']}/mpich-#{node['opt-mpich']['version']}.tar.gz"
default['opt-mpich']['download_dir'] = "/tmp"
default['opt-mpich']['install_dir'] = "/opt/mpich-#{node['opt-mpich']['version']}"
