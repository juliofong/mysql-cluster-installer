#!/bin/bash 
# myc-install-step1.sh 
# Setup MySQL Cluster 7.3 - Step 1 
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
# on mgmt node 
################################################ 
# notes ########################################
# normal boot order 1 mgmt - 2 ndbd - 3 sqld 
# mgmt will connect to ndbd 
# mgmt will be connected to sqld (API) only after all ndbd status goes from 'starting' to 'stared' 
# 
# commands 
# mysqld stop ; mysqld stop ; /etc/init.d/mysql.server start 
# 
# ndb_mgm 
# ndb_mgm > mgm_node_id STOP 
# shell > ndb_mgmd -f config.ini --reload 
# ndb_mgm > ndbd_id RESTART 
# ndb_mgm > ndbd_id RESTART 
# 
# # # 
# when updating IP on mgmt 
# run in main mgmt 
# ndb_mgmd --initial --config-file=/var/lib/mysql-cluster/config.ini --configdir=/var/lib/mysql-cluster/ 
# ndb_mgmd -f /var/lib/mysql-cluster/config.ini --configdir=/var/lib/mysql-cluster/ 
# 
# edit /etc/my.cnf in all sql nodes 
# edit /var/lib/mysql-cluster/config.ini all node mgmt 
# edit /etc/hosts and /etc/sysconfig/network 
# # # 
# 
# 
# mysql --skip-secure-auth -u root -p 
# DELETE FROM mysql.user WHERE user='username' and host='hostname'; 
# FLUSH PRIVILEGES; 
# 
# # # 
# when adding new ndbd 
# root@ndbd > ndbd --initial 
# # # 
# 
# if sqld is not connected use 'mysqld stop ; mysqld stop ; /etc/init.d/mysql.server start 
# 
# when we add new ndb_mgm 
# edit config.ini to add new ndb_mgmd 
# ps aux | grep sql 
# kill -9 "ndb_mgm pid" 
# ndb_mgmd -f /var/lib/mysql-cluster/config.ini --configdir=/var/lib/mysql-cluster/ 
# if one of mgm is not starting, all node will wait for it 

# on nodemgmt
################################################ 
# install MGMT 

mkdir -p /tmp/mysql-mgm
cd /tmp/mysql-mgm
wget http://dev.mysql.com/get/Downloads/MySQL-Cluster-7.3/mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz  --limit-rate=5000k ;
cd /tmp/mysql-mgm
tar xvfz mysql-cluster-gpl-7.*.tar.gz
cd mysql-cluster-gpl-7.*
cp -dpRxf bin/ndb_mgm /usr/bin/
cp -dpRxf bin/ndb_mgmd /usr/bin/
chmod 755 /usr/bin/ndb_mg*

mkdir /var/lib/mysql-cluster
chown -R mysql:mysql /var/lib/mysql-cluster

echo "
[NDBD DEFAULT]
NoOfReplicas=2
DataMemory=100M
IndexMemory=20M
[MYSQLD DEFAULT]

[NDB_MGMD DEFAULT]
DataDir=/var/lib/mysql-cluster

[TCP DEFAULT]

# Section for the cluster management node
[NDB_MGMD]
# IP addr of the management node 
HostName=192.168.122.21
Id=1

[NDB_MGMD]
HostName=192.168.122.22
Id=2

# Section for the storage nodes
[NDBD]
# IP addr of the first storage node
HostName=192.168.122.23
DataDir= /var/lib/mysql-cluster
Id=3

[NDBD]
HostName=192.168.122.24
DataDir= /var/lib/mysql-cluster
Id=4

# one [MYSQLD] per storage node
[MYSQLD]
HostName=192.168.122.25
Id=5

# one [MYSQLD] per storage node                                                 
[MYSQLD]                                                                        
HostName=192.168.122.26
Id=6
" > /var/lib/mysql-cluster/config.ini

# cp /mysql.bak/config.ini /var/lib/mysql-cluster/config.ini



# make sure 'ping localhost' is working
# nano /etc/hosts

# start mysql management 
# to initiate or if ip changed
sudo ndb_mgmd --initial --config-file=/var/lib/mysql-cluster/config.ini --configdir=/var/lib/mysql-cluster/ 
sudo ndb_mgmd -f /var/lib/mysql-cluster/config.ini --configdir=/var/lib/mysql-cluster/

ps aux | grep sql

# check for other nodes 
ndb_mgm -e show 

# add startup script 
echo ' 
#!/bin/bash 
# chkconfig: 2345 95 20 
ndb_mgmd -f /var/lib/mysql-cluster/config.ini --configdir=/var/lib/mysql-cluster/ 
' > /etc/init.d/ndb_mgmd 
chmod 755 /etc/init.d/ndb_mgmd 
chkconfig --add ndb_mgmd 



exit
