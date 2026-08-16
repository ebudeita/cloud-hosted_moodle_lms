#!/bin/bash
set -euxo pipefail

exec > >(tee /var/log/moodle-user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade -y

apt-get install -y \
  apache2 \
  git \
  unzip \
  mysql-client \
  php \
  php-cli \
  libapache2-mod-php \
  php-mysql \
  php-curl \
  php-gd \
  php-intl \
  php-mbstring \
  php-soap \
  php-xml \
  php-zip \
  php-bcmath \
  php-opcache

systemctl enable apache2
systemctl start apache2

PHP_VERSION=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')

cat > /etc/php/${PHP_VERSION}/apache2/conf.d/99-moodle.ini <<'EOF'
memory_limit = 256M
upload_max_filesize = 100M
post_max_size = 100M
max_execution_time = 300
max_input_vars = 5000
file_uploads = On
EOF

git clone --branch MOODLE_501_STABLE --depth 1 \
  https://github.com/moodle/moodle.git \
  /var/www/moodle

mkdir -p /var/moodledata

chown -R www-data:www-data /var/www/moodle
chown -R www-data:www-data /var/moodledata

find /var/www/moodle -type d -exec chmod 755 {} \;
find /var/www/moodle -type f -exec chmod 644 {} \;
chmod 770 /var/moodledata

cat > /etc/apache2/sites-available/moodle.conf <<'EOF'
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/moodle/public

    <Directory /var/www/moodle/public>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/moodle_error.log
    CustomLog ${APACHE_LOG_DIR}/moodle_access.log combined
</VirtualHost>
EOF

a2dissite 000-default.conf
a2ensite moodle.conf
a2enmod rewrite

systemctl restart apache2
