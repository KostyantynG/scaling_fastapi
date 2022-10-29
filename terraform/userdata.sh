#!/bin/bash

cd /home/ec2-user/
aws s3 cp s3://scaling-fastapi-bucket-1/script.zip /home/ec2-user/script.zip
unzip script.zip
sudo python3 -m pip install -r requirements.txt
sudo python3 main.py
