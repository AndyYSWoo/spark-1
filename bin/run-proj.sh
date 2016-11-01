# build project
cd /Users/yongshangwu/work/TestOnSpark
mvn package
# submit to spark
cd /Users/yongshangwu/work/spark-latest/dist
rm -rf persons.parquet
export SPARK_HOME = "/Users/yongshangwu/work/spark-latest/dist"
./bin/spark-submit --class me.yongshang.cbfm.sparktest.SparkTest --master local /Users/yongshangwu/work/TestOnSpark/target/sparktest-1.0-SNAPSHOT.jar