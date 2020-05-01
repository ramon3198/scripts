  apt-get update
	apt-get install -y squid curl nano sysv-rc-conf ulatency ulatencyd
	
	cd /etc/ssh/

	echo "$(sed 's/22/443/g' sshd_config)" > sshd_config
	echo "" >> sshd_config	
	echo "Port 22" >> sshd_config	
	
	ip=$(wget -qO - icanhazip.com)
	
	echo "# PUERTOS DE ACCESO" > /etc/squid/squid.conf
	echo "http_port 80" >> /etc/squid/squid.conf
	echo "http_port 8080" >> /etc/squid/squid.conf
	echo "http_port 443" >> /etc/squid/squid.conf
	echo "http_port 3128" >> /etc/squid/squid.conf
	echo "" >> /etc/squid/squid.conf
	echo "" >> /etc/squid/squid.conf
	echo "# NOMBRE DEL SERVIDOR" >> /etc/squid/squid.conf
	echo "visible_hostname CARCAMO" >> /etc/squid/squid.conf
	echo "" >> /etc/squid/squid.conf
	echo "" >> /etc/squid/squid.conf
	echo "# ACL DE CONEXION" >> /etc/squid/squid.conf
	echo "acl accept src $ip" >> /etc/squid/squid.conf
	echo "acl ip url_regex -i $ip" >> /etc/squid/squid.conf
	echo "" >> /etc/squid/squid.conf
	echo "" >> /etc/squid/squid.conf
	echo "# CACHE DEL SQUID" >> /etc/squid/squid.conf
	echo "cache_mem 200 MB" >> /etc/squid/squid.conf
	echo "maximum_object_size_in_memory 32 KB" >> /etc/squid/squid.conf
	echo "maximum_object_size 1024 MB" >> /etc/squid/squid.conf
	echo "minimum_object_size 0 KB" >> /etc/squid/squid.conf
	echo "cache_swap_low 90" >> /etc/squid/squid.conf
	echo "cache_swap_high 95" >> /etc/squid/squid.conf
	echo "cache_dir ufs /var/spool/squid 100 16 256" >> /etc/squid/squid.conf
	echo "access_log /var/log/squid/access.log squid" >> /etc/squid/squid.conf
	echo "" >> /etc/squid/squid.conf
	echo "" >> /etc/squid/squid.conf
	echo "# ACCESOS ACL" >> /etc/squid/squid.conf
	echo "http_access allow accept" >> /etc/squid/squid.conf
	echo "http_access allow ip" >> /etc/squid/squid.conf
	echo "http_access deny all" >> /etc/squid/squid.conf
	echo "cache deny all" >> /etc/squid/squid.conf

	sysv-rc-conf squid on

	service squid restart

	service ssh restart
	
	clear
	echo "Servidor/Proxy"
	echo "$ip"
	echo "PUERTO: 80, 8080, 8799 e 3128"
	echo "PUERTO SSH: 443"
