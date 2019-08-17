PowerDNS-Docker
=================

[![Build Status](https://travis-ci.org/h0lysp4nk/powerdns-docker.svg?branch=master)](https://travis-ci.org/h0lysp4nk/powerdns-docker)

## Requirements
To run this PowerDNS-Docker stack it's required that you have:
- 3 Seperate Servers(Recommended)
- Docker  
- Docker-Compose
- Knowledge on Galera
- Knowledge on PowerDNS  
- Common Sense  

This PowerDNS-Docker stack uses Galera to replicate PowerDNS records across multiple nameservers, you'll need to install and configure this stack on each server respectively. However, there is a compose file for using just a single MariaDB node without Galera please see ```docker-compose.yml.mysql```

## How to install
To install this PowerDNS-Docker stack type the following:  
1. Clone this repository:  
``` git clone https://github.com/h0lysp4nk/powerdns-docker.git && mv ./powerdns-docker /opt/powerdns-docker && cd /powerdns-docker ```  
2. Copy the '.env.template' file to '.env':  
``` cp .env.template .env ```  
3. Edit the '.env' file to configure MySQL, Galera, PowerDNS and PowerDNS-Admin:  
``` nano .env ```  
4. Create the docker network:  
``` docker network create pdnsnet ```
5. Start and build the stack:  
``` docker-compose up -d --build ```  
6. Check the stack is healthy(Wait 30 seconds or so after starting):  
``` docker-compose ps ```
7. Done!
