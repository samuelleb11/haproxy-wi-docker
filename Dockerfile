FROM centos:centos8

RUN yum -y install rsyslog python36 python3-pip python3-devel python3-cryptography python3-jinja2 nmap-ncat net-tools lshw python3-ldap rsync dos2unix nmap mod_ssl httpd git && \
	pip3 install ansible

RUN cd /var/www/ && \
	git clone https://github.com/Aidaho12/haproxy-wi.git /var/www/haproxy-wi && \
	pip3 install -r haproxy-wi/config_other/requirements_el8.txt && \
	cp haproxy-wi/config_other/httpd/* /etc/httpd/conf.d/

RUN cd /var/www/ && \
	chmod +x haproxy-wi/app/*.py  && \
	cp haproxy-wi/config_other/logrotate/* /etc/logrotate.d/ && \
	cp haproxy-wi/config_other/syslog/* /etc/rsyslog.d/
	
RUN systemctl daemon-reload

RUN systemctl restart httpd

RUN systemctl restart rsyslog

RUN mkdir /var/www/haproxy-wi/app/certs && \
	mkdir /var/www/haproxy-wi/keys && \
	mkdir /var/www/haproxy-wi/configs/ && \
	mkdir /var/www/haproxy-wi/configs/hap_config/ && \
	mkdir /var/www/haproxy-wi/configs/kp_config/ && \
	mkdir /var/www/haproxy-wi/configs/nginx_config/ && \
	mkdir /var/www/haproxy-wi/log/

RUN	chown -R apache:apache /var/www/haproxy-wi/ && \
	cd /var/www/haproxy-wi/app && \
	./create_db.py && \
	chown -R apache:apache /var/www/haproxy-wi/