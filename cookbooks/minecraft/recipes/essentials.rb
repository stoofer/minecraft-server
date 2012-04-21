#
# Cookbook Name:: minecraft
# Recipe:: essentials

include_recipe 'minecraft::default'

cookbook_file "/opt/minecraft/plugins/Essentials.jar" do
  source "plugins/essentials/Essentials-#{node.minecraft.plugins.essentials.version}.jar"
  owner node.minecraft.account.name
  group node.minecraft.account.group

  notifies :restart, "service[minecraft]"
end

directory '/etc/minecraft/plugins/essentials' do
  owner node.minecraft.account.name
  group node.minecraft.account.group
end

link '/opt/minecraft/plugins/Essentials' do
  to '/etc/minecraft/plugins/essentials'
end

['worth.yml',
 'config.yml',
 'items.csv',
 'upgrades-done.yml'].each do |file|
  cookbook_file "/etc/minecraft/plugins/essentials/#{file}" do
    source "plugins/essentials/#{file}"
    
    owner node.minecraft.account.name
    group node.minecraft.account.group
    
    notifies :restart, "service[minecraft]"
  end

end

