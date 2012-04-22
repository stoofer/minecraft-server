# Make a new server
knife ec2 server create \
  --groups=minecraft \
  --image=ami-8d5069f9 --flavor=m1.small \
  --ssh-user=ubuntu \
  --ssh-key=knife --identity-file=~/.ssh/knife.pem

# Which servers are up
knife ec2 server list

#Prepare server {public-ip} for use with chef
knife prepare -i ~/.ssh/knife.pem ubuntu@{ip}

#Cook!
knife cook ubuntu@{ip} -i ~/.ssh/knife.pem