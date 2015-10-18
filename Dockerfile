FROM percona
MAINTAINER Fabio Napoleoni <f.napoleoni@gmail.com>
# non interactive apt
ENV DEBIAN_FRONTEND noninteractive
# Get key from keyserver
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
# Upgrade all packages
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
# Add source and install packages
RUN echo 'deb http://repo.percona.com/apt jessie main' > /etc/apt/sources.list.d/percona.list
# Install required packages
RUN apt-get update && \
  apt-get install -y percona-xtradb-cluster-56 qpress xtrabackup && \
  apt-get install -y python-software-properties vim wget curl netcat

# Clean up APT when done.
RUN apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add configuration file for galera cluster
ADD ./my.cnf /etc/mysql/conf.d/my.cnf
# Ports used by cluster
EXPOSE 3306 4567 4568

