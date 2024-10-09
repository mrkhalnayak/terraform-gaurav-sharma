#!/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt install nginx -y
sudo systemctl enable nginx && sudo systemctl start nginx