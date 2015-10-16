FROM ubuntu:precise
MAINTAINER Percona.com <info@percona.com>
# Upgrade
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
ENV DEBIAN_FRONTEND noninteractive
# Get key from keyserver
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
# Add source and install packages
ADD ./percona.list /etc/apt/sources.list.d/percona.list
RUN apt-get update && \
  apt-get install -y percona-xtradb-cluster-56 qpress xtrabackup && \
  apt-get install -y python-software-properties vim wget curl netcat
# Add configuration file
ADD ./my.cnf /etc/my.cnf
# Ports used by cluster
EXPOSE 3306 4567 4568
# This is actually overridden in compose, it can be avoided
CMD /sbin/service mysql bootstrap-pxc && tailf /dev/null
