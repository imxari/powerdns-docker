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

ENV INSTALL_DATABASE=yes

# Update, upgrade and install basics
RUN apt update -y && apt upgrade -y && apt install -y \
    curl bash gpg software-properties-common

# Add PowerDNS repository
RUN echo "deb [arch=amd64] http://repo.powerdns.com/ubuntu bionic-auth-41 main" | tee -a /etc/apt/sources.list.d/powerdns.list
RUN curl https://repo.powerdns.com/FD380FBB-pub.asc | apt-key add -

# Install PowerDNS related packages
RUN apt update && apt install -y \
    pdns-server pdns-backend-mysql mariadb-client

# Create directory and change permissions
RUN mkdir -p /bootstrap && chmod -R 755 /bootstrap

# Add database setup script and set permissions
COPY ./install_db.sh /bootstrap/install_db.sh
COPY ./pdns_schema.sql /bootstrap/pdns_schema.sql
RUN chmod -R 755 /bootstrap && chmod +x /bootstrap/install_db.sh

# Copy database test script and set permissions
COPY ./verify_db.sh /bootstrap/verify_db.sh
RUN chmod -R 755 /bootstrap && chmod +x /bootstrap/verify_db.sh

# Copy entrypoint script and set permissions
COPY ./entrypoint.sh /bootstrap/entrypoint.sh
RUN chmod -R 755 /bootstrap && chmod +x /bootstrap/entrypoint.sh

# Copy PowerDNS configuration and set permissions
RUN mkdir -p /etc/powerdns/pdns.d
COPY ./pdns.conf /etc/powerdns/pdns.conf
COPY ./pdns.local.gmysql.conf /etc/powerdns/pdns.d/pdns.local.gmysql.conf
RUN chmod -R 755 /etc/powerdns

# Start PowerDNS
ENTRYPOINT [ "/bootstrap/entrypoint.sh" ]
