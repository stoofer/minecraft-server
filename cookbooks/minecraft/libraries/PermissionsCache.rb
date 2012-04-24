require 'yaml'
    
class PermissionsCache
  def PermissionsCache.set!(value)
    @@cache = {
      'users' => {},
      'groups' => {},
      'messages' => {}
    }.merge value
  end

  def PermissionsCache.yaml
    @@cache.to_yaml
  end

  def PermissionsCache.users
    @@cache['users']
  end

  def PermissionsCache.groups
    @@cache['groups']
  end

  def PermissionsCache.messages
    @@cache['messages']
  end
end
