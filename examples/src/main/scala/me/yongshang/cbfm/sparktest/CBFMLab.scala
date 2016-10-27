package me.yongshang.cbfm.sparktest

import org.apache.spark.sql.SparkSession
/**
  * Created by yongshangwu on 2016/10/27.
  */
object CBFMLab {
  val spark = SparkSession
    .builder
    .appName("CBFM Test")
    .getOrCreate
  import spark.implicits._
  def main(args: Array[String]) {
    val persons = Seq(Person("Jack", 21, 1000), Person("Jason", 35, 5000)).toDF
    persons.show()
    persons.createOrReplaceTempView("persons")
    val results = spark.sql("SELECT * FROM persons where name='Jack' and age=21")
    results.show()
    persons.write.save("persons.parquet")
  }
}

case class Person(name: String, age: Int, balance: Double)