#
# Cookbook Name:: redis
# Recipe:: source
#
# Author:: Gerhard Lazu (<gerhard.lazu@papercavalier.com>)
#
# Copyright 2010, Paper Cavalier, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential", "mysql-dev"

unless File.exists?(node[:sphinx][:dir] + '/bin/searchd')
  # ensuring we have this directory
  directory "/opt/src"

  remote_file "/opt/src/sphinx-#{node[:sphinx][:version]}.tar.gz" do
    source node[:sphinx][:source]
    checksum node[:sphinx][:checksum]
    action :create_if_missing
  end

  bash "Compiling and installing Sphinx #{node[:sphinx][:version]} from source" do
    cwd "/opt/src"
    code <<-EOH
      tar zxf sphinx-#{node[:sphinx][:version]}.tar.gz
      cd sphinx-#{node[:sphinx][:version]} && ./configure --prefix=#{node[:sphinx][:dir]} && make install
    EOH
  end

  environment = File.read('/etc/environment')
  unless environment.include?(node[:sphinx][:dir])
    File.open('/etc/environment', 'w') { |f| f.puts environment.gsub(/PATH="/, "PATH=\"#{node[:sphinx][:dir]}/bin:") }
  end
end
