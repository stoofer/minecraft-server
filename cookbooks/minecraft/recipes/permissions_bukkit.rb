#
# Cookbook Name:: minecraft
# Recipe:: permissions_bukkit

include_recipe 'minecraft::default'

directory '/opt/minecraft/plugins/PermissionsBukkit' do
  owner node.minecraft.account.name
  group node.minecraft.account.group
end

cookbook_file "/opt/minecraft/plugins/PermissionsBukkit-#{node.minecraft.plugins.permissions_bukkit.version}.jar" do
  source "plugins/PermissionsBukkit/PermissionsBukkit-#{node.minecraft.plugins.permissions_bukkit.version}.jar"
  owner node.minecraft.account.name
  group node.minecraft.account.group
end

cookbook_file "/etc/minecraft/plugins/config.yml" do
  source "plugins/PermissionsBukkit/config.yml"
  owner node.minecraft.account.name
  group node.minecraft.account.group
end

link '/opt/minecraft/plugins/PermissionsBukkit/config.yml' do
  to '/etc/minecraft/plugins/PermissionsBukkit/config.yml'
end

