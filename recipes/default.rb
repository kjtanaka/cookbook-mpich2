#
# Cookbook Name:: opt-mpich2
# Recipe:: default
# Author:: Koji Tanaka (<kj.tanaka@gmail.com>)
#
# Copyright 2014, FutureGrid, Indiana University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

mpich2_download_url = node['opt-mpich2']['download_url']
mpich2_download_dir = node['opt-mpich2']['download_dir']
mpich2_install_dir = node['opt-mpich2']['install_dir']
mpich2_version = node['opt-mpich2']['version']

case node[:platform]
when "redhat", "centos"
  package "gcc-gfortran"
when "ubuntu", "debian"
  include_recipe 'apt'
end

include_recipe 'build-essential'

directory mpich2_download_dir do
  action :create
end

directory mpich2_install_dir do
  recursive true
  action :create
end

remote_file "#{mpich2_download_dir}/mpich-#{mpich2_version}.tar.gz" do
  source mpich2_download_url
  mode 00644
  owner "root"
  group "root"
  not_if { ::File.exists?("#{mpich2_install_dir}/lib") }
end

execute "untar_mpich2_tarball" do
  command "tar zxf mpich-#{mpich2_version}.tar.gz"
  cwd mpich2_download_dir
  only_if { ::File.exists?("#{mpich2_download_dir}/mpich-#{mpich2_version}.tar.gz") }
  creates "#{mpich2_download_dir}/mpich-#{mpich2_version}"
end

script "install_mpich2" do
  interpreter "bash"
	user "root"
  cwd "#{mpich2_download_dir}/mpich-#{mpich2_version}"
  code <<-EOH
  ./configure --prefix=#{mpich2_install_dir} --disable-gl
  make
  make install
  EOH
  only_if { ::File.exists?("#{mpich2_download_dir}/mpich-#{mpich2_version}") }
  creates "#{mpich2_install_dir}/lib"
end
