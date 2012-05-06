#
# Cookbook Name:: minecraft
# Recipe:: world_edit

include_recipe 'minecraft::default'

directory '/var/minecraft/plugins/world_edit' do
  owner node.minecraft.account.name
  group node.minecraft.account.group
  mode "0755"
end

link '/opt/minecraft/plugins/WorldEdit' do
  to '/var/minecraft/plugins/world_edit'
end

cookbook_file "/opt/minecraft/plugins/WorldEdit.jar" do
  source "plugins/world_edit/world_edit-#{node.minecraft.plugins.world_edit.version}.jar"
  owner node.minecraft.account.name
  group node.minecraft.account.group

  notifies :restart, "service[minecraft]"
end

cookbook_file "/var/minecraft/plugins/world_edit/js.jar" do
  source 'plugins/world_edit/js.jar'
  owner node.minecraft.account.name
  group node.minecraft.account.group
  notifies :restart, "service[minecraft]"
end

cookbook_file "/var/minecraft/plugins/world_edit/config.yml" do
  source 'plugins/world_edit/config.yml'
  owner node.minecraft.account.name
  group node.minecraft.account.group
  notifies :restart, "service[minecraft]"
end

class Chef::Recipe
  include Permissions
end

group_permissions :default => {

},
:builder => {
},
:moderator => {
},
:admin => {
 
},
:owner => {
  'worldedit.*' => true
}


