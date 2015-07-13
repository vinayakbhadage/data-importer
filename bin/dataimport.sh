#!/bin/sh

JDBC_IMPORTER_HOME=/data-importer
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib
echo '{
    "type" : "jdbc",
    "jdbc" : {
	"schedule" : "0 0/2 * * * ?",
        "statefile" : "statefile.json",
        "url" : "jdbc:jtds:sqlserver://dbserver:1433;databasename=dbname;",
        "user" : "myuser",
        "password" : "find-out",
        "sql" :[
            {
                "statement" : "select *, id as _id from Logtable where TimeStamp > ?",
                "parameter" : [ "$metrics.lastexecutionstart" ]
            }
        ],
        "metrics" : {
       		"lastexecutionend" : "2014-07-06T09:08:06.076Z",
      		"counter" : "1",
     		"lastexecutionstart" : "2014-07-06T09:08:00.948Z"
   	 },
	"index" : "vexierelog3.2",
        "type" : "auditlog",
	"elasticsearch" : {
             "cluster" : "elasticsearch",
             "host" : "myeshost",
             "port" : 9300
        }
    }
}' | java \
       -cp "${lib}/*" \
       -Dlog4j.configurationFile=${bin}/log4j2.xml \
       org.xbib.tools.Runner \
       org.xbib.tools.JDBCImporter
