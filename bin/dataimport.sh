#!/bin/sh

JDBC_IMPORTER_HOME=/data-importer
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib
echo '{
    "type" : "jdbc",
    "jdbc" : {
	"schedule" : "0 0/2 * * * ?",
        "statefile" : "statefile.json",
        "url" : "jdbc:jtds:sqlserver://alpha-sql:1433;databasename=dMongoVexiere;",
        "user" : "vexiere",
        "password" : "xsw2XSW@",
        "sql" :[
            {
                "statement" : "select *, id as _id from AuditLog where TimeStamp > ?",
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
             "host" : "192.168.2.220",
             "port" : 9300
        }
    }
}' | java \
       -cp "${lib}/*" \
       -Dlog4j.configurationFile=${bin}/log4j2.xml \
       org.xbib.tools.Runner \
       org.xbib.tools.JDBCImporter
