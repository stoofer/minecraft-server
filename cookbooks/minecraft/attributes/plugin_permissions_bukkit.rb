default.minecraft.plugins.permissions_bukkit.version = '1.6'

default.minecraft.plugins.permissions_bukkit['groups'] = {
  'default' => { 
    'permissions' => {
      'permissions.build' => false
    }
  },
  'admin' => {
    'permissions' => {
      'permissions.*' => true
    },
    'inheritance' => ['user']
  },
  'user' => {
    'permissions' => {
      'permissions.build' => true
    },
    'worlds' => {
      'creative' => {
        'coolplugin.item' => true
      }
    },
    'inheritance' => ['default']
  }
}

default.minecraft.plugins.permissions_bukkit.debug = false

default.minecraft.plugins.permissions_bukkit.messages = {
  'build' => '&cYou do not have permission to build here.'
}


