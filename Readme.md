# Import data from MS sql Server into Elasticsearch 1.6#

**Problem:**

Need to provide the analytics and visualization for audit log data which is stored in relational database. 
 
**Solution**

one of the solution to this problem is to visualize the data in open source tool like [kibana](https://www.elastic.co/products/kibana). But kibana uses the [elasticsearch](https://www.elastic.co/products/elasticsearch) for search and storage purpose.

So that need to import selected records from relational database into the elasticsearch 1.6. The new index will be created in elasticsearch for this data and it will be used by kibana.

Prior to elasticsearch 1.6 the [river plugin](https://www.elastic.co/blog/deprecating-rivers) was available for this purpose but it is now deprecated.

But to solve the same problem another standalone java utility known as [elasticsearch - jdbc](https://github.com/jprante/elasticsearch-jdbc) is available. 

Here I am going to tell you how to use this utility through [docker](https://www.docker.com/) so whenever you need it. it would be only three steps process for you i.e clone it, build image and start the container with parameter. 



**Prerequisite:**

1. Ubuntu 14.04
2. Install [Docker Host](https://docs.docker.com/installation/ubuntulinux/)
3. Install [elasticsearch](https://registry.hub.docker.com/_/elasticsearch/) 
	
		docker run -d -p 9200:9200 -p 9300:9300 elasticsearch 

4. Install [Kibana](https://www.elastic.co/products/kibana)



**Step 1:** Check out the docker file [https://github.com/vinayakbhadage/data-importer](https://github.com/vinayakbhadage/data-importer)

	git clone https://github.com/vinayakbhadage/data-importer.git

**Step 2**: Change the required parameter from this file **dataimport.sh** as mentioned [here](https://github.com/jprante/elasticsearch-jdbc)

**Step 3:** Build the images from Dockerfile

	docker build -t data-importer .

**Step 4:** Run the data-importer by setting following parameter 


 1. **LAST_EXECUTION_START**="2014-06-06T09:08:00.948Z"
    
	This data time used to import the data from MS-SQL audit log table. All records in auditlog table with timestamp greater than this will be imported in Elastic search.

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
		  -e INDEX_NAME="myindex"  -e CLUSTER="elasticsearch" -e ES_HOST="myeshost" \
		  -e ES_PORT="9300" -e SCHEDULE="0 0/10 * * * ?" -e SQL_SERVER_HOST="mydb" \
		  -e DB_NAME="mydb" -e DB_USER_NAME="myuser" -e DB_PASSWORD="find-out" data-importer



	Lastly checkout the status of elasticsearch index then you can find data over there.





