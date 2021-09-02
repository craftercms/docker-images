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
FROM alpine:3.13 as main

# Add default variables. Default cron runs the logrotate daily at 12 AM
ENV CRON_SCHEDULE='0 0 * * *' \
    LOGROTATE_PATTERN='/opt/crafter/logs/deployer/* /opt/crafter/logs/tomcat/*' \
    LOGROTATE_COPIES='10' \
    LOGROTATE_SIZE='10M'

# Install dependencies
RUN apk add --no-cache shadow logrotate tini gettext libintl

# Add the Crafter user
RUN groupadd -r -g 1000 crafter && useradd -r -m -u 1000 -g crafter crafter

# Copy entrypoint script and make it executable
COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

# Copy logrotate template conf
COPY logrotate.tpl.conf .

# Entrypoint and command
ENTRYPOINT [ "./docker-entrypoint.sh" ]
CMD ["/usr/sbin/crond", "-f", "-L", "/dev/stdout"]