name "minecraft-server"
description "Minecraft Server"
run_list(
  'recipe[minecraft]',
  'recipe[minecraft::group_manager]'
)
