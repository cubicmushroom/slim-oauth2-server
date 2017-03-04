#!/usr/bin/env bash

NAMESPACE="CubicMushroom\\Slim\\OAuth2\\Server"
FILENAME="do"
COMPOSE="docker-compose"

if [ $# == 0 ];then

    echo "Usage...

./${FILENAME} composer ...      Run composer commands

./${FILENAME} spec ...          Run PHPSpec commands
./${FILENAME} spec desc {class} Run PHPSpec desc, but will automatically include the project base namespace before the
                                {class} name

./${FILENAME} ...               Run docker-compose ...
"

else

    # If "composer" is used, pass-thru to "composer"
    # inside a new container
    if [ "$1" == "composer" ]; then
        shift 1
        ${COMPOSE} run --rm composer "$@"

    # If "spec" is used, run PHPSpec
    elif [ "$1" == "spec" ]; then
        shift 1
        if [ "$1" == "desc" ]; then
            shift 1
            ${COMPOSE} run --rm php7.1 ./vendor/bin/phpspec desc "${NAMESPACE}\\$@"

        else
            ${COMPOSE} run --rm php7.1 ./vendor/bin/phpspec "$@"

        fi

    else
        ${COMPOSE} $@

    fi
fi
