Description
===========

Requirements
============

Attributes
==========

Usage
=====

# Create a new instance with a blank ubuntu AMI
knife ec2 server create \
  --groups=minecraft \
  --image=ami-8d5069f9 --flavor=t1.micro \
  --ssh-user=ubuntu \
  --ssh-key=knife --identity-file=~/.ssh/knife.pem

# Which servers are up
knife ec2 server list

#Prepare server {public-ip} for use with chef
knife prepare -i ~/.ssh/knife.pem ubuntu@{ip}

#Generate a new json file for the new server and cook it
$./new_node.rb {ip}
$ knife cook -i ~/.ssh/knife.pem ubuntu@{ip}


TODO - document attributes
     - move whitelist permission groups etc to var and don't overwrite if present.
     - tokenise more of the minecraft service config
     - update service script?
     - mob disguise plugin
     - LWRP for adding permissions to groups on a per pluign basis


Amazon EBS on ubuntu:
mount point is /dev/sdb => /dev/xvdb
vol-30ec4e58

"/dev/sdf /data ext3 defaults 1 1"



