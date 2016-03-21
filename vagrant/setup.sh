sudo yum update
sudo yum install http://repo.zabbix.com/zabbix/3.0/rhel/7/x86_64/zabbix-release-3.0-1.el7.noarch.rpm -y

# install
sudo yum install zabbix-server-mysql zabbix-web-mysql zabbix-web-japanese zabbix-agent -y
sudo yum install mariadb-server -y
sudo yum install vim -y


sudo vim /etc/my.cnf.d/server.cnf

#[mysqld]
#character-set-server = utf8
#collation-server     = utf8_bin
#skip-character-set-client-handshake
#innodb_file_per_table


sudo systemctl start mariadb
sudo systemctl enable mariadb

mysqladmin -u root password admin
mysql -uroot -p

zcat /usr/share/doc/zabbix-server-mysql-3.0.1/create.sql.gz | mysql -uroot -p zabbix
sudo vim  /etc/zabbix/zabbix_server.conf
# DBPassword=password

sudo vim /etc/httpd/conf.d/zabbix.conf
# php_value date.timezone Asia/Tokyo

sudo systemctl start zabbix-server
sudo systemctl start zabbix-agent
sudo systemctl start httpd
sudo systemctl enable zabbix-server
sudo systemctl enable zabbix-agent
sudo systemctl enable httpd
