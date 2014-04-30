#
# Cookbook Name:: mpich2
# Recipe:: modulefile
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
  variables(
    :mpich2_install_dir => mpich2_install_dir
  )
end

template "#{mpich2_modulefile_dir}/.version" do
  source "dot.version.erb"
  owner "root"
  group "root"
  mode 00644
  action :create
  variables(
    :mpich2_version => mpich2_version
  )
end
