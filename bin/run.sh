#!/bin/bash

set -m
CONFIG_FILE="/data-importer/bin/dataimport.sh"

if [ "${SCHEDULE}" != "0 0/10 * * * ?" ]; then
   sed -i "/schedule/ c   \"schedule\" : \"${SCHEDULE}\"," ${CONFIG_FILE}
   echo "schedule is : "${SCHEDULE}
fi

if [ "${SQL_SERVER_HOST}" != "**NONE**" ] && [ "${DB_NAME}" != "**NONE**" ]; then
   sed -i "/url/ c   \"url\" : \"jdbc:jtds:sqlserver://${SQL_SERVER_HOST}:1433;databasename=${DB_NAME};\"," ${CONFIG_FILE}
   echo "database host is "${SQL_SERVER_HOST} " and  name is " ${DB_NAME} 
else
  echo "Please provide the sql server host name and db name"
fi

if [ "${DB_USER_NAME}" != "**NONE**" ]; then
   sed -i "/user/ c   \"user\" : \"${DB_USER_NAME}\"," ${CONFIG_FILE}
   echo "user name " ${DB_USER_NAME}
else
  echo "Please provide the db user name"
fi

if [ "${DB_PASSWORD}" != "**NONE**" ]; then
   sed -i "/password/ c   \"password\" : \"${DB_PASSWORD}\"," ${CONFIG_FILE}
   echo " Db password "
else
  echo "Please provide the db password"
fi

if [ "${LAST_EXECUTION_START}" != "2014-07-06T09:08:00.948Z" ]; then
   sed -i "/\"lastexecutionstart/ c   \"lastexecutionstart\" : \"${LAST_EXECUTION_START}\"" ${CONFIG_FILE}
   echo "last excecution date time " ${LAST_EXECUTION_START}
else
  echo "Please provide the db LAST_EXECUTION_START in this format 2014-07-06T09:08:00.948Z"
fi

if [ "${INDEX_NAME}" != "**NONE**" ]; then
   sed -i "/index/ c   \"index\" : \"${INDEX_NAME}\"," ${CONFIG_FILE}
   echo "Index name is " ${INDEX_NAME}
else
  echo "Please provide the ES index name"
fi

if [ "${CLUSTER}" != "**NONE**" ]; then
   sed -i "/cluster/ c   \"cluster\" : \"${CLUSTER}\"," ${CONFIG_FILE}
   echo "cluster name is " ${CLUSTER}
else
  echo "Please provide the ES cluster name"
fi

if [ "${ES_HOST}" != "**NONE**" ]; then
   sed -i "/host/ c   \"host\" : \"${ES_HOST}\"," ${CONFIG_FILE}
   echo "ES Host name is " ${ES_HOST}
else
  echo "Please provide the ES host or IP name"
fi

if [ "${ES_PORT}" != "9300" ]; then
   sed -i "/\"port/ c   \"port\" : \"${ES_PORT}\"" ${CONFIG_FILE}
   echo "ES Port number is " ${ES_PORT} 
else
 sed -i "/\"port/ c   \"port\" : \"9300\"" ${CONFIG_FILE}
fi
echo "Data importer is started "
exec ${CONFIG_FILE}
