
#!/bin/bash

# Update package lists
apt-get update

# Install Apache, MySQL, and PHP
apt-get install -y apache2 mysql-server php php-mysqli

# Configure MySQL (secure installation with a strong password)
mysql_secure_installation

# Clone Laravel application from Github
git clone https://github.com/laravel/laravel /var/www/html/my-app

# Grant ownership of application directory to www-data user
chown -R www-data:www-data /var/www/html/my-app

# Enable modules required by Laravel application
a2enmod rewrite headers

# Configure Apache virtual host for the application
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/my-app.conf
sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/my-app/' /etc/apache2/sites-available/my-app.conf
a2ensite my-app.conf

# Restart Apache service
systemctl restart apache2

