actions :create, :create_if_missing
attribute :name, :kind_of => String, :name_attribute => true
attribute :allow, :kind_of => [TrueClass, FalseClass]
