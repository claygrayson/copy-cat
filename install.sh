Setup Key-based Login for root
--------------
# ssh-keygen -t rsa
# vi ~/.ssh/authorized_keys
-----
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChdOTJQAkX5YIdnjKXuJQsovXM5x8N0kVIZ2+lMnJ1RVWW6bJUaAC2ypiwuE5DdBwsCEQ+QfOklInDyc+mdLWh2cfjdO3sUI90ApfpJFR1zIgS+DC3hwXRyzlMj6XdfT/pYsAMpFK7md0dljnz9ilIR5VVEDQWfDVfFTtpRLrOlebLc2J3zDN89Od6MmZvzCREfp0CXl2T7zQoKYt0dED2kuQvTc4fCcoIXQd+N9RSUKeBOjJUoV0pDJTeaNK15ESdFHUB13Va4EgvlXzbhhQxQdqcGIAWXVzapqmVlY1IrTMtJMmt0lN8HY6rNZtvJ51FbZR1iFXXJBJdrdO7XHhd chad.cravens@ossys.com
-----
# chmod 700 ~/.ssh/
# chmod 600 ~/.ssh/authorized_keys





Setup Users
--------------
# useradd ccravens
# su ccravens
$ cd
$ ssh-keygen -t rsa
$ vi ~/.ssh/authorized_keys
-----
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChdOTJQAkX5YIdnjKXuJQsovXM5x8N0kVIZ2+lMnJ1RVWW6bJUaAC2ypiwuE5DdBwsCEQ+QfOklInDyc+mdLWh2cfjdO3sUI90ApfpJFR1zIgS+DC3hwXRyzlMj6XdfT/pYsAMpFK7md0dljnz9ilIR5VVEDQWfDVfFTtpRLrOlebLc2J3zDN89Od6MmZvzCREfp0CXl2T7zQoKYt0dED2kuQvTc4fCcoIXQd+N9RSUKeBOjJUoV0pDJTeaNK15ESdFHUB13Va4EgvlXzbhhQxQdqcGIAWXVzapqmVlY1IrTMtJMmt0lN8HY6rNZtvJ51FbZR1iFXXJBJdrdO7XHhd chad.cravens@ossys.com
-----
$ chmod 700 ~/.ssh/
$ chmod 600 ~/.ssh/authorized_keys
$ exit

# useradd git
# su git
$ cd
******* On Chad's Mac *******
scp /Users/ccravens/Business/ossys/Clients/GraysonThomas/copy-cat.io/id_rsa /Users/ccravens/Business/ossys/Clients/GraysonThomas/copy-cat.io/id_rsa.pub root@copy-cat.io:/home/git/.ssh
$ exit
# chown git:git /home/git/.ssh/id_rsa /home/git/.ssh/id_rsa.pub
# su git
$ cd
$ chmod 600 /home/git/.ssh/id_rsa
$ chmod 644 /home/git/.ssh/id_rsa.pub
$ vi ~/.ssh/authorized_keys
-----
ssh-dss AAAAB3NzaC1kc3MAAACBAJDB46iQQsQWBuXRfyPSj09K8jiK1aYxFsyZ/fgmkSQjLGgYr9hn+WVLAZyD3oaKM3EJ01wO21ujJjaoimiBgUDMYJewLs3Di6HPgcowbJ5zv1hID+PJS5FqT8BtpitWGlLzw3s0fbUbOq04/MmU7qw7QOjrDffi0XLYY1DNY86TAAAAFQDeXCbgJAlfw7whUUT7AxLFUOOagwAAAIBBVlz7VBKhM1M2DlhTeIU1WZbg9d649dTjdeluvV6M8lAHVNFi7Tqy0jGymkY34EeVP17MRSnQX/cA0eJ0kQe/ZfWMi+5PMktM2Bb1D/SbrD6oVbMkkKrV/OVJoXvHJ/RUusxN1Sk0mFSRwnpL82Rw13X4JTiYRaLwB00Y8dazCwAAAIBzv+fzyr50WG5zPsYXA8Xc8+7GneQbCACNHnJP4/yit/NplrKzLicGVeiR+cecu3qrqxOdiyaSIz868c8Dnk2bNEIZStY0Aytau91ERiDrOyPjvxYSOPRzWZAdmpL2V60JROZcEFvU0tfmv3Iot5iyTWIJY+t5JBCPdffSQBS8Ng== tomcat@dev.ossys.com
-----
$ chmod 700 ~/.ssh/
$ chmod 600 ~/.ssh/authorized_keys
$ exit

