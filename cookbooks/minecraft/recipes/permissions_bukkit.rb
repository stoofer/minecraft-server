#
# Cookbook Name:: minecraft
# Recipe:: permissions_bukkit

include_recipe 'minecraft::default'

['/opt/minecraft/plugins/PermissionsBukkit',
 '/etc/minecraft/plugins/PermissionsBukkit'].each do |dir|
  directory dir do
    owner node.minecraft.account.name
    group node.minecraft.account.group
  end
end

cookbook_file "/opt/minecraft/plugins/PermissionsBukkit-#{node.minecraft.plugins.permissions_bukkit.version}.jar" do
  source "plugins/PermissionsBukkit/PermissionsBukkit-#{node.minecraft.plugins.permissions_bukkit.version}.jar"
  owner node.minecraft.account.name
  group node.minecraft.account.group

  notifies :restart, "service[minecraft]"
end

template "/etc/minecraft/plugins/PermissionsBukkit/config.yml" do
  source "plugins/PermissionsBukkit/config.yml.erb"
  owner node.minecraft.account.name
  group node.minecraft.account.group

  variables(:users => node['minecraft']['users'],
            :groups => node['minecraft']['plugins']['permissions_bukkit']['groups'],
            :messages => node['minecraft']['plugins']['permissions_bukkit']['messages'],
            :debug => node['minecraft']['plugins']['permissions_bukkit']['debug'])

  notifies :restart, "service[minecraft]"
end

link '/opt/minecraft/plugins/PermissionsBukkit/config.yml' do
  to '/etc/minecraft/plugins/PermissionsBukkit/config.yml'
end

