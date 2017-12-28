#How to import data from MS SQL Server into Elasticsearch 1.6#

**Problem:**

Need to provide the analytics and visualization for audit log data which is stored in relational database. 
 
**Solution**

One of the solution to this problem is to visualize the data in open source tool like <a  target="_blank" href="https://www.elastic.co/products/kibana">kibana </a>. But kibana uses the <a  target="_blank" href="https://www.elastic.co/products/elasticsearch">elasticsearch</a> for search and storage purpose.

So that need to import selected records from relational database into the elasticsearch 1.6. The new index will be created in elasticsearch for this data and it will be used by kibana.

Prior to elasticsearch 1.6 the <a  target="_blank" href="https://www.elastic.co/blog/deprecating-rivers">river plugin</a> was available for this purpose but it is now deprecated.

But to solve the same problem another standalone java utility known as <a  target="_blank" href="https://github.com/jprante/elasticsearch-jdbc">elasticsearch - jdbc</a> is available. 

Here I am going to tell you how to use this utility through <a  target="_blank" href="https://www.docker.com/">docker</a> so whenever you need it. it would be only three steps process for you i.e clone it, build image and start the container with parameter. 



**Prerequisite:**

1. Ubuntu 14.04
2. Install <a  target="_blank" href="https://docs.docker.com/installation/ubuntulinux/">Docker Host</a>
3. Install <a  target="_blank" href="https://registry.hub.docker.com/_/elasticsearch/">elasticsearch</a> 
	
		docker run -d -p 9200:9200 -p 9300:9300 elasticsearch 

4. Install <a  target="_blank" href="https://www.elastic.co/products/kibana">Kibana</a>



**Step 1:** Check out the docker file <a  target="_blank" href="https://github.com/vinayakbhadage/data-importer">https://github.com/vinayakbhadage/data-importer</a>

	git clone https://github.com/vinayakbhadage/data-importer.git

**Step 2**: Change the required parameter from this file **dataimport.sh** as mentioned <a  target="_blank" href="https://github.com/jprante/elasticsearch-jdbc">here</a>

**Step 3:** Build the images from Dockerfile

	docker build -t data-importer .

**Step 4:** Run the data-importer by setting following parameter 



1.**LAST_EXECUTION_START**="2014-06-06T09:08:00.948Z"
    
This date time used to import the data from the log table of your database. All records in that table with timestamp column value greater than this will be imported in Elastic search.

2.**INDEX_NAME**=** Provide the value **
 
This one is index name for elasticsearch.

3.**CLUSTER**=** Provide the value **
 	
Provide the elasticsearch cluster name.

4.**ES_HOST**=** Provide the value **
 
Provide the elastic search host name or IP address.

5.**ES_PORT**="9300"

Provide the elastic search host port number.

6.**SCHEDULE**="0 0/10 * * * ?"

Default interval for data-importer is 10 min. this is <a  target="_blank" href="http://www.quartz-scheduler.org/documentation/quartz-1.x/tutorials/crontrigger">Quartz cron trigger</a> syntax. 
 
7.**SQL_SERVER_HOST**="Provide the value"

It should be sql server database IP or hostname.

8.**DB_NAME**="Provide the value"

It should be sql server database name.


9.**DB_USER_NAME**="Provide the value"
 
It should be sql server user name, here server authentication is required.

10.**DB_PASSWORD**="Provide the value"

It should be sql server user password, here server authentication is required.

**Note:** Please change the environment variable as per your requirement

	docker run -d --name data-importer -e LAST_EXECUTION_START="2014-06-06T09:08:00.948Z" \
	  -e INDEX_NAME="myindex"  -e CLUSTER="elasticsearch" -e ES_HOST="myeshost" \
	  -e ES_PORT="9300" -e SCHEDULE="0 0/10 * * * ?" -e SQL_SERVER_HOST="mydb" \
	  -e DB_NAME="mydb" -e DB_USER_NAME="myuser" -e DB_PASSWORD="find-out" data-importer



Lastly checkout the status of elasticsearch index then you can find data over there.

E-J10-VINAYAK#1465026-2018.01.08-10-ybqa49xci33x3#bbb6bb



