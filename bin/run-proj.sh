# use index: cbfm, mdbf
index="cbfm"
# path def
app_jar_file="/Users/yongshangwu/work/TestOnSpark/target/sparktest-1.0-SNAPSHOT.jar"
data_source_folder="/Users/yongshangwu/Downloads/tpch_2_17_0/dbgen/"
record_dir="/Users/yongshangwu/work/result/"$index"/"
# recreate result record dir
rm -rf $record_dir
mkdir -p $record_dir
# build project
cd /Users/yongshangwu/work/TestOnSpark
mvn package
# submit to spark
cd /Users/yongshangwu/work/spark-latest/dist
export SPARK_HOME = "/Users/yongshangwu/work/spark-latest/dist"
# delete parquet file
rm -rf *.parquet
# ./bin/spark-submit --class me.yongshang.cbfm.sparktest.SparkTest --master local $app_jar_file
#./bin/spark-submit --class me.yongshang.cbfm.sparktest.DataGenerator --master local $app_jar_file
./bin/spark-submit --class me.yongshang.cbfm.sparktest.QueryTest --master local $app_jar_file $data_source_folder $record_dir $index
