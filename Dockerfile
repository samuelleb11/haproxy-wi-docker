FROM centos:centos8

RUN yum -y install python36 python3-pip python3-devel python3-cryptography python3-jinja2 nmap-ncat net-tools lshw python3-ldap rsync dos2unix nmap mod_ssl httpd git && \
	pip3 install ansible

RUN cd /var/www/ && \
	git clone https://github.com/Aidaho12/haproxy-wi.git /var/www/haproxy-wi && \
	pip3 install -r haproxy-wi/config_other/requirements_el8.txt && \
	cp haproxy-wi/config_other/httpd/* /etc/httpd/conf.d/
