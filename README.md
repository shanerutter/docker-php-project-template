# docker-php-project-template

## Running docker within WSL2 permissions fixes
`
usermod -a -G www-data shane
chgrp -R www-data /home/shane
chmod g+rwxs /home/shane
`
