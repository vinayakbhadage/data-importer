# Import data from MSSQL into Elasticsearch  #

**Prerequisite:**

1. Ubuntu 14.04
2. Install [Docker Host](https://docs.docker.com/installation/ubuntulinux/)
3. Install [elasticsearch](https://registry.hub.docker.com/_/elasticsearch/) 
	
		docker run -d -p 9200:9200 -p 9300:9300 elasticsearch 

4. Install [Kibana](http://git.tavisca.com/vbhadage/docker-kibana)
	1. check out 
	
			git clone http://git.tavisca.com/vbhadage/docker-kibana.git

	2. Build the image

			git build -t doker-kibana .

	3. Run the kibana with Elastic search image

			docker run -d -e ELASTICSEARCH_PORT_9200_TCP_ADDR=***your-ES-IP-or-host-name** -p 5601:5601 docker-kibana
	




**Step 1:** Check out the docker file from **git.tavisca.com**

	git clone http://git.tavisca.com/vbhadage/data-importer.git


**Step 2:** Build the images from Dockerfile

	docker build -t data-importer .

**Step 3:** Run the data-importer by setting following parameter 


 1. **LAST_EXECUTION_START**="2014-06-06T09:08:00.948Z"
    
	This data time used to import the data from MS-SQL audit log table. 
 All records in auditlog table with timestamp greater than this will be imported in Elastic search.

 2. **INDEX_NAME**=** Provide the value **

This one is index name for elasticsearch.

 3. **CLUSTER**=** Provide the value **
 
Provide the elasticsearch cluster name.

 4. **ES_HOST**=** Provide the value **
 
 Provide the elastic search host name or IP address.

 5. **ES_PORT**="9300"

 Provide the elastic search host port number.

 6. **SCHEDULE**="0 0/10 * * * ?"

Default interval for data-importer is 10 min. this is [Quartz cron trigger](http://www.quartz-scheduler.org/documentation/quartz-1.x/tutorials/crontrigger) syntax. 
 
 7. **SQL_SERVER_HOST**="Provide the value"

It should be sql server database IP or hostname.

 8. **DB_NAME**="Provide the value"

It should be sql server database name.


 9. **DB_USER_NAME**="Provide the value"
 
It should be sql server user name, here server authentication is required.

 10. **DB_PASSWORD**="Provide the value"

It should be sql server user password, here server authentication is required.

**Note:** Please change the environment variable as per your requirement

		docker run -d --name data-importer -e LAST_EXECUTION_START="2014-06-06T09:08:00.948Z" \
		  -e INDEX_NAME="vexiereauditlog3.2"  -e CLUSTER="elasticsearch" -e ES_HOST="192.168.2.220" \
		  -e ES_PORT="9300" -e SCHEDULE="0 0/10 * * * ?" -e SQL_SERVER_HOST="alpha-sql" \
		  -e DB_NAME="dMongoVexiere" -e DB_USER_NAME="vexiere" -e DB_PASSWORD="find-out" data-importer