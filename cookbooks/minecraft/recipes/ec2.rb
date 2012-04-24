#
# Cookbook Name:: minecraft
# Recipe:: default
#
# Copyright 2012, Stuart Caborn
#
# All rights reserved - Do Not Redistribute
#
r = gem_package "right_aws" do
  action :nothing
end
r.run_action(:install)

Gem.clear_paths


include_recipe "aws"
aws = node['aws']

aws_ebs_volume 'ebs_var_minecraft' do
  aws_access_key aws['aws_access_key_id']
  aws_secret_access_key aws['aws_secret_access_key']
  size 2
  device "/dev/sdb"
  action [ :create, :attach ]
end

execute "format_new_volume" do
  command "mkfs.ext3 /dev/xvdb"
  creates "/var/minecraft"
end


directory '/var/minecraft' do
  owner node.minecraft.account.name
  group node.minecraft.account.group
end

mount "/var/minecraft" do
  device "/dev/xvdb"
  fstype "ext3"
  options "rw"
  action [:enable, :mount]
end
  
