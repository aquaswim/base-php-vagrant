#! /bin/bash

#
# Author:   Bayu Setiawan <bayusetiawan37@gmail.com>
#

#
# Check the bash shell script is being run by root
#
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#
# Check input params
#
if [ -n "${1}" -a -n "${2}" ]; then
    # Change existing root password
    DB_NAME="${1}"
    DB_USER="${1}"
    DB_PASSWORD="${2}"
else
    echo "Usage:"
    echo "  Create new db with user with same name: ${0} 'db_name' 'password'"
    exit 1
fi

SQL=$( cat << _END_
DROP USER IF EXISTS ${DB_USER};
DROP DATABASE IF EXISTS ${DB_NAME};
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
USE ${DB_NAME};
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
FLUSH PRIVILEGES;
_END_
)

echo "${SQL}" | mysql -u root

echo "Database '${DB_NAME}' with password '${DB_PASSWORD}' created!";