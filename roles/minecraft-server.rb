name "minecraft-server"
description "Minecraft Server"
run_list(
         'recipe[minecraft]',
         'recipe[minecraft::permissions_bukkit]',
         'recipe[minecraft::vault]',
         'recipe[minecraft::essentials]',
         'recipe[minecraft::essentials_spawn]',
         'recipe[minecraft::factions]',
         'recipe[minecraft::mob_disguise]',
         'recipe[minecraft::world_edit]',
         'recipe[minecraft::world_guard]'
         )
