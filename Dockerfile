FROM centos:centos8
RUN cd /var/www/ && \
	git clone https://github.com/Aidaho12/haproxy-wi.git /var/www/haproxy-wi
RUN yum -y install python36 python3-pip python3-devel python3-cryptography python3-jinja2 nmap-ncat net-tools lshw python3-ldap rsync ansible dos2unix nmap mod_ssl httpd

RUN pip3 install -r haproxy-wi/config_other/requirements_el8.txt

RUN cp haproxy-wi/config_other/httpd/* /etc/httpd/conf.d/

RUN chmod +x haproxy-wi/app/*.py  && \
	cp haproxy-wi/config_other/logrotate/* /etc/logrotate.d/ && \
	cp haproxy-wi/config_other/syslog/* /etc/rsyslog.d/ && \
	systemctl daemon-reload && \
	systemctl restart httpd && \
	systemctl restart rsyslog && \
	mkdir /var/www/haproxy-wi/app/certs && \
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
