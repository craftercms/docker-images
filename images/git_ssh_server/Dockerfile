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
FROM alpine:3.10 as main

# Install dependencies
RUN apk add --no-cache bash shadow openssh git su-exec

# Create folders for crafter user
RUN mkdir -p /opt/crafter/data

# Create volumes
VOLUME [ "/opt/crafter/data" ]

# Add the Crafter user
# Enable public key auth. Also set the host key algorithms to just RSA to avoid issues with JGit/JSch
RUN groupadd -r -g 1000 crafter && useradd -r -m -u 1000 -g crafter crafter; \
    usermod -p '*' crafter; \
    chown -R crafter:crafter /opt/crafter/data; \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config; \
    echo '' >> /etc/ssh/sshd_config; \
    echo 'HostKeyAlgorithms ssh-rsa' >> /etc/ssh/sshd_config

# Copy entrypoint script and make it executable
COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

# Expose port
EXPOSE 22

# Entrypoint and command (run by default)
ENTRYPOINT [ "./docker-entrypoint.sh" ]
CMD [ "run" ]