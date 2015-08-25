FROM       java:8-jre
MAINTAINER Karloku Sang <karloku@loku.it>

# install elasticsearch
RUN        wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN        echo "deb http://packages.elastic.co/elasticsearch/1.7/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-1.7.list
RUN        apt-get update && apt-get install elasticsearch

# install elasticsearch-head
RUN        /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head --verbose

# install ik-analysis
COPY       plugins /plugins
RUN        ["/usr/share/elasticsearch/bin/plugin", "-install medcl/elasticsearch-analysis-ik", "--url file:///plugins/elasticsearch-analysis-ik-1.4.0-jar-with-dependencies.jar"]

# copy config files
COPY       config /etc/elasticsearch/config
RUN        mkdir -p /data/log

# copy start script
EXPOSE     9200 9300
ENTRYPOINT /bin/sh -c '/usr/share/elasticsearch/bin/elasticsearch --config=/etc/elasticsearch/config/elasticsearch.yml -Xms2g -Xmx2g -Djava.awt.headless=true -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError -XX:+DisableExplicitGC -Dfile.encoding=UTF-8' 