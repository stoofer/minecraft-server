default.minecraft.plugins.essentials.version = '1.2'

=begin
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
=end
