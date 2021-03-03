FROM saaq.whnet.ca/whnet/centos-python-ansible:latest

RUN cd /var/www/ && \
	git clone https://github.com/Aidaho12/haproxy-wi.git /var/www/haproxy-wi

RUN cd /var/www/ && \
	pip3 install -r haproxy-wi/config_other/requirements_el8.txt && \
	cp haproxy-wi/config_other/httpd/* /etc/httpd/conf.d/

RUN cd /var/www/ && \
	chmod +x haproxy-wi/app/*.py  && \
	cp haproxy-wi/config_other/logrotate/* /etc/logrotate.d/ && \
	cp haproxy-wi/config_other/syslog/* /etc/rsyslog.d/

RUN mkdir /var/www/haproxy-wi/app/certs && \
	mkdir /var/www/haproxy-wi/keys && \
	mkdir /var/www/haproxy-wi/configs/ && \
	mkdir /var/www/haproxy-wi/configs/hap_config/ && \
	mkdir /var/www/haproxy-wi/configs/kp_config/ && \
	mkdir /var/www/haproxy-wi/configs/nginx_config/ && \
	mkdir /var/www/haproxy-wi/log/ && \
	chown -R apache:apache /var/www/haproxy-wi/

RUN	cd /var/www/haproxy-wi/app && \
	./create_db.py && \
	chown -R apache:apache /var/www/haproxy-wi/