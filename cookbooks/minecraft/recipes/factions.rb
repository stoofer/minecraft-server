# -*- coding: utf-8 -*-
# Cookbook Name:: minecraft
# Recipe:: factions

include_recipe 'minecraft::default'


directory '/var/minecraft/plugins/factions' do
  owner node.minecraft.account.name
  group node.minecraft.account.group
end

link '/opt/minecraft/plugins/Factions' do
  to '/var/minecraft/plugins/factions'
end

cookbook_file "/opt/minecraft/plugins/Factions.jar" do
  source "plugins/factions/factions-#{node.minecraft.plugins.factions.version}.jar"
  owner node.minecraft.account.name
  group node.minecraft.account.group

  notifies :restart, "service[minecraft]"
end

%w{board conf tags}.each do |file|
  cookbook_file "/var/minecraft/plugins/factions/#{file}.json" do
    source "plugins/factions/#{file}.json"
    
    owner node.minecraft.account.name
    group node.minecraft.account.group
    
    notifies :restart, "service[minecraft]"
  end

end

=begin
TODO - enable economy
TODO - permissions:

Permission Nodes -

Admin Permissions:

factions.* – Gives access to all commands (PermsEx, 2.x / 3.x, bPerms Only)
factions.kit.admin – Gives access to all commands (BukkitPerms Only)

Mod Permissions:

factions.kit.mod – Gives access to all mod perms below (BukkitPerms Only)
factions.disband.any
factions.setpermanent
factions.setpermanentpower
factions.setpeaceful
factions.sethome.any

Half-Mod Permissions:

factions.kit.halfmod – Gives access to all half-mod perms below (Bukkitperms Only)
factions.managesafezone
factions.factions.managewarzone
factions.bypass
factions.kick.any
factions.ownershipbypass

Full Player Permissions:
factions.kit.fullplayer – Gives access to all fullplayer perms below (Bukkitperms Only)
factions.create

Half Player Permissions:
factions.kit.halfplayer – Gives access to halfplayer perms below (Bukkitperms Only)
factions.admin
factions.autoclaim
factions.chat
factions.claim
factions.deinvite
factions.description
factions.disband
factions.help
factions.home
factions.invite
factions.join
factions.kick
factions.leave
factions.list
factions.map
factions.mod
factions.money.kit.standard
factions.noboom
factions.open
factions.owner
factions.ownerlist
factions.power
factions.power.any
factions.relation
factions.sethome
factions.show
factions.tag
factions.title
factions.version
factions.unclaim
factions.unclaimall

Standard Money Permissions:
factions.money.kit.standard – Gives access to all perms below (Bukkitperms Only)
factions.money.balance
factions.money.balance.any
factions.money.deposit
factions.money.withdraw
factions.money.f2f
factions.money.f2p
factions.money.p2f

Admin/Mod Money Permissions
factions.money.* – Gives you access to the following perms (Bukkitperms Only)
factions.money.kit.standard
factions.money.balance.any
factions.money.withdraw.any
=end
