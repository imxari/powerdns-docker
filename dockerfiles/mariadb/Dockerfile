# Specify image
FROM mariadb:10.3

# Specify maintainer
LABEL maintainer="liam@lkeenan.co.uk"

# Copy our Galera config
COPY ./galera.cnf /etc/mysql/conf.d/galera.cnf

# Create the directory and copy our setup script
RUN mkdir -p /bootstrap && chmod -R 755 /bootstrap
COPY ./setup.sh /bootstrap/setup.sh
RUN chmod +x /bootstrap/setup.sh

# Run our setup script
ENTRYPOINT [ "/bootstrap/setup.sh" ]

# Run MariaDB
CMD [ "mysqld" ]
