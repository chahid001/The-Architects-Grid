#!/bin/bash
sudo yum update -y
sudo aws s3 cp s3://app-bucket-s3/index.html /var/www/html/
sudo systemctl restart httpd