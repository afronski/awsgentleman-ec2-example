#!/bin/bash
yum update -y
yum install java -y

aws s3 cp s3://example-jar-files/service-example.jar /home/ec2-user/service-example.jar

chown ec2-user:ec2-user /home/ec2-user/service-example.jar
chmod 500 /home/ec2-user/service-example.jar

cat << EOF > /usr/lib/systemd/system/service-example.service
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
ExecStart=/usr/bin/java -jar /home/ec2-user/service-example.jar
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target
EOF

chmod 744 /usr/lib/systemd/system/service-example.service

service service-example restart
