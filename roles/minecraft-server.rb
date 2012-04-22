name "minecraft-server"
description "Minecraft Server"
run_list(
         'recipe[minecraft]',
         'recipe[minecraft::permissions_bukkit]',
         'recipe[minecraft::essentials]',
         'recipe[minecraft::factions]'
         )
