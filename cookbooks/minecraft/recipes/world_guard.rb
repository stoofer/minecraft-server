#
# Cookbook Name:: minecraft
# Recipe:: world_guard

include_recipe 'minecraft::default'

directory '/var/minecraft/plugins/world_guard' do
  owner node.minecraft.account.name
  group node.minecraft.account.group
  mode "0755"
end

link '/opt/minecraft/plugins/WorldGuard' do
  to '/var/minecraft/plugins/world_guard'
end

cookbook_file "/opt/minecraft/plugins/worldguard-#{node.minecraft.plugins.world_guard.version}.jar" do
  source "plugins/world_guard/worldguard-#{node.minecraft.plugins.world_guard.version}.jar"
  owner node.minecraft.account.name
  group node.minecraft.account.group
  notifies :restart, "service[minecraft]"
end

cookbook_file "/var/minecraft/plugins/world_guard/config.yml" do
  source 'plugins/world_guard/config.yml'
  owner node.minecraft.account.name
  group node.minecraft.account.group
  notifies :restart, "service[minecraft]"
end

['world', 'world_nether', 'world_the_end'].each do |world|
  directory "/var/minecraft/plugins/world_guard/worlds/#{world}" do
    owner node.minecraft.account.name
    group node.minecraft.account.group
    mode "0755"
    recursive true
  end

  ['blacklist.txt', 'config.yml', 'regions.yml'].each do |cfg|
    cookbook_file "/var/minecraft/plugins/world_guard/worlds/#{world}/#{cfg}" do
      source "plugins/world_guard/worlds/#{world}/#{cfg}"
      owner node.minecraft.account.name
      group node.minecraft.account.group
      notifies :restart, "service[minecraft]"
      mode "0644"
      action :create_if_missing
    end
  end
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
  'worldguard.*' => true
}


