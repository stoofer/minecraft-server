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

  def PermissionsCache.permission(resource)
    _, type, name, key = [*/(group|user):(.*):(.*)/.match(resource.name)]
    return nil unless @@cache["#{type}s"][name]['permissions']
    return nil unless @@cache["#{type}s"][name]['permissions'][key] == nil

    return {:allow  => @@cache["#{type}s"][name][key]}
  end

  def PermissionsCache.add_permission!(permission)
    Chef::Log.info "++++++++++++++++++++++++++++++++++++++++\nAdding #{permission.name} to cache"
    _, type, name, key = [*/(group|user):(.*):(.*)/.match(permission.name)]
    perms = @@cache["#{type}s"][name]['permissions'] || {}
    @@cache["#{type}s"][name]['permissions'] = perms.merge(key => permission.allow)
  end
end
