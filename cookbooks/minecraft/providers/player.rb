def load_current_resource
  current = PermissionsCache.users[@new_resource.name]
  if(current)
    @current_resource = Chef::Resource::MinecraftPlayer.new(@new_resource.name)
    @current_resource.groups(PermissionsCache.users[@new_resource.name]['groups'] || [])
    Chef::Log.info("Player #{@new_resource.name} exists as #{@current_resource.groups}")
  else
    Chef::Log.info("Player #{@new_resource.name} does not exist")
  end
  @current_resource
end


action :create do
  ruby_block "update_data" do
    block do
      PermissionsCache.users[new_resource.name] = {'groups' => [*new_resource.groups]}
      Chef::Log.info "Created new player #{new_resource.name}"
    end
    notifies :create, resources(:ruby_block => 'update_permissions_file')
  end
end

action :create_if_missing do
  ruby_block "create_new" do
    block do
      PermissionsCache.users[new_resource.name] = {'groups' => [*new_resource.groups]}
      Chef::Log.info "Created new player #{new_resource.name}"
    end
    not_if {current_resource}
    notifies :create, resources(:ruby_block => 'update_permissions_file')
  end
end
