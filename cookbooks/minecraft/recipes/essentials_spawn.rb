#
# Cookbook Name:: minecraft
# Recipe:: essentials

include_recipe 'minecraft::default'

cookbook_file "/opt/minecraft/plugins/EssentialsSpawn.jar" do
  source "plugins/essentials_spawn/essentials_spawn-#{node.minecraft.plugins.essentials.version}.jar"
  owner node.minecraft.account.name
  group node.minecraft.account.group

  notifies :restart, "service[minecraft]"
end

class Chef::Recipe
  include Permissions
end

group_permissions :default => {
  'essentials.spawn' => true, 
},
:builder => {
},
:moderator => {
},
:admin => {
  '-essentials.setspawn' => true,
},
:owner => {
  '-essentials.setspawn' => true,

}

