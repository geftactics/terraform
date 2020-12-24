#! /bin/bash

# Install docker
yum -y install git docker
systemctl enable docker --now

# Install docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Persistant stuff
mkdir /go
echo "aws ec2 attach-volume --volume-id vol-0d6f4c3161e957dda --instance-id $(curl -s http://169.254.169.254/latest/meta-data/instance-id) --device /dev/xvdf --region eu-west-1" >> /etc/rc.local
echo "aws ec2 associate-address --allocation-id eipalloc-0273a1e9199e873eb --instance-id $(curl -s http://169.254.169.254/latest/meta-data/instance-id) --region eu-west-1" >> /etc/rc.local
echo "/dev/xvdf					/go	ext4	defaults,nofail		0	2" >> /etc/fstab
echo "mount -a" >> /etc/rc.local
echo "cd /go/kardia" >> /etc/rc.local
echo "/usr/local/bin/docker-compose up -d" >> /etc/rc.local
chmod +x /etc/rc.local && /etc/rc.local