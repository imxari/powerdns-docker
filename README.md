PowerDNS-Docker
=================

## Requirements
To run this PowerDNS-Docker stack it's required that you have:
- 3 Seperate Servers  
- Docker  
- Docker-Compose
- Knowledge on Galera
- Knowledge on PowerDNS  
- Common Sense  

This PowerDNS-Docker stack uses Galera to replicate PowerDNS records across multiple nameservers, you'll need to install and configure this stack on each server respectively.

## How to install
To install this PowerDNS-Docker stack type the following:  
1. Clone this repository:  
``` git clone https://github.com/h0lysp4nk/powerdns-docker.git && mv ./powerdns-docker /opt/powerdns-docker && cd /powerdns-docker ```  
2. Copy the '.env.template' file to '.env':  
``` cp .env.template .env ```  
3. Edit the '.env' file to configure MySQL, Galera, PowerDNS and PowerDNS-Admin:  
``` nano .env ```  
4. Start and build the stack:  
``` docker-compose up -d --build ```  
5. Check the stack is healthy(Wait 30 seconds or so after starting):  
``` docker-compose ps ```
6. Done!
