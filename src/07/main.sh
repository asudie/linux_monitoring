#!bin/bash

# Установка nginx
apt install nginx
rm /etc/nginx/sites-enabled/default 
service nginx restart 
systemctl stop/start/enable nginx.service

## Создание пользователя в Prometheus
### Создание группы и нового пользователя:
groupadd prometheus 
useradd -s /sbin/nologin --system -g prometheus prometheus 
mkdir /var/lib/prometheus 
for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done

## Устанавливаем сам Prometheus на Ubuntu:
mkdir -p /tmp/prometheus 
wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz
tar vxf prometheus*.tar.gz

# Configuring prometeus
sudo mv prometheus /usr/local/bin
sudo mv promtool /usr/local/bin
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool

sudo mv consoles /etc/prometheus
sudo mv console_libraries /etc/prometheus
sudo mv prometheus.yml /etc/prometheus

sudo chown prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown -R prometheus:prometheus /var/lib/prometheus

# Default yaml is alright

sudo nano /etc/prometheus/prometheus.yml

# Create Prometheus Systemd Service
sudo nano /etc/systemd/system/prometheus.service

# Add this

# [Unit]
# Description=Prometheus
# Wants=network-online.target
# After=network-online.target

# [Service]
# User=prometheus
# Group=prometheus
# Type=simple
# ExecStart=/usr/local/bin/prometheus \
#     --config.file /etc/prometheus/prometheus.yml \
#     --storage.tsdb.path /var/lib/prometheus/ \
#     --web.console.templates=/etc/prometheus/consoles \
#     --web.console.libraries=/etc/prometheus/console_libraries

# [Install]
# WantedBy=multi-user.target

# Reload Systemd
sudo systemctl daemon-reload
sudo systemctl restart prometheus

# Start Prometheus Service
sudo systemctl enable prometheus
sudo systemctl start prometheus

# Check Prometheus Status
sudo systemctl status prometheus

# Access Prometheus Web Interface
sudo ufw allow 9090/tcp
sudo ufw reload
sudo ufw disable
sudo ufw enable

# With Prometheus running successfully, you can access it via your web browser using localhost:9090 or <ip_address>:9090

# Установка Grafana

## Нужное ПО:

apt-get install -y software-properties-common wget apt-transport-https` 

## Добавляем ключ от репозитория Grafana:

(Interprise version)

wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add - 

(OSS version)

sudo apt-get install -y adduser libfontconfig1 
wget https://dl.grafana.com/oss/release/grafana_9.2.4_amd64.deb 
sudo dpkg -i grafana_9.2.4_amd64.deb

## Обновляем репозитории и установливаем Grafana

apt-get update && apt-get -y install grafana 

## Изменяем владельца файла:

chown grafana:grafana /etc/grafana/provisioning/datasources/prometheus.yml

## Запускаем Grafana:

systemctl start grafana-server.service 
systemctl enable grafana-server.service 
systemctl status grafana-server.service

## Делаем проброс 3000 порта и заходим в Grafana (пароль admin/admin):

sudo apt install stress
