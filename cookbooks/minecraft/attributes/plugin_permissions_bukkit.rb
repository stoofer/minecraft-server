default.minecraft.plugins.permissions_bukkit.version = '1.6'

default.minecraft.plugins.permissions_bukkit['groups'] = {
  'default' => { 
    :permissions => {
      'permissions.build' => false
    }
  },
  'builder' => {
    :permissions => {
      'permissions.build' => true,    
    },
    :inheritance => ['default']
  },

  'moderator' => {
    :permissions => {
	  'factions.kit.mod' => true,
    },
    :inheritance => ['builder' ]
	},
  'rolo of the polos' => {
    :inheritance => ['moderator' ]
  },
  'admin' => {
    :permissions => {
      'permissions.*' => true,
      'factions.kit.admin' => true,
    },
    'inheritance' => ['moderator']
  },
  'owner' => { 'inheritance' => ['admin'] },
  'turtley awesome' => { 'inheritance' => ['owner']
  },
  'crazy wolf' => { 'inheritance' => ['owner']
  },
  'co-owner' => { 'inheritance' => ['owner'] }
}

default.minecraft.plugins.permissions_bukkit.debug = false

default.minecraft.plugins.permissions_bukkit.messages = {
  'build' => '&cYou cannot build in this area FOOL!!!'
}


