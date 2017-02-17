# after compiling & packaging, organize files as release version
SPARK_HOME="$(cd "`dirname "$0"`/.."; pwd)"
DISTDIR="$SPARK_HOME/dist"

# Make directories
rm -rf "$DISTDIR"
mkdir -p "$DISTDIR/jars"
mkdir -p "$DISTDIR/assembly/target/scala-2.10/jars"

# Replace suitable jars
rm -f "$SPARK_HOME"/assembly/target/scala*/jars/parquet-common-1.8.1.jar
rm -f "$SPARK_HOME"/assembly/target/scala*/jars/parquet-encoding-1.8.1.jar
rm -f "$SPARK_HOME"/assembly/target/scala*/jars/parquet-column-1.8.1.jar
rm -f "$SPARK_HOME"/assembly/target/scala*/jars/parquet-hadoop-1.8.1.jar


cp ~/.m2/repository/org/apache/parquet/parquet-column/1.8.2-SNAPSHOT/parquet-column-1.8.2-SNAPSHOT.jar "$SPARK_HOME"/assembly/target/scala*/jars
cp ~/.m2/repository/org/apache/parquet/parquet-common/1.8.2-SNAPSHOT/parquet-common-1.8.2-SNAPSHOT.jar "$SPARK_HOME"/assembly/target/scala*/jars
cp ~/.m2/repository/org/apache/parquet/parquet-encoding/1.8.2-SNAPSHOT/parquet-encoding-1.8.2-SNAPSHOT.jar "$SPARK_HOME"/assembly/target/scala*/jars
cp ~/work/parquet-mr/parquet-hadoop/target/parquet-hadoop-1.8.2-SNAPSHOT.jar "$SPARK_HOME"/assembly/target/scala*/jars

# scp parquet-hadoop to serverss
scp ~/work/parquet-mr/parquet-hadoop/target/parquet-hadoop-1.8.2-SNAPSHOT.jar root@server1:/Users/yongshangwu/work/spark-latest/dist/assembly/target/scala-2.10/jars/
scp ~/work/parquet-mr/parquet-hadoop/target/parquet-hadoop-1.8.2-SNAPSHOT.jar root@server2:/Users/yongshangwu/work/spark-latest/dist/assembly/target/scala-2.10/jars/
scp ~/work/parquet-mr/parquet-hadoop/target/parquet-hadoop-1.8.2-SNAPSHOT.jar root@server3:/Users/yongshangwu/work/spark-latest/dist/assembly/target/scala-2.10/jars/
scp ~/work/parquet-mr/parquet-hadoop/target/parquet-hadoop-1.8.2-SNAPSHOT.jar root@server6:/Users/yongshangwu/work/spark-latest/dist/assembly/target/scala-2.10/jars/
scp ~/work/parquet-mr/parquet-hadoop/target/parquet-hadoop-1.8.2-SNAPSHOT.jar root@server7:/Users/yongshangwu/work/spark-latest/dist/assembly/target/scala-2.10/jars/

# Copy jars
cp "$SPARK_HOME"/assembly/target/scala*/jars/* "$DISTDIR/jars/"
cp "$SPARK_HOME"/assembly/target/scala*/jars/* "$DISTDIR/assembly/target/scala-2.10/jars"

# Copy examples and dependencies
mkdir -p "$DISTDIR/examples/jars"
cp "$SPARK_HOME"/examples/target/scala*/jars/* "$DISTDIR/examples/jars"

# Deduplicate jars that have already been packaged as part of the main Spark dependencies.
for f in "$DISTDIR/examples/jars/"*; do
  name=$(basename "$f")
  if [ -f "$DISTDIR/jars/$name" ]; then
    rm "$DISTDIR/examples/jars/$name"
  fi
done

# Copy example sources (needed for python and SQL)
mkdir -p "$DISTDIR/examples/src/main"
cp -r "$SPARK_HOME"/examples/src/main "$DISTDIR/examples/src/"

# Copy license and ASF files
cp "$SPARK_HOME/LICENSE" "$DISTDIR"
cp -r "$SPARK_HOME/licenses" "$DISTDIR"
cp "$SPARK_HOME/NOTICE" "$DISTDIR"

if [ -e "$SPARK_HOME"/CHANGES.txt ]; then
  cp "$SPARK_HOME/CHANGES.txt" "$DISTDIR"
fi

# Copy other things
mkdir "$DISTDIR"/conf
cp "$SPARK_HOME"/conf/* "$DISTDIR"/conf
cp "$SPARK_HOME/README.md" "$DISTDIR"
cp -r "$SPARK_HOME/bin" "$DISTDIR"
cp -r "$SPARK_HOME/python" "$DISTDIR"
cp -r "$SPARK_HOME/sbin" "$DISTDIR"

# Build project
cd /Users/yongshangwu/work/TestOnSpark
mvn package

# Transfer app jar, conf & run script
scp ~/work/TestOnSpark/target/sparktest-1.0-SNAPSHOT.jar yongshangwu@server1:/Users/yongshangwu/work/TestOnSpark/target/
scp ~/work/spark-latest/conf/spark-env.sh yongshangwu@server1:/Users/yongshangwu/work/spark-latest/dist/conf/
scp ~/work/spark-latest/conf/spark-defaults.conf yongshangwu@server1:/Users/yongshangwu/work/spark-latest/dist/conf/
scp ~/work/spark-latest/bin/run-proj.sh yongshangwu@server1:/Users/yongshangwu/work/spark-latest/dist/bin/		
