#!/bin/bash
yum update -y
yum install java

aws s3 cp s3://awsgentleman-jar-files/awsgentleman-ec2-example.jar /home/ec2-user/awsgentleman-ec2-example.jar

chown ec2-user:ec2-user /home/ec2-user/awsgentleman-ec2-example.jar
chmod 500 /home/ec2-user/awsgentleman-ec2-example.jar

cat << EOF > /usr/lib/systemd/system/awsgentleman-ec2-example.service
[Unit]
Description=An example Spring Boot application
After=syslog.target

[Service]
Environment=RDS_HOSTNAME=
Environment=RDS_PORT=3306
Environment=RDS_DB_NAME=journaler_api
Environment=RDS_USERNAME=root
Environment=RDS_PASSWORD=
User=ec2-user
ExecStart=/usr/bin/java -jar /home/ec2-user/awsgentleman-ec2-example.jar
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target
EOF

chmod 744 /usr/lib/systemd/system/awsgentleman-ec2-example.service

service awsgentleman-ec2-example restart
