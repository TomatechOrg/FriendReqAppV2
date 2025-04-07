#!/usr/bin/env bash
sudo apt update
sudo apt install nodejs
sudo apt install npm
sudo apt install ruby-bundler
sudo npm install -g pm2
pm2 stop proj_app
cd FriendReqAppV2/
bundle install
rails db:migrate
pm2 start "sudo ~/.rbenv/shims/server --binding 0.0.0.0 --port 3000" --name proj_app