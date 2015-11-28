# Create zookeeper 3.4.6
# 
# docker build -t wanbo/docker-zk .

FROM centos:7
MAINTAINER Wanbo <gewanbo@gmail.com>

USER root

RUN yum install -y tar

### Create path
RUN mkdir -p /local/server

### Create JDK
COPY jdk-8u31-linux-x64.tar.gz /local/server/
RUN tar -zxvf /local/server/jdk-8u31-linux-x64.tar.gz -C /local/server/

ENV JAVA_HOME /local/server/jdk1.8.0_31
ENV PATH=$JAVA_HOME/bin:$PATH
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


### Create zookeeper
COPY zookeeper-3.4.6.tar.gz /local/server/
RUN tar -zxvf /local/server/zookeeper-3.4.6.tar.gz -C /local/server/
RUN mv /local/server/zookeeper-3.4.6 /local/server/zookeeper
RUN cp /local/server/zookeeper/conf/zoo_sample.cfg /local/server/zookeeper/conf/zoo.cfg


EXPOSE 2181 22

WORKDIR /local/server/zookeeper

RUN echo "#!/bin/sh" > run.sh
RUN echo "echo 'hello'" >> run.sh
RUN echo "ip addr" >> run.sh
RUN echo "bin/zkServer.sh start-foreground" >> run.sh

RUN chmod 700 run.sh


#ENTRYPOINT ["/local/server/zookeeper/bin/zkServer.sh","start-foreground"]
ENTRYPOINT ["/local/server/zookeeper/run.sh"]

#CMD ["/usr/sbin/ip","addr"]
