#
# Cookbook Name:: minecraft
# Recipe:: default
#
# Copyright 2012, Stuart Caborn
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "screen"

directory "/opt/minecraft"

# TODO - tokenise version
remote_file "/opt/minecraft/craftbukkit.jar" do
  source 'http://dl.bukkit.org/downloads/craftbukkit/get/01026_1.2.5-R1.0/craftbukkit.jar'
  mode "0644"
  checksum "b877b022ea4d61c24f9296767b3cf656"
end
