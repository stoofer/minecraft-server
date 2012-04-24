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

  variables(:users => node['minecraft']['users'],
            :groups => node['minecraft']['plugins']['permissions_bukkit']['groups'],
            :messages => node['minecraft']['plugins']['permissions_bukkit']['messages'],
            :debug => node['minecraft']['plugins']['permissions_bukkit']['debug'])

  action :create_if_missing
  notifies :restart, "service[minecraft]"
end


