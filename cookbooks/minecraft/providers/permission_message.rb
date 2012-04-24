action :create do
  ruby_block "update_data" do
    block do
      PermissionsCache.messages[new_resource.name] = new_resource.message
    end
    notifies :create, resources(:ruby_block => 'update_permissions_file')
  end
end
