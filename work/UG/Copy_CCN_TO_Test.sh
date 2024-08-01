#!/bin/bash

PIDFILE=/home/daasuser/PIDFiles/Copy_CCN_TO_Test_PID.pid
if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "Job is already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      echo "Could not create PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create PID file"
    exit 1
  fi
fi
date1=$1

hadoop fs -rm -r /user/daasuser/FlareData/Feeds/CCN_CDR_Detail_CS18_test1/tbl_dt=${date1}
hadoop fs -rm -r /user/daasuser/FlareData/Feeds/CCN_CDR_CS18_test1/tbl_dt=${date1}
hadoop fs -rm -r /encryption_zone/daasuser/FlareData/Feeds/AIR_CDR_CS18_test1/tbl_dt=${date1}

hadoop fs -mkdir -p  /user/daasuser/FlareData/Feeds/CCN_CDR_Detail_CS18_test1/tbl_dt=${date1}
hadoop fs -mkdir -p  /user/daasuser/FlareData/Feeds/CCN_CDR_CS18_test1/tbl_dt=${date1}
hadoop fs -mkdir -p  /encryption_zone/daasuser/FlareData/Feeds/AIR_CDR_CS18_test1/tbl_dt=${date1}

java -Xmx20g -Xms20g -Dlog4j.configurationFile=/home/daasuser/log4j2.xml -jar /home/daasuser/FileOps_2.11-0.1-SNAPSHOT.jar -in  /user/daasuser/FlareData/Feeds/CCN_CDR_Detail_CS18/tbl_dt=${date1} -out /mnt/beegfs_bsl2/rebhi_tmp/ -od -tf 1 -nt 15 -dp 15 -of -lbl copy${date1} -hdfs "hdfs://daasug" -fromHdfs -toHdfs -rcm -cp /user/daasuser/FlareData/Feeds/CCN_CDR_Detail_CS18_test1/tbl_dt=${date1} -nosim

java -Xmx20g -Xms20g -Dlog4j.configurationFile=/home/daasuser/log4j2.xml -jar /home/daasuser/FileOps_2.11-0.1-SNAPSHOT.jar -in  /encryption_zone/daasuser/FlareData/Feeds/CCN_CDR_CS18/tbl_dt=${date1} -out /mnt/beegfs_bsl2/rebhi_tmp/ -od -tf 1 -nt 15 -dp 15 -of -lbl copy${date1} -hdfs "hdfs://daasug" -fromHdfs -toHdfs -rcm -cp /user/daasuser/FlareData/Feeds/CCN_CDR_CS18_test1/tbl_dt=${date1} -nosim

java -Xmx20g -Xms20g -Dlog4j.configurationFile=/home/daasuser/log4j2.xml -jar /home/daasuser/FileOps_2.11-0.1-SNAPSHOT.jar -in  /encryption_zone/daasuser/FlareData/Feeds/AIR_CDR_CS18/tbl_dt=${date1} -out /mnt/beegfs_bsl2/rebhi_tmp/ -od -tf 1 -nt 15 -dp 15 -of -lbl copy${date1} -hdfs "hdfs://daasug" -fromHdfs -toHdfs -rcm -cp /encryption_zone/daasuser/FlareData/Feeds/AIR_CDR_CS18_test1/tbl_dt=${date1} -nosim


#java -Xmx20g -Xms20g -Dlog4j.configurationFile=/home/daasuser/log4j2.xml -jar /home/daasuser/FileOps_2.11-0.1-SNAPSHOT.jar -in  /user/daasuser/FlareData/Feeds/CCN_CDR_CS18/tbl_dt=${date1} -out /mnt/beegfs_master/rebhi_tmp/ -od -tf 1 -nt 15 -dp 15 -of -lbl copy${date1} -hdfs "hdfs://daasug" -fromHdfs -toHdfs -rcm -cp /user/daasuser/FlareData/Feeds/CCN_CDR_CS18_test1/tbl_dt=${date1} -idfl ".*SMS.*" -nosim

#java -Xmx20g -Xms20g -Dlog4j.configurationFile=/home/daasuser/log4j2.xml -jar /home/daasuser/FileOps_2.11-0.1-SNAPSHOT.jar -in  /user/daasuser/FlareData/Feeds/CCN_CDR_CS18/tbl_dt=${date1} -out /mnt/beegfs_master/rebhi_tmp/ -od -tf 1 -nt 15 -dp 15 -of -lbl copy${date1} -hdfs "hdfs://daasug" -fromHdfs -toHdfs -rcm -cp /user/daasuser/FlareData/Feeds/CCN_CDR_CS18_test1/tbl_dt=${date1} -idfl ".*CONTENT.*" -nosim

