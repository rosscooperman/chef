#
# Cookbook Name:: cap-deploy-user
# Recipe:: default
#
# Copyright 2011, Ross Cooperman
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

home_dir = "/var/apps"

# create the user and home directory
user "deploy" do
  comment "Capistrano Deployment Account"
  system true
  shell "/bin/bash"
  home home_dir
end
directory home_dir do
  owner "deploy"
  group "deploy"
  mode 0755
  recursive true
end

# transfer the user's profile scripts
%w{ .bash_logout .bashrc .profile }.each do |file|
  cookbook_file File.join(home_dir, file) do
    source file
    mode 0644
    owner "deploy"
    group "deploy"
  end
end

# create the user's private and public keys
keys = data_bag_item('ssh-keys', 'deploy')
directory "#{home_dir}/.ssh" do
  owner "deploy"
  group "deploy"
  mode 0700
  recursive true
end
file "#{home_dir}/.ssh/id_rsa" do
  owner "deploy"
  group "deploy"
  mode 0600
  content keys["private"]
  backup false
end
file "#{home_dir}/.ssh/id_rsa.pub" do
  owner "deploy"
  group "deploy"
  mode 0644
  content keys["public"]
  backup false
end

# add the user's default authorized_keys and known_hosts files
file "#{home_dir}/.ssh/authorized_keys" do
  owner "deploy"
  group "deploy"
  mode 0600
  content keys["keys"]
  backup false
end
cookbook_file "#{home_dir}/.ssh/known_hosts" do
  owner "deploy"
  group "deploy"
  mode 0644
  source "known_hosts"
  backup false
end
