#
# Cookbook Name:: minecraft
# Recipe:: permissions_bukkit

include_recipe 'minecraft::default'

directory '/var/minecraft/plugins/permissions_bukkit' do
  owner node.minecraft.account.name
  group node.minecraft.account.group
end

link '/opt/minecraft/plugins/PermissionsBukkit' do
  to '/var/minecraft/plugins/permissions_bukkit'
end

cookbook_file "/opt/minecraft/plugins/PermissionsBukkit-#{node.minecraft.plugins.permissions_bukkit.version}.jar" do
  source "plugins/PermissionsBukkit/PermissionsBukkit-#{node.minecraft.plugins.permissions_bukkit.version}.jar"
  owner node.minecraft.account.name
  group node.minecraft.account.group

  notifies :restart, "service[minecraft]"
end

template "/var/minecraft/plugins/permissions_bukkit/config.yml" do
  source "plugins/PermissionsBukkit/config.yml.erb"
  owner node.minecraft.account.name
  group node.minecraft.account.group
  action :create_if_missing
  notifies :restart, "service[minecraft]"
end

ruby_block "cache_config_yml" do
  block do
    require 'yaml'
    raw = IO.read('/var/minecraft/plugins/permissions_bukkit/config.yml')
    defaults = {:debug => node['minecraft']['plugins']['permissions_bukkit']['debug']}
    PermissionsCache.set! defaults.merge(YAML::load(raw))
  end
end

ruby_block "update_permissions_file" do
  block do
    File.open('/var/minecraft/plugins/permissions_bukkit/config.yml', "w") do |f|
      f.puts PermissionsCache.yaml
    end
  end
  notifies :restart, resources(:service => 'minecraft')
  action :nothing
end

node['minecraft']['users'].each do |name,user|
  minecraft_player name do
    groups user[:groups]
    action :create_if_missing
  end
end

node['minecraft']['plugins']['permissions_bukkit']['groups'].each do |name,group|
  minecraft_group name do
    permissions (group[:permissions] || Mash.new).to_hash
    inheritance group[:inheritance]
    action :create_if_missing
  end
end

node['minecraft']['plugins']['permissions_bukkit']['messages'].each do |name,text|
  minecraft_permission_message name do
    message text
    action :create
  end
end

minecraft_permission_message 'test' do
  message 'test text'
  action :create
end

service 'minecraft' do
  action :restart
end
