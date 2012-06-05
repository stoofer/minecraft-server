#
# Cookbook Name:: minecraft
# Recipe:: essentials

include_recipe 'minecraft::default'

directory '/var/minecraft/plugins/essentials' do
  owner node.minecraft.account.name
  group node.minecraft.account.group
end

link '/opt/minecraft/plugins/Essentials' do
  to '/var/minecraft/plugins/essentials'
end

cookbook_file "/opt/minecraft/plugins/Essentials.jar" do
  source "plugins/essentials/Essentials-#{node.minecraft.plugins.essentials.version}.jar"
  owner node.minecraft.account.name
  group node.minecraft.account.group

  notifies :restart, "service[minecraft]"
end


['worth.yml',
 'config.yml',
 'items.csv',
 'upgrades-done.yml'].each do |file|
  cookbook_file "/var/minecraft/plugins/essentials/#{file}" do
    source "plugins/essentials/#{file}"

    owner node.minecraft.account.name
    group node.minecraft.account.group
    action :create_if_missing
    notifies :restart, "service[minecraft]"
  end

end

class Chef::Recipe
  include Permissions
end

group_permissions :default => {
  'essentials.spawn' => true,
  'essentials.rules' => true,
  'essentials.motd' => true,
  'essentials.list' => true,
  'essentials.helpop' => true,
  'essentials.help' => true
},
:builder => {
  'essentials.afk' => true,
  'essentials.back' => true,
  'essentials.back.ondeath' => true,
  'essentials.balance' => true,
  'essentials.balance.others' => true,
  'essentials.balancetop' => true,
  'essentials.chat.color' => true,
  'essentials.chat.shout' => true,
  'essentials.chat.question' => true,
  'essentials.compass' => true,
  'essentials.depth' => true,
  'essentials.home' => true,
  'essentials.ignore' => true,
  'essentials.kit' => true,
  'essentials.kit.tools' => true,
  'essentials.mail' => true,
  'essentials.mail.send' => true,
  'essentials.me' => true,
  'essentials.msg' => true,
  'essentials.nick' => true,
  'essentials.pay' => true,
  'essentials.ping' => true,
  'essentials.powertool' => true,
  'essentials.protect' => true,
  'essentials.sethome' => true,
  'essentials.signs.use.*' => true,
  'essentials.signs.create.disposal' => true,
  'essentials.signs.create.mail' => true,
  'essentials.signs.create.protection' => true,
  'essentials.signs.create.trade' => true,
  'essentials.signs.break.disposal' => true,
  'essentials.signs.break.mail' => true,
  'essentials.signs.break.protection' => true,
  'essentials.signs.break.trade' => true,
  'essentials.suicide' => true,
  'essentials.time' => true,
  'essentials.tpa' => true,
  'essentials.tpaccept' => true,
  'essentials.tpahere' => true,
  'essentials.tpdeny' => true,
  'essentials.warp' => true,
  'essentials.warp.list' => true,
  'essentials.worth' =>true
},
:moderator => {
  'essentials.ban' => true,
  'essentials.ban.notify' => true,
  'essentials.banip' => true,
  'essentials.broadcast' => true,
  'essentials.clearinventory' => true,
  'essentials.delwarp' => true,
  'essentials.eco.loan' => true,
  'essentials.ext' => true,
  'essentials.getpos' => true,
  'essentials.helpop.recieve' => true,
  'essentials.home.others' => true,
  'essentials.invsee' => true,
  'essentials.jails' => true,
  'essentials.jump' => true,
  'essentials.kick' => true,
  'essentials.kick.notify' => true,
  'essentials.kill' => true,
  'essentials.mute' => true,
  'essentials.nick.others' => true,
  'essentials.realname' => true,
  'essentials.setwarp' => true,
  'essentials.signs.break.*' => true,
  'essentials.spawner' => true,
  'essentials.thunder' => true,
  'essentials.time' => true,
  'essentials.time.set' => true,
  'essentials.protect.alerts' => true,
  'essentials.protect.admin' => true,
  'essentials.protect.ownerinfo' => true,
  'essentials.ptime'=> true,
  'essentials.ptime.others' => true,
  'essentials.togglejail' => true,
  'essentials.top' => true,
  'essentials.tp' => true,
  'essentials.tphere' => true,
  'essentials.tppos' => true,
  'essentials.tptoggle' => true,
  'essentials.unban' => true,
  'essentials.unbanip' => true,
  'essentials.weather' => true,
  'essentials.whois' => true,
  'essentials.world' => true
},
:admin => {
  '-essentials.backup' => true,
  '-essentials.essentials' => true,
  '-essentials.setspawn' => true,
  '-essentials.reloadall' => true,
  'essentials.*' => true
},
:owner => {
  '-essentials.backup' => true,
  '-essentials.essentials' => true,
  '-essentials.setspawn' => true,
  '-essentials.reloadall' => true,
}
