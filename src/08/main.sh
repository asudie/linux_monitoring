#!bin/bash

# Download Node Exporter

wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz

# Create User

sudo groupadd -f node_exporter
sudo useradd -g node_exporter --no-create-home --shell /bin/false node_exporter
sudo mkdir /etc/node_exporter
sudo chown node_exporter:node_exporter /etc/node_exporter

# Unpack Node Exporter Binary

tar -xvf node_exporter-1.0.1.linux-amd64.tar.gz
mv node_exporter-1.0.1.linux-amd64 node_exporter-files

# Install Node Exporter

sudo cp node_exporter-files/node_exporter /usr/bin/
sudo chown node_exporter:node_exporter /usr/bin/node_exporter

# Setup Node Exporter Service

sudo vi /usr/lib/systemd/system/node_exporter.service

# [Unit]
# Description=Node Exporter
# Documentation=https://prometheus.io/docs/guides/node-exporter/
# Wants=network-online.target
# After=network-online.target

# [Service]
# User=node_exporter
# Group=node_exporter
# Type=simple
# Restart=on-failure
# ExecStart=/usr/bin/node_exporter \
#   --web.listen-address=:9200

# [Install]
# WantedBy=multi-user.target

sudo chmod 664 /usr/lib/systemd/system/node_exporter.service

# Reload systemd and Start Node Exporter

sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl status node_exporter
sudo systemctl enable node_exporter.service
sudo ufw allow 9200/tcp

# Clean Up

rm -rf node_exporter-1.0.1.linux-amd64.tar.gz node_exporter-files


sudo apt install prometheus-node-exporter