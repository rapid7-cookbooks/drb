#
# Cookbook Name:: drb
# Recipe:: default
#
# Copyright (C) 2013 Rapid7
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package 'ruby'
package 'telnet'

template "/home/vagrant/drb-server.rb" do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  variables({ :drb_port => node[:drb][:port] })
  action :create
end

service 'vulnerable DRB server' do
  action :start
  start_command "ruby /home/vagrant/drb-server.rb start"
  supports [:start]
end
