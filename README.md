# Ravotraccar

Configurazioni Terraform per la creazione di due EC2 instances usate per familiarizzare con il software [Traccar](https://www.traccar.org/) per il tracciamento dei ciclisti durante la [Ravorando 2002](https://www.gsravonese.it/ravorando-2022/).

Nel seguito i passi da automatizzare con un qualche strumento di gestione delle configurazioni.

## DB setup

sudo systemctl enable --now mysqld

TMP_ROOT_PWD=$(sudo grep 'temporary password' /var/log/mysqld.log | awk -F': ' '{print $2}')

sudo mysql_secure_installation -p$TMP_ROOT_PWD

## DB config
```
CREATE USER 'apptrac'@'%' IDENTIFIED WITH mysql_native_password BY 'password';
CREATE DATABASE ravorando;
GRANT ALL ON ravorando.* TO 'apptrac'@'%';
FLUSH PRIVILEGES;
```

## APP config

```
curl -LO https://github.com/traccar/traccar/releases/download/v4.15/traccar-linux-64-4.15.zip
unzip traccar-linux-64-4.15.zip
sudo ./traccar.run
```

Change /opt/traccar/conf/traccar.xml with info required for MySQL db.

Run as Non-Root User
```
sudo mkdir /etc/systemd/system/traccar.service.d/
sudo touch /etc/systemd/system/traccar.service.d/run-as-user.conf
sudo useradd traccar
sudo su
cat <<EOF >> /etc/systemd/system/traccar.service.d/run-as-user.conf
[Service]
User=traccar
Group=traccar
EOF
sudo systemctl daemon-reload
sudo systemctl start traccar
```
