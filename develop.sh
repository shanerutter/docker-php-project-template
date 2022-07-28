#!/bin/bash

#######################
#       CONFIG        #
#######################
COMPOSE_FILE="dev"
PROJECT_NAME="projectname"


#######################
# DO NOT TOUCH BELOW ##
#######################

COMPOSE="docker-compose -f docker-compose.$COMPOSE_FILE.yml --project-name $PROJECT_NAME"

if [[ $1 ]]; then
    if [[ $1 == "bash" ]]; then
        echo "No longer supported, use \"develop php-fpm bash\" for same behaviour."
    elif [[ $1 == "php-fpm" || $1 == "php" ]]; then
        if [[ $2 == "restart" ]]; then
            $COMPOSE stop php-fpm
            $COMPOSE up -d php-fpm
        elif [[ $2 == "start" ]]; then
            $COMPOSE up -d php-fpm
        elif [[ $2 == "stop" ]]; then
            $COMPOSE stop php-fpm
        elif [[ $2 == "bash" ]]; then
            $COMPOSE exec php-fpm bash -c "cd /var/www/html; exec bash"
        elif [[ $2 == "config" ]]; then
            $COMPOSE exec php-fpm bash -c "cd /usr/local/etc; exec bash"
        else
            echo "Command missing: start, stop, restart, config, bash"
        fi
    elif [[ $1 == "nginx" ]]; then
        if [[ $2 == "restart" ]]; then
            $COMPOSE stop nginx
            $COMPOSE up -d nginx
        elif [[ $2 == "reload" ]]; then
            $COMPOSE exec nginx bash -c "nginx -s reload"
        elif [[ $2 == "start" ]]; then
            $COMPOSE up -d nginx
        elif [[ $2 == "stop" ]]; then
            $COMPOSE stop nginx
        elif [[ $2 == "bash" ]]; then
            $COMPOSE exec php-fpm bash -c "cd /etc/nginx; exec bash"
        else
            echo "Command missing: start, stop, restart, reload, bash"
        fi
    elif [[ $1 == "downup" ]]; then
        $COMPOSE down
        $COMPOSE up
    else
        $COMPOSE $@
    fi
else
    $COMPOSE ps
fi
