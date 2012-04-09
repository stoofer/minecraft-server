#
# Cookbook Name:: minecraft
# Recipe:: default
#
# Copyright 2012, Stuart Caborn
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "screen"

user 'mcsvc' do
  comment   'minecraft service'
end
 
group "minecraft" do
  gid     999
  members 'mcsvc'
end

['/opt/minecraft',
 '/etc/minecraft',
 '/var/minecraft',
 '/etc/minecraft/init'].each do |dir|
  directory dir do
    owner 'mcsvc'
    group 'minecraft'
  end
end

template "/etc/minecraft/init/config" do
  source "config.erb"
  owner 'mcsvc'
  group 'minecraft'
  variables(
            :service_user => 'mcsvc',
            :minecraft_path => '/opt/minecraft',
            :initial_memory => '400M',
            :max_memory => '1400M',
            :backup_path => '/var/minecraft/backups/worlds',
            :log_path => '/var/minecraft/logs',
            :server_backup => '/var/minecraft/backups/server',
            :world_storage => '/var/minecraft/worldstorage'
  )
end

#is this really a template?
template "/etc/minecraft/init/minecraft" do
  source "minecraft.erb"
  owner "mcsvc"
  group "minecraft"
end

# TODO - tokenise version
remote_file "/opt/minecraft/craftbukkit.jar" do
  source 'http://dl.bukkit.org/downloads/craftbukkit/get/01026_1.2.5-R1.0/craftbukkit.jar'
  mode "0644"
  owner "mcsvc"
  group "minecraft"
  checksum "b877b022ea4d61c24f9296767b3cf656"
end