#java -Xmx20g -Xms20g -Dlog4j.configurationFile=/home/daasuser/log4j2.xml -jar /home/daasuser/FileOps_2.11-0.1-SNAPSHOT.jar -in  /user/daasuser/FlareData/Feeds/CCN_CDR_Detail_CS18/tbl_dt=${date1} -out /mnt/beegfs_master/rebhi_tmp/ -od -tf 1 -nt 15 -dp 15 -of -lbl copy${date1} -hdfs "hdfs://daasug" -fromHdfs -toHdfs -rcm -cp /user/daasuser/FlareData/Feeds/CCN_CDR_Detail_CS18_test1/tbl_dt=${date1} -idfl ".*CONTENT.*" -nosim

#java -Xmx20g -Xms20g -Dlog4j.configurationFile=/home/daasuser/log4j2.xml -jar /home/daasuser/FileOps_2.11-0.1-SNAPSHOT.jar -in  /user/daasuser/FlareData/Feeds/CCN_CDR_Detail_CS18/tbl_dt=${date1} -out /mnt/beegfs_master/rebhi_tmp/ -od -tf 1 -nt 15 -dp 15 -of -lbl copy${date1} -hdfs "hdfs://daasug" -fromHdfs -toHdfs -rcm -cp /user/daasuser/FlareData/Feeds/CCN_CDR_Detail_CS18_test1/tbl_dt=${date1} -idfl ".*SMS.*" -nosim

#java -Xmx20g -Xms20g -Dlog4j.configurationFile=/home/daasuser/log4j2.xml -jar /home/daasuser/FileOps_2.11-0.1-SNAPSHOT.jar -in  /user/daasuser/FlareData/Feeds/CCN_CDR_CS18/tbl_dt=${date1} -out /mnt/beegfs_master/rebhi_tmp/ -od -tf 1 -nt 15 -dp 15 -of -lbl copy${date1} -hdfs "hdfs://daasug" -fromHdfs -toHdfs -rcm -cp /user/daasuser/FlareData/Feeds/CCN_CDR_CS18_test1/tbl_dt=${date1} -idfl ".*DATA.*" -nosim

#java -Xmx20g -Xms20g -Dlog4j.configurationFile=/home/daasuser/log4j2.xml -jar /home/daasuser/FileOps_2.11-0.1-SNAPSHOT.jar -in  /user/daasuser/FlareData/Feeds/CCN_CDR_Detail_CS18/tbl_dt=${date1} -out /mnt/beegfs_master/rebhi_tmp/ -od -tf 1 -nt 15 -dp 15 -of -lbl copy${date1} -hdfs "hdfs://daasug" -fromHdfs -toHdfs -rcm -cp /user/daasuser/FlareData/Feeds/CCN_CDR_Detail_CS18_test1/tbl_dt=${date1} -idfl ".*DATA.*" -nosim

#java -Xmx20g -Xms20g -Dlog4j.configurationFile=/home/daasuser/log4j2.xml -jar /home/daasuser/FileOps_2.11-0.1-SNAPSHOT.jar -in  /user/daasuser/FlareData/Feeds/CCN_CDR_CS18/tbl_dt=${date1} -out /mnt/beegfs_master/rebhi_tmp/ -od -tf 1 -nt 15 -dp 15 -of -lbl copy${date1} -hdfs "hdfs://daasug" -fromHdfs -toHdfs -rcm -cp /user/daasuser/FlareData/Feeds/CCN_CDR_CS18_test1/tbl_dt=${date1} -idfl ".*UNKNOWN.*" -nosim

#java -Xmx20g -Xms20g -Dlog4j.configurationFile=/home/daasuser/log4j2.xml -jar /home/daasuser/FileOps_2.11-0.1-SNAPSHOT.jar -in  /user/daasuser/FlareData/Feeds/CCN_CDR_Detail_CS18/tbl_dt=${date1} -out /mnt/beegfs_master/rebhi_tmp/ -od -tf 1 -nt 15 -dp 15 -of -lbl copy${date1} -hdfs "hdfs://daasug" -fromHdfs -toHdfs -rcm -cp /user/daasuser/FlareData/Feeds/CCN_CDR_Detail_CS18_test1/tbl_dt=${date1} -idfl ".*UNKNOWN.*" -nosim

