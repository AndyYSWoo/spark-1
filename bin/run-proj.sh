# use index: cbfm, mdbf, cmdbf
index="cmdbf"
dataset="tpch"
# path def
hdfs_header="hdfs://server1:9000"
app_jar_file="/Users/yongshangwu/work/TestOnSpark/target/sparktest-1.0-SNAPSHOT.jar"
data_source_folder="$hdfs_header/data/tpch/skew/sf25/"
# record_dir="/record/$index/$(date +%Y%m%d-%H%M%S)/"
record_dir="/record/$index/"
parquet_dir="$hdfs_header/parquet/$dataset/$index/"	
# create result record dir, delete first in case
/opt/hadoop-2.7.2/bin/hadoop fs -rm -r -f $record_dir
/opt/hadoop-2.7.2/bin/hadoop fs -mkdir -p $record_dir
record_dir="$hdfs_header$record_dir"
# build project
# cd /Users/yongshangwu/work/TestOnSpark		
# mvn package
# submit to spark
cd /Users/yongshangwu/work/spark-latest/dist
# delete parquet file
# /opt/hadoop-2.7.2/bin/hadoop fs -rm -r -f "$parquet_dir*"
# ./bin/spark-submit --class me.yongshang.cbfm.sparktest.SparkTest --master local $app_jar_file
#./bin/spark-submit --class me.yongshang.cbfm.sparktest.DataGenerator --master local $app_jar_file
# ./bin/spark-submit --class me.yongshang.cbfm.sparktest.QueryTest --master local[*] --files ./conf/spark-defaults.conf $app_jar_file $data_source_folder $record_dir $index
# ./bin/spark-submit --class me.yongshang.cbfm.sparktest.TpchQuery --master local --deploy-mode client --files ./conf/spark-defaults.conf $app_jar_file $data_source_folder $record_dir $index $parquet_dir

./bin/spark-submit --class me.yongshang.cbfm.sparktest.TpchQuery --master spark://server1:7077 --deploy-mode client --files ./conf/spark-defaults.conf $app_jar_file $data_source_folder $record_dir $index $parquet_dir
# ./bin/spark-submit --class me.yongshang.cbfm.sparktest.TpchQueryNorm --master spark://server1:7077 --deploy-mode client --files ./conf/spark-defaults.conf $app_jar_file $data_source_folder $record_dir $index $parquet_dir
# ./bin/spark-submit --class me.yongshang.cbfm.sparktest.DnsQuery --master spark://server1:7077 --deploy-mode client --files ./conf/spark-defaults.conf $app_jar_file $record_dir $index $parquet_dir
