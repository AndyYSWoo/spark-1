# use index: cbfm, mdbf, cmdbf
index="cbfm"
# path def
app_jar_file="/Users/yongshangwu/work/TestOnSpark/target/sparktest-1.0-SNAPSHOT.jar"
data_source_folder="/Users/yongshangwu/Downloads/tpch_2_17_0/dbgen/"
record_dir="/Users/yongshangwu/work/result/$index/$(date +%Y%m%d-%H%M%S)/"
# create result record dir, delete first in case
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
# ./bin/spark-submit --class me.yongshang.cbfm.sparktest.QueryTest --master local[*] --files ./conf/spark-defaults.conf $app_jar_file $data_source_folder $record_dir $index
./bin/spark-submit --class me.yongshang.cbfm.sparktest.TpchQuery --master local --files ./conf/spark-defaults.conf $app_jar_file $data_source_folder $record_dir $index
