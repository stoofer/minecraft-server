def load_current_resource
  if(current = PermissionsCache.permission(@new_resource))
    @current_resource = Chef::Resource::MinecraftPermission.new(@new_resource.name)
    @current_resource.allow(current[:allow])
    Chef::Log.info("Permission #{@new_resource.name} is #{@current_resource.allow ? 'allowed' : 'denied'}")
  else
    Chef::Log.info("Permission #{@new_resource.name} does not exist")
  end
  @current_resource
end


action :create do
  ruby_block "update_data" do
    block do
      PermissionsCache.add_permission! new_resource
    end
    notifies :create, resources(:ruby_block => 'update_permissions_file')
  end
end

action :create_if_missing do
  ruby_block "create_if_missing" do
    block do
      PermissionsCache.add_permission! new_resource
    end
    not_if { current_resource }
    notifies :create, resources(:ruby_block => 'update_permissions_file')
  end
end
