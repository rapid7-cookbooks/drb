#
# Cookbook Name:: drb
# Recipe:: default
#
# Copyright (C) 2013 Rapid7
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package 'ruby'
package 'telnet'

template '/home/vagrant/drb-server' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  variables({ :drb_port => node[:drb][:port], :safe => node[:drb][:safe] })
  action :create
end

link '/etc/init.d/drb-server' do
  to '/home/vagrant/drb-server'
end

# NOTE: This is an execute block vs. a service block due to service[drb-server]
# w/ action start not starting the drb-server service.
execute 'start drb-server service' do
  command 'service drb-server start'
end
