#!/bin/bash 
# myc-uninstall.sh 
# Uninstall MySQL Cluster  
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

# uninstall mysql 
ps aux | grep sql ; 
killall mysql; killall mysql_safe; killall mysqld ndb_mgmd; 

# backup config files 
mkdir /mysql.bak 
"yes" | cp -rf /etc/my.cnf /mysql.bak/my.cnf 
"yes" | cp -rf /var/lib/mysql-cluster/config.ini /mysql.bak/config.ini 

# important 
rm -rf /etc/my.cnf 
 
rm -rf /tmp/mysql-mgm/mysql-*-linux-glibc2.5-x86_64 
rm -rf /usr/local/mysql-*-linux-glibc2.5-x86_64 
 
rm -rf /root/.mysql_history 
 
rm -rf /var/lib/mysql-cluster 
rm -rf /usr/local/mysql 
rm -rf /usr/local/mysql-cluster-gpl-7.3.3-linux-glibc2.5-x86_64 
rm -rf /usr/bin/mysql
rm -rf /usr/lib64/mysql
rm -rf /usr/share/mysql
rm -rf /var/spool/mail/mysql
rm -rf /var/lock/subsys/mysql
rm -rf /var/log/mysql
rm -rf /var/lib/mysql-cluster

rm -rf /etc/rc.d/init.d/ndb_mgmd
rm -rf /usr/bin/ndb_setup.py
rm -rf /usr/bin/ndb_mgm
rm -rf /usr/bin/ndb_redo_log_reader
rm -rf /usr/bin/ndb_drop_index
rm -rf /usr/bin/ndb_delete_all
rm -rf /usr/bin/ndb_drop_table
rm -rf /usr/bin/ndb_error_reporter
rm -rf /usr/bin/ndb_mgmd
rm -rf /usr/bin/ndb_print_schema_file
rm -rf /usr/bin/ndb_select_all
rm -rf /usr/bin/ndb_waiter
rm -rf /usr/bin/ndb_blob_tool
rm -rf /usr/bin/ndb_select_count
rm -rf /usr/bin/ndb_show_tables
rm -rf /usr/bin/ndb_restore
rm -rf /usr/bin/ndb_print_sys_file
rm -rf /usr/bin/ndb_move_data
rm -rf /usr/bin/ndb_desc
rm -rf /usr/bin/ndb_index_stat
rm -rf /usr/bin/ndb_print_backup_file
rm -rf /usr/bin/ndb_print_file
rm -rf /usr/bin/ndb_size.pl
rm -rf /usr/bin/ndb_config

rm -rf /usr/bin/mysqltest_embedded
rm -rf /usr/bin/mysqld_safe
rm -rf /usr/bin/mysql_config_editor
rm -rf /usr/bin/mysql_plugin
rm -rf /usr/bin/mysqlbug
rm -rf /usr/bin/mysqlcheck
rm -rf /usr/bin/mysql_fix_extensions
rm -rf /usr/bin/mysqlshow
rm -rf /usr/bin/mysqltest
rm -rf /usr/bin/mysqlhotcopy
rm -rf /usr/bin/mysql_secure_installation
rm -rf /usr/bin/mysqld
rm -rf /usr/bin/mysql_setpermission
rm -rf /usr/bin/mysql_waitpid
rm -rf /usr/bin/mysqld-debug
rm -rf /usr/bin/mysqlbinlog
rm -rf /usr/bin/mysqlslap
rm -rf /usr/bin/mysqlaccess
rm -rf /usr/bin/mysqlaccess.conf
rm -rf /usr/bin/mysqlimport
rm -rf /usr/bin/mysql_embedded
rm -rf /usr/bin/mysqld_multi
rm -rf /usr/bin/mysql_find_rows
rm -rf /usr/bin/mysql_upgrade
rm -rf /usr/bin/mysql_config
rm -rf /usr/bin/mysqldump
rm -rf /usr/bin/mysql_convert_table_format
rm -rf /usr/bin/mysqldumpslow
rm -rf /usr/bin/mysqladmin
rm -rf /usr/bin/mysql_client_test_embedded
rm -rf /usr/bin/mysql_zap
rm -rf /usr/bin/mysql_tzinfo_to_sql
rm -rf /usr/bin/mysql_client_test
rm -rf /usr/share/man/man5/mysql_table.5.gz
rm -rf /usr/share/man/man8/mysqlmanagerd_selinux.8.gz
rm -rf /usr/share/man/man8/mysqld_selinux.8.gz
rm -rf /usr/share/selinux/targeted/mysql.pp.bz2
rm -rf /usr/share/selinux/devel/include/services/mysql.if
rm -rf /usr/share/doc/mysql-libs-5.1.67
rm -rf /etc/selinux/targeted/modules/active/modules/mysql.pp
rm -rf /etc/rc.d/init.d/mysql.server
rm -rf /usr/share/selinux/targeted/mysql.pp.bz2
rm -rf /usr/share/selinux/devel/include/services/mysql.if

unlink /usr/local/mysql

reboot
