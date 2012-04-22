# Cookbook Name:: minecraft
# Recipe:: factions

include_recipe 'minecraft::default'

cookbook_file "/opt/minecraft/plugins/Vault.jar" do
  source "plugins/vault/vault-#{node.minecraft.plugins.vault.version}.jar"
  owner node.minecraft.account.name
  group node.minecraft.account.group

  notifies :restart, "service[minecraft]"
end
