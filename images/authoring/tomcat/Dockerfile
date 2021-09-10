# Copyright (C) 2007-2021 Crafter Software Corporation. All Rights Reserved.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as published by
# the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
FROM tomcat:8-jdk11-openjdk-slim as main

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
    apt-get update; \
    apt-get install -y gosu; \
    apt-get install -y --no-install-recommends curl; \
    apt-get install -y --no-install-recommends lsof; \
    apt-get install -y --no-install-recommends libaio1; \
    apt-get install -y --no-install-recommends libncurses5; \
    apt-get install -y --no-install-recommends openssh-client; \
    apt-get install -y --no-install-recommends git; \
    apt-get install -y --no-install-recommends rsync; \
    apt-get install -y --no-install-recommends iproute2; \
    apt-get install -y --no-install-recommends procps; \
    apt-get install -y --no-install-recommends vim; \
    apt-get install -y --no-install-recommends nano; \
    rm -rf /var/lib/apt/lists/*;

# Create folders and make CRAFTER_HOME the workdir
RUN mkdir -p /opt/crafter; \
    mkdir /opt/crafter/bin; \
    mkdir /opt/crafter/backups; \
    mkdir /opt/crafter/data; \
    mkdir /opt/crafter/logs; \
    mkdir /opt/crafter/temp

WORKDIR /opt/crafter

# Create volumes
VOLUME [ "/opt/crafter/data", "/opt/crafter/logs", "/opt/crafter/temp" ]

# Add the Crafter user
RUN groupadd -r -g 1000 crafter && useradd -r -m -u 1000 -g crafter crafter; \
    chown -R crafter:crafter .; \
    chown -R crafter:crafter /usr/local/tomcat

# Copy bin folder
COPY --chown=crafter:crafter ./bin ./bin/

# Make the Grapes dir a volume
VOLUME /opt/crafter/bin/grapes

# Delete the bin/dbms dir
# Delete the apache tomcat folder, we're going to link to the image's own Tomcat
# Delete the conf and webapps
RUN rm -rf ./bin/dbms; \
    rm -rf ./bin/apache-tomcat; \
    gosu crafter ln -s /usr/local/tomcat ./bin/apache-tomcat; \
    rm -rf ./bin/apache-tomcat/conf/* && rm -rf ./bin/apache-tomcat/webapps/*

# Copy Tomcat setenv.sh, config, shared and webapps
COPY --chown=crafter:crafter ./bin/apache-tomcat/bin/setenv.sh ./bin/apache-tomcat/bin/
COPY --chown=crafter:crafter ./bin/apache-tomcat/conf ./bin/apache-tomcat/conf/
COPY --chown=crafter:crafter ./bin/apache-tomcat/webapps ./bin/apache-tomcat/webapps/
COPY --chown=crafter:crafter ./bin/apache-tomcat/shared ./bin/apache-tomcat/shared/

# Remove CATALINA_HOME from crafter-setenv.sh
# Replace ports for default ones
RUN sed -i '/export CATALINA_HOME=$CRAFTER_BIN_DIR\/apache-tomcat/d' ./bin/crafter-setenv.sh; \
    sed -i 's/8694/8983/g' ./bin/crafter-setenv.sh; \
    sed -i 's/9201/9200/g' ./bin/crafter-setenv.sh; \
    sed -i 's/27020/27017/g' ./bin/crafter-setenv.sh; \
    sed -i 's/33306/3306/g' ./bin/crafter-setenv.sh;

# Copy entrypoint script and make it executable
COPY ./docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

# Expose debug port
EXPOSE 8000

# Entrypoint and command (run by default)
ENTRYPOINT [ "./docker-entrypoint.sh" ]
CMD [ "run" ]

FROM main as enterprise

# Expose MariaDB cluster ports
EXPOSE 3306
EXPOSE 4567
EXPOSE 4568
EXPOSE 4444
# Expose Hazelcast port
EXPOSE 5701

# Libraries needed by Galera (can be removed if a future version of Galera works with 1.1)
COPY --chown=crafter:crafter lib/libcrypto.so.1.0.0 /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
COPY --chown=crafter:crafter lib/libssl.so.1.0.0 /lib/x86_64-linux-gnu/libssl.so.1.0.0

FROM enterprise as imagemagick

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends imagemagick; \
    rm -rf /var/lib/apt/lists/*;