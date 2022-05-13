#######################
#       CONFIG        #
#######################
$COMPOSE_FILE="dev"
$PROJECT_NAME = "project-name"


#######################
# DO NOT TOUCH BELOW ##
#######################

$COMPOSE="docker-compose -f docker-compose.$COMPOSE_FILE.yml --project-name $PROJECT_NAME"

if ($args.count -gt 0) {
    if ($args[0] -eq "bash") {
        echo "No longer supported, use `"develop php-fpm bash`" for same behaviour."
    } elseif ($args[0] -eq "php-fpm" -Or $args[0] -eq "php") {
        if ($args[1] -eq "restart") {
            Invoke-Expression "& $COMPOSE stop php-fpm"
            Invoke-Expression "& $COMPOSE up -d php-fpm"
        } elseif ($args[1] -eq "start") {
            Invoke-Expression "& $COMPOSE up -d php-fpm"
        } elseif ($args[1] -eq "stop") {
            Invoke-Expression "& $COMPOSE stop php-fpm"
        } elseif ($args[1] -eq "bash") {
            Invoke-Expression "& $COMPOSE exec php-fpm bash -c `"cd /var/www/html; exec bash`""
        } elseif ($args[1] -eq "config") {
            Invoke-Expression "& $COMPOSE exec php-fpm bash -c `"cd /usr/local/etc; exec bash`""
        } else {
            echo "Command missing: start, stop, restart, config, bash"
        }
    } elseif ($args[0] -eq "nginx") {
        if ($args[1] -eq "restart") {
            Invoke-Expression "& $COMPOSE stop nginx"
            Invoke-Expression "& $COMPOSE up -d nginx"
        } elseif ($args[1] -eq "reload") {
            Invoke-Expression "& $COMPOSE exec nginx bash -c `"nginx -s reload`""
        } elseif ($args[1] -eq "start") {
            Invoke-Expression "& $COMPOSE up -d nginx"
        } elseif ($args[1] -eq "stop") {
            Invoke-Expression "& $COMPOSE stop nginx"
        } elseif ($args[1] -eq "bash") {
            Invoke-Expression "& $COMPOSE exec nginx bash -c `"cd /etc/nginx; exec bash`""
        } else {
            echo "Command missing: start, stop, restart, reload, bash"
        }
    } elseif ($args[0] -eq "downup") {
        Invoke-Expression "& $COMPOSE down"
        Invoke-Expression "& $COMPOSE up"
    } else {
        Invoke-Expression "& $COMPOSE $args"
    }
} else {
    Invoke-Expression "& $COMPOSE ps"
}
