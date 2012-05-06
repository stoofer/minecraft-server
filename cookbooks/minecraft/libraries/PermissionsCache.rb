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
    allowed= @@cache["#{type}s"][name] &&
      @@cache["#{type}s"][name]['permissions'] &&
      @@cache["#{type}s"][name]['permissions'][key]
    return allowed.nil? ? allowed: {:allow  => allowed }
  end

  def PermissionsCache.add_permission!(permission)
    Chef::Log.info "++++++++++++++++++++++++++++++++++++++++\nAdding #{permission.name} to cache"
    _, type, name, key = [*/(group|user):(.*):(.*)/.match(permission.name)]
    perms = @@cache["#{type}s"][name]['permissions'] || {}
    @@cache["#{type}s"][name]['permissions'] = perms.merge(key => permission.allow)
  end
end

module Permissions
  def group_permissions(name_permissions)
    name_permissions.each do |group_name, permissions|
      permissions.each do |permission, allowed|
        Chef::Log.info ">>>group:#{group_name}:#{permission}<<<<"
        minecraft_permission "group:#{group_name}:#{permission}" do
          allow allowed
          action :create_if_missing
        end
      end
    end
  end
end

