#!/bin/bash
find /var/lib/mysql -type f -exec touch {} \; && service mysql start
sudo -H -u postgres bash -c '/usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf'