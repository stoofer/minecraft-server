#
# Cookbook Name:: minecraft
# Recipe:: group_manager

include_recipe 'minecraft::default'

%w{EssentialsGroupManager EssentialsGroupBridge}.each do |jar|
  cookbook_file "/opt/minecraft/plugins/#{jar}.jar" do
    source "plugins/group_manager/#{jar}.jar"
    owner node.minecraft.account.name
    group node.minecraft.account.group
  end
end

