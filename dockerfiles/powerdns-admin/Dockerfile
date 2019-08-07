# Specify image
FROM ubuntu:18.04

# Specify maintainer
LABEL maintainer="liam@lkeenan.co.uk"

# Specify user
USER root

# Environment Variables
ENV MARIADB_HOST mariadb
ENV MARIADB_PORT 3306
ENV MARIADB_USER pdnsuser
ENV MARIADB_PASS changeme
ENV MARIADB_DATABASE pdns

ENV INSTALL_DATABASE=1

ENV LC_ALL=C.UTF-8
ENV export LANG=C.UTF-8

# Update, upgrade and install basics
RUN apt update -y && apt upgrade -y && apt install -y \
    curl bash gpg software-properties-common python3-dev python3 python3-pip python-pip mariadb-client

# Fixes bug: debconf: delaying package configuration, since apt-utils is not installed
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Install PowerDNS-Admin related shit
RUN apt update && apt install -y \
    libmysqlclient-dev libsasl2-dev libldap2-dev libssl-dev libxml2-dev libxslt1-dev libxmlsec1-dev libffi-dev pkg-config apt-transport-https virtualenv build-essential

# Install NodeJs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -y && apt-get install -y yarn

# Copy powerdns-admin and set permissions
COPY ./powerdns-admin-ui /powerdns-admin
RUN chmod -R 755 /powerdns-admin

# Create directory and change permissions
RUN mkdir -p /bootstrap && chmod -R 755 /bootstrap

# Copy entrypoint script and set permissions
COPY ./entrypoint.sh /bootstrap/entrypoint.sh
RUN chmod -R 755 /bootstrap && chmod +x /bootstrap/entrypoint.sh

# Install PIP requirements
RUN pip3 install -r /powerdns-admin/requirements.txt

# Start PowerDNS
ENTRYPOINT [ "/bootstrap/entrypoint.sh" ]
