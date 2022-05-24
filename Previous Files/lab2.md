# Guia para o Lab2


## Instalar nagios na máquina b

### Step 1 - Pre requisites
- `sudo apt update && upgrade`
- `sudo apt install -y build-essential apache2 php openssl perl make php-gd libgd-dev libapache2-mod-php libperl-dev libssl-dev daemon wget apache2-utils unzip`
### Step 2 - Create account
- `sudo useradd nagios`
- `sudo groupadd nagcmd`
- `sudo usermod -a -G nagcmd nagios`
- `sudo usermod -a -G nagcmd www-data`
### Step 3 - Download Nagios From official Website
- `cd /tmp`
- `wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.5.tar.gz`
- `tar -zxvf /tmp/nagios-4.4.5.tar.gz`
- `cd /tmp/nagios-4.4.5/`
- `sudo ./configure --with-nagios-group=nagios --with-command-group=nagcmd --with-httpd_conf=/etc/apache2/sites-enabled/`
- `sudo make all`
- `sudo make install`
- `sudo make install-init`
- `sudo make install-config`
- `sudo make install-commandmode`

### Step 5 - Update your email address


### Step 6 - Fire up the web interface installer


- `sudo make install-webconf`
- `sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users`
- `sudo a2enmod cgi`
- `sudo systemctl restart apache2`

### Step 7 - Install Nagios Plugins

- `cd /tmp`
- `wget https://nagios-plugins.org/download/nagios-plugins-2.3.3.tar.gz`
- `tar -zxvf /tmp/nagios-plugins-2.3.3.tar.gz`
- `cd /tmp/nagios-plugins-2.3.3/`
- `sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios`
- `sudo make`
- `sudo make install`

### Step 8 - Using Nagios on Ubuntu

- `sudo /usr/local/nagios/bin/nagios -v`
- `cd /usr/local/nagios/etc/nagios.cfg`
- `sudo systemctl enable nagios`
- `sudo systemctl start Nagios`
