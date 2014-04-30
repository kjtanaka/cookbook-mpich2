#
# Cookbook Name:: mpich2
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

mpich2_download_url = node['mpich2']['download_url']
mpich2_source_dir = node['mpich2']['source_dir']
mpich2_install_dir = node['mpich2']['install_dir']
mpich2_version = node['mpich2']['version']

case node[:platform]
when "redhat", "centos"
  packages = %w[autoconf
                automake
                binutils
                bison
                flex
                gcc
                gcc-c++
                gdb
                gettext
                libtool
                make
                pkgconfig
                redhat-rpm-config
                rpm-build
                strace
                automake14
                automake15
                automake16
                automake17
                byacc
                cscope
                ctags
                cvs
                dev86
                diffstat
                dogtail
                doxygen
                elfutils
                gcc-gfortran
                indent
                ltrace
                oprofile
                patchutils
                pstack
                python-ldap
                rcs
                splint
                subversion
                swig
                systemtap
                texinfo
                valgrind
                compat-gcc-34-g77]
when "ubuntu", "debian"
  packages = %w[build-essential]
end

packages.each do |pkg|
  package pkg do
    action :install
  end
end

directory mpich2_source_dir do
  action :create
end

remote_file "#{mpich2_source_dir}/mpich-#{mpich2_version}.tar.gz" do
  source mpich2_download_url
  mode 00644
  owner "root"
  group "root"
  action :create_if_missing
end

execute "untar_mpich2_tarball" do
  command "tar zxvf mpich-#{mpich2_version}.tar.gz"
  cwd mpich2_source_dir
  creates "#{mpich2_source_dir}/mpich-#{mpich2_version}"
end

script "install_mpich2" do
  interpreter "bash"
	user "root"
  cwd "#{mpich2_source_dir}/mpich-#{mpich2_version}"
  code <<-EOH
  ./configure --prefix=#{mpich2_install_dir}/mpich-#{mpich2_version} --disable-gl
	sleep 3
  make
	sleep 3
  make install
  EOH
  creates "#{mpich2_install_dir}/mpich-#{mpich2_version}"
end
