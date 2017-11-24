package com.lti.demo;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.sql.*;

import java.util.Date;

/** An example how to filter and search through PDB header information.
 *
 * Follow the download instructions on dataframes.rcsb.org for how to access the underlying dataframes.
 *
 * Created by andreas on 8/31/16.
 */
public class DemoSparkJava {



    public static void main(String[] args){

        String inputPath = args[0]; // "D:\\ApacheZeppelin\\bank\\bank-full.csv";
        String outputPath = args[1]; //"D:\\ApacheZeppelin\\bank\\bank-full";

        //assuming parquet file
        int cores = Runtime.getRuntime().availableProcessors();


        SparkSession spark = SparkSession
                .builder()
                .appName("Java Spark SQL basic example")
                //.master("local["+ cores+"]")
                .config("spark.ui.enabled",false)
                .getOrCreate();

        System.out.printf("Started processing job : %s%n", new Date().toString());
        Dataset<Row> structureSummary =  spark.read()
                .format("csv")
                .option("inferSchema", "true")
                .option("header", "true")
                .option("delimiter",";")
                .load(inputPath);

        structureSummary.show();

        structureSummary.printSchema();

        structureSummary.write().mode(SaveMode.Overwrite).format("csv")
                .option("header", "true")
                .option("delimiter","\t").save(outputPath);
        System.out.printf("Completed processing job : %s%n", new Date().toString());
        //spark.stop();

    }
}
