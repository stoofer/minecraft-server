actions :create, :create_if_missing
attribute :name, :kind_of => String, :name_attribute => true
attribute :inheritance, :kind_of => Array
attribute :permissions, :kind_of => Hash
