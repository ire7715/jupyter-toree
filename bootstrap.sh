#!/bin/bash

if [[ -z "$HOST_IP" ]]; then
  echo "HOST_IP must be provided."
  exit 1
else
  echo "spark.driver.bindAddress "$HOSTNAME >> /usr/local/spark/conf/spark-defaults.conf
  echo "spark.driver.host "$HOST_IP >> /usr/local/spark/conf/spark-defaults.conf
fi

if [[ -n "$MASTER_HOSTNAME" ]]; then
  sed -i 's/\/\/master/\/\/'$MASTER_HOSTNAME'/' /usr/local/spark/conf/spark-defaults.conf
  sed -i 's/master/'$MASTER_HOSTNAME'/' /usr/local/hadoop/etc/hadoop/core-site.xml
  sed -i 's/master/'$MASTER_HOSTNAME'/' /usr/local/hadoop/etc/hadoop/yarn-site.xml
fi

sed -i 's/JUPYTER_AUTH_TOKEN/'$JUPYTER_AUTH_TOKEN'/' /root/.jupyter/jupyter_notebook_config.py

jupyter notebook --allow-root >> /var/log/jupyter.log
