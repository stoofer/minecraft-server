# Cookbook Name:: minecraft
# Recipe:: mob_disguise

include_recipe 'minecraft::default'

directory '/var/minecraft/plugins/mob_disguise' do
  owner node.minecraft.account.name
  group node.minecraft.account.group
end

link '/opt/minecraft/plugins/MobDisguise' do
  to '/var/minecraft/plugins/mob_disguise'
end

cookbook_file "/opt/minecraft/plugins/MobDisguise.jar" do
  source "plugins/mob_disguise/mob_disguise-#{node.minecraft.plugins.mob_disguise.version}.jar"
  owner node.minecraft.account.name
  group node.minecraft.account.group

  notifies :restart, "service[minecraft]"
end


