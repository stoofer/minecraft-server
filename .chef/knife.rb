log_level                :info
log_location             STDOUT
node_name                'solo'
client_key               'solo.pem'
node_name                'solo'
client_key               File.expand_path('../solo.pem', __FILE__)
cache_type               'BasicFile'
cache_options( :path => File.expand_path('../checksums', __FILE__))
cookbook_path [ File.expand_path('../../cookbooks', __FILE__) ]

# EC2 sub-commands
#
knife[:availability_zone] = "#{ENV['EC2_AVAILABILITY_ZONE']}"
knife[:aws_access_key_id] = "#{ENV['AWS_ACCESS_KEY_ID']}"
knife[:aws_secret_access_key] = "#{ENV['AWS_SECRET_ACCESS_KEY']}"
knife[:chef_mode] = "solo"
knife[:region] = "#{ENV['EC2_REGION']}"
