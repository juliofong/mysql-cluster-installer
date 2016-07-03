#!/bin/bash 
# myc-install-step2.sh 
# Setup MySQL Cluster 7.3 - Step 2 
# 
# Please maintain the author name, some usage restrictions apply according to the GPL 
# Author: Julio FONG, juliofong@mail.com 
# Copyright (C) 2015 Julio FONG 
# 
# MySQL is the software of Oracle both a commercial license and GPL license. 
# 
# This program is free software: you can redistribute it and/or modify 
# it under the terms of the GNU General Public License as published by 
# the Free Software Foundation, either version 3 of the License, or 
# (at your option) any later version. 
# 
# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
# GNU General Public License for more details. 
# 
# You should have received a copy of the GNU General Public License 
# along with this program. If not, see <http://www.gnu.org/licenses/>. 



################################################ 
# on sqld node  
################################################ 
# install node1 - storage node 
groupadd mysql 
useradd -g mysql mysql 

cd /usr/local/ ; 
wget http://dev.mysql.com/get/Downloads/MySQL-Cluster-7.3/mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz --limit-rate=5000k ;
cd /usr/local/ ;
tar xvfz mysql-cluster-gpl-7.3.5-*.tar.gz ;
ln -s mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64 mysql ;
cd mysql ;
yum install perl -y ;
yum install libaio -y ;

# create the data directories
mkdir /var/log/mysql/
chown -R mysql:mysql /var/log/mysql/
mkdir /var/lib/mysql-cluster
chown -R mysql:mysql /var/lib/mysql-cluster
cd /var/lib/mysql-cluster
chmod 1777 /tmp
cd /usr/local/mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64/ ;
scripts/mysql_install_db --user=mysql --ldata=/usr/local/mysql/data/lib --socket=/usr/local/mysql/data --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --tmpdir=/tmp ;
touch /usr/local/mysql/data/mysql.sock ;
ln -s  /usr/local/mysql/data/mysql.sock /tmp/mysql.sock ;
rm -rf /tmp/mysql.sock ;
chown -R mysql:mysql . ;
chown -R mysql data ;
yes | cp -rf support-files/mysql.server /etc/init.d/ ; 
chmod 755 /etc/init.d/mysql.server ;
chkconfig mysql.server on ;
cd /usr/local/mysql/bin ;
mv * /usr/bin/ ;
cd ../ ;
rm -rf /usr/local/mysql/bin ;
ln -s /usr/bin /usr/local/mysql/bin ;
chown mysql:mysql /usr/local/mysql ; 
chown -R mysql:mysql /usr/local/mysql/* ;
 
# create conf files
echo "
[mysqld]
#innodb=OFF
#ignore-builtin-innodb
#skip-innodb
#default-storage-engine=myisam
#default-tmp-storage-engine=myisam
#default-storage-engine=ndbcluster
#default-tmp-storage-engine=myisam
datadir=/usr/local/mysql/data
[mysqld]
ndbcluster
ndb-connectstring='192.168.122.21,192.168.122.22'
[mysql_cluster]
ndb-connectstring='192.168.122.21,192.168.122.22'
" > /etc/my.cnf ;

exit
