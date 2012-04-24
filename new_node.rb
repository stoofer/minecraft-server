#!/usr/bin/ruby

require 'rubygems'
require 'json'

node_config = {
  "run_list" => ["role[ec2-minecraft-server]"],
  "aws" => {
    "aws_access_key_id" => ENV['AWS_ACCESS_KEY_ID'],
    "aws_secret_access_key"=> ENV['AWS_SECRET_ACCESS_KEY'],
    "mc_volume_id" => "vol-9d3d90f5"
  }
}

File.open("nodes/#{ARGV[0]}.json", 'w'){|f| f.write node_config.to_json }
