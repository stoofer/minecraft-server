#
# Cookbook Name:: minecraft
# Recipe:: default
#
# Copyright 2012, Stuart Caborn
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'

user node.minecraft.account.name do
  comment 'minecraft service'
end

group node.minecraft.account.group do
  gid 999
  members node.minecraft.account.name
end

if( node.attribute?("ec2") )
  include_recipe("minecraft::ec2")
end

%w{screen java}.each do |rcp| 
  include_recipe(rcp)
end

package 'rsync'
package 'tree'


['/opt/minecraft',
'/opt/minecraft/plugins',
 '/etc/minecraft',
 '/var/minecraft',
 '/var/minecraft/plugins',
 '/var/minecraft/worldstorage',
 '/var/minecraft/worldstorage/world',
 '/var/minecraft/worldstorage/world_nether',
 '/var/minecraft/worldstorage/world_the_end',
 '/var/minecraft/backups',
 '/var/minecraft/backups/worlds',
 '/var/minecraft/backups/server',
 '/var/minecraft/logs',
 '/etc/minecraft/init',
 '/etc/minecraft/plugins'].each do |dir|
  directory dir do
    owner node.minecraft.account.name
    group node.minecraft.account.group
    mode "0755"
  end
end

#is this really a template?
template "/etc/minecraft/init/minecraft" do
  source "minecraft.erb"
  owner node.minecraft.account.name
  group node.minecraft.account.group
  mode "0755"
end

link "/etc/init.d/minecraft" do
  to "/etc/minecraft/init/minecraft"
end

file '/var/minecraft/logs/server.log' do
  owner node.minecraft.account.name
  group node.minecraft.account.group
  action :create_if_missing
end

link '/opt/minecraft/server.log' do
 to '/var/minecraft/logs/server.log'
end

%w{world world_nether world_the_end}.each do |world|
  directory "/var/minecraft/worldstorage/#{world}" do
    owner node.minecraft.account.name
    group node.minecraft.account.group
  end

  link "/opt/minecraft/#{world}" do
    to  "/var/minecraft/worldstorage/#{world}"
  end
end

['bukkit.yml','permissions.yml'].each do |config_file|
  cookbook_file "/etc/minecraft/#{config_file}" do
    mode "0644"
    owner node.minecraft.account.name    
    group node.minecraft.account.group
    action :create
  end

  link "/opt/minecraft/#{config_file}" do
    to  "/etc/minecraft/#{config_file}"
  end
end

['server.properties'].each do |config_file|
  
  template "/etc/minecraft/#{config_file}" do
    mode "0644"
    owner node.minecraft.account.name
    group node.minecraft.account.group
    variables( :minecraft => node.minecraft )
    action :create
  end
 
  link "/opt/minecraft/#{config_file}" do
    to  "/etc/minecraft/#{config_file}"
  end
end

['banned-ips.txt',
 'banned-players.txt',
 'ops.txt',
 'white-list.txt'].each do |config_file|
  
  template "/var/minecraft/#{config_file}" do
    mode "0644"
    owner node.minecraft.account.name
    group node.minecraft.account.group
    variables( :minecraft => node.minecraft )
    action :create_if_missing
  end
 
  link "/opt/minecraft/#{config_file}" do
    to  "/var/minecraft/#{config_file}"
  end
end

template "/etc/minecraft/init/config" do
  source "config.erb"
  owner node.minecraft.account.name
  group node.minecraft.account.group
  variables(
            :service_user => node['minecraft']['account']['name'],
            :minecraft_path => '/opt/minecraft',
            :initial_memory => node['minecraft']['memory']['initial'],
            :max_memory => node['minecraft']['memory']['max'],
            :backup_path => '/var/minecraft/backups/worlds',
            :log_path => '/var/minecraft/logs',
            :server_backup => '/var/minecraft/backups/server',
            :world_storage => '/var/minecraft/worldstorage'
  )
end

# TODO - tokenise version
remote_file "/opt/minecraft/craftbukkit_server.jar" do
  source node.minecraft.bukkit.path
  mode "0644"
  owner node.minecraft.account.name
  group node.minecraft.account.group
  action :create_if_missing
end

service "minecraft" do
  supports :start => true, :restart => true, :status => true
  action [:enable, :start]
  subscribes :restart, resources(:template => "/etc/minecraft/init/config")
  subscribes :restart, resources(:remote_file => "/opt/minecraft/craftbukkit_server.jar")
end


#m  h   dom mon dow command
#02  05  *   *   *   /etc/init.d/minecraft backup
#55  04  *   *   *   /etc/init.d/minecraft log-roll
#*/30    *   *   *   *   /etc/init.d/minecraft to-disk

cron "minecraft-backup" do
  hour "5"
  minute "2"
  command '/etc/init.d/minecraft backup'
end

cron "minecraft-log-roll" do
  hour "4"
  minute "55"
  command '/etc/init.d/minecraft log-roll'
end

cron "minecraft-flush" do
  minute "*/30"
  command '/etc/init.d/minecraft to-disk'
end

#Lock down sshd
service 'ssh' do
  supports :start => true, :restart => true
  action :nothing
end
cookbook_file '/etc/ssh/ssh_config' do
  notifies :restart, resources(:service => 'ssh')
end
