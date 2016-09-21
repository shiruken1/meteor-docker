#1) Install dependencies
apt-get update
apt-get install -y python nginx wget git vim supervisor \
	sysv-rc software-properties-common unzip mongodb-server nodejs npm

add-apt-repository ppa:webupd8team/java
apt-get update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get install -y oracle-java8-installer oracle-java8-set-default

cd /tmp && wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.1/elasticsearch-2.3.1.deb
dpkg -i elasticsearch-2.3.1.deb

# curl -sL https://deb.nodesource.com/setup_0.12 | sh
curl https://install.meteor.com | sh

#3) Set the locale
locale-gen en_US.UTF-8  
# export LANG=en_US.UTF-8  
export LANGUAGE=en_US:en  
export LC_ALL=en_US.UTF-8
update-locale LANG=en_US.UTF-8

#4) Copy files into their respective places
#mkdir /var/run/sshd && chmod 0755 /var/run/sshd
mkdir -p /etc/supervisord/ && mkdir /var/log/supervisord
#mkdir /root/.ssh && mkdir -p /root/.ssh && chmod 700 /root/.ssh && chown root:root /root/.ssh

cd /provision
cp conf/supervisor.conf /etc/supervisord.conf
cp conf/nginx-development /etc/nginx/sites-available/nginx-development
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/nginx-development /etc/nginx/sites-enabled/nginx-development
cp service/*.conf /etc/supervisord/

#5) Set file values and permissions
nginx -s reload
# for MongoDB
mkdir /data
mkdir /data/db

#6) Run commands

#7) Initialize the app
cd /app
npm install
meteor npm install --save bcrypt

#8) Clean up
apt-get -y --purge autoremove
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /provision
