name "minecraft-server"
description "Minecraft Server"
run_list(
  'recipe[apt]',
  'recipe[screen]'
)