# vi /etc/ssh/sshd_config
=========================
Match User ccravens,git
PasswordAuthentication no
=========================







******* On Chad's Mac *******
Generate CSR For SSL Key
# cd
# openssl req -new -newkey rsa:2048 -nodes -keyout copycat.key -out copycat.csr
# cat copycat.crt copycat_bundle.crt > copycat_chained.crt
scp /Users/ccravens/Business/ossys/Clients/GraysonThomas/copy-cat.io/copycat.key /Users/ccravens/Business/ossys/Clients/GraysonThomas/copy-cat.io/copycat_chained.crt root@copy-cat.io:/root
*******



Move Certificates to PKI Location
--------------
# mv /root/copycat.key /etc/pki/tls/private/
# mv /root/copycat_chained.crt /etc/pki/tls/
--------------




Install Required Packages
---------------
# vi /etc/yum.repos.d/mongodb-org-3.0.repo
======================
[mongodb-org-3.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.0/x86_64/
gpgcheck=0
enabled=1
======================
# yum install -y epel-release
# yum -y update
# yum install -y git gcc-c++ nginx mongodb-org krb5-devel ntp glibc.i686 libgcc.i686 zlib-devel readline-devel openssl-devel cmake libicu-devel


===== Node ======
# mkdir /usr/local/node && curl https://nodejs.org/dist/v4.4.3/node-v4.4.3.tar.gz | tar -xvz -C /usr/local/node
# cd /usr/local/node/node-v4.4.3 && ./configure && make && make install
# ln -s /usr/local/node/node-v4.4.3 /opt/node
# npm install -g pm2 bower gulp
# pm2 startup centos -u git && pm2 kill
# vi /etc/init.d/pm2-init.sh
=======================
[-] super $PM2 dump
[+] #super $PM2 dump
[-] export PM2_HOME="/root/.pm2"
[+] export PM2_HOME="/home/git/.pm2"
=======================











MongoDB Optimizations
(https://docs.mongodb.org/manual/tutorial/transparent-huge-pages/)
(https://docs.mongodb.org/manual/reference/ulimit/)
--------------------
# vi /etc/security/limits.d/20-nproc.conf
=======================
[-] *          soft    nproc     4096
[+] *          soft    nproc     32000
=======================
# vi /etc/init.d/disable-transparent-hugepages
========================
#!/bin/sh
### BEGIN INIT INFO
# Provides:          disable-transparent-hugepages
# Required-Start:    $local_fs
# Required-Stop:
# X-Start-Before:    mongod mongodb-mms-automation-agent
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Disable Linux transparent huge pages
# Description:       Disable Linux transparent huge pages, to improve
#                    database performance.
### END INIT INFO

case $1 in
  start)
    if [ -d /sys/kernel/mm/transparent_hugepage ]; then
      thp_path=/sys/kernel/mm/transparent_hugepage
    elif [ -d /sys/kernel/mm/redhat_transparent_hugepage ]; then
      thp_path=/sys/kernel/mm/redhat_transparent_hugepage
    else
      return 0
    fi

    echo 'never' > ${thp_path}/enabled
    echo 'never' > ${thp_path}/defrag

    unset thp_path
    ;;
esac
=========================
# chmod 755 /etc/init.d/disable-transparent-hugepages
# chkconfig --add disable-transparent-hugepages
# mkdir /etc/tuned/no-thp
# vi /etc/tuned/no-thp/tuned.conf
=========================
[main]
include=virtual-guest

[vm]
transparent_hugepages=never
==========================
# tuned-adm profile no-thp

### http://dochub.mongodb.org/core/readahead
# blockdev --setra 32 /dev/xvda










Set Server Timezone
--------------
# timedatectl set-timezone America/New_York
# systemctl start ntpd
# systemctl enable ntpd










Enable Swap File
--------------
# dd if=/dev/zero of=/mnt/swap bs=1024 count=33554432
# chmod 600 /mnt/swap
# mkswap /mnt/swap
# swapon /mnt/swap
# sh -c 'echo "/mnt/swap none swap sw 0 0" >> /etc/fstab'










Setup Nginx
----------------
# chkconfig nginx off
# chkconfig --level 2345 nginx on
# usermod -aG git nginx
# chmod 750 /home/git
# vi /etc/nginx/nginx.conf
======================
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    proxy_cache_path  /var/cache/nginx levels=1:2 keys_zone=one:8m max_size=3000m inactive=600m;
    proxy_temp_path /var/tmp;
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;

    gzip on;
    gzip_comp_level 6;
    gzip_vary on;
    gzip_min_length  1000;
    gzip_proxied any;
    gzip_types text/plain text/html text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;
    gzip_buffers 16 8k;

    server {
        listen			80;
        server_name		copy-cat.io www.copy-cat.io;

        if ($host != 'copy-cat.io' ) {
                rewrite  ^/(.*)$  https://copy-cat.io/$1  permanent;
        }

        return			301 https://$server_name$request_uri;
    }
 
    server {
        listen 443 ssl;

        ssl_certificate /etc/pki/tls/copycat_chained.crt;
        ssl_certificate_key /etc/pki/tls/private/copycat.key;
        ssl_protocols        SSLv3 TLSv1;
        ssl_ciphers HIGH:!aNULL:!MD5;
 
        server_name copy-cat.io www.copy-cat.io;
 
        if ($host != 'copy-cat.io' ) {
                rewrite  ^/(.*)$  https://copy-cat.io/$1  permanent;
        }

        error_page 502  /errors/502.html;

        location ~ ^/(images/|img/|javascript/|js/|css/|stylesheets/|flash/|media/|static/|robots.txt|humans.txt|favicon.ico) {
          root /home/git/copycat/public;
          access_log off;
          expires max;
        }

        location / {
          proxy_redirect off;
          proxy_set_header   X-Real-IP            $remote_addr;
          proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
          proxy_set_header   X-Forwarded-Proto $scheme;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header   Host                   $http_host;
          proxy_set_header   X-NginX-Proxy    true;
          proxy_set_header Connection 'upgrade';
          proxy_http_version 1.1;
          proxy_cache one;
          proxy_cache_key sfs$request_uri$scheme;
          proxy_pass         http://localhost:3000;
          proxy_set_header Host $host;
          proxy_cache_bypass $http_upgrade;
        }
    }
}
=====================
# service nginx start





Initializing MongoDB database
----------------
# chkconfig mongod off
# chkconfig mongod --level 2345 on
# service mongod start






Enable Firewall
----------------
# systemctl mask iptables
# firewall-cmd --state
# systemctl start firewalld
# firewall-cmd --state
# firewall-cmd --get-zones
# firewall-cmd --get-default-zone
# firewall-cmd --get-active-zones
# firewall-cmd --list-all
# ip link show
# ip addr show
# firewall-cmd --permanent --zone=internal --change-interface=eth0
# firewall-cmd --permanent --zone=public --change-interface=eth1
# firewall-cmd --permanent --add-service=ssh
# firewall-cmd --permanent --add-service=http
# firewall-cmd --permanent --add-service=https
# systemctl enable firewalld
# firewall-cmd --reload
# firewall-cmd --get-active-zones








Clone code
--------------
# su git
$ cd
$ cat ~/.ssh/id_rsa.pub
*** Add git public key to github account ***
$ git clone git@github.com:grayson-thomas/copycat.git









Create Repos Directory
--------------
$ mkdir ~/repos







Start Web Service
---------------
$ cd /home/git/copycat
$ git fetch
$ git rebase
$ rm -rf bower_components && rm -rf node_modules && bower install && npm install && gulp clean && gulp build
$ chmod +x /home/git/copycat/env.sh && /home/git/copycat/env.sh
$ pm2 start app.js --name "copycat"
$ pm2 save
$ exit
# chattr +i /home/git/.pm2/dump.pm2









Config Global Git
----------------
$ git config --global user.email "git@copy-cat.io"
$ git config --global user.name "copycat"






REBOOT
---------------
$ exit
# shutdown -h now -r






VERIFY Settings
--------------
# cat /sys/kernel/mm/transparent_hugepage/enabled
# cat /sys/kernel/mm/transparent_hugepage/defrag
====== Make sure output looks like =============
always madvise [never]
==========================

# firewall-cmd --get-active-zones
====== Make sure output looks like =============
internal
  interfaces: eth0
public
  interfaces: eth1
==========================

# mongo
====== Make sure output looks like =============
*** Make sure you get no warnings when running the mongo CLI
==========================
