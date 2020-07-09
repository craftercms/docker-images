# Copyright (C) 2007-2020 Crafter Software Corporation. All Rights Reserved.
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

FROM openjdk:8-jre-slim

VOLUME /opt/studio-arbiter/config
VOLUME /opt/studio-arbiter/logs

# Tomcat
EXPOSE 8080

# Galera
EXPOSE 4567
EXPOSE 4568
EXPOSE 4444

ENV LOG_CONFIG ""
ENV LOG_PATH /opt/studio-arbiter/logs
ENV BINARY_PATH /opt/studio-arbiter/garbd
ENV HAZELCAST_CONFIG /opt/studio-arbiter/config/hazelcast-config.yaml
ENV STARTUP_CHECK_INTERVAL 30
ENV STARTUP_CHECK_TIMEOUT 300
ENV JAVA_OPTS ""

# Libraries needed by Galera (can be removed if a future version of Galera works with 1.1)
ADD lib/libcrypto.so.1.0.0 /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
ADD lib/libssl.so.1.0.0 /lib/x86_64-linux-gnu/libssl.so.1.0.0

WORKDIR /opt/studio-arbiter
ADD bin/studio-arbiter.jar studio-arbiter.jar

ENTRYPOINT java $JAVA_OPTS -jar /opt/studio-arbiter/studio-arbiter.jar
