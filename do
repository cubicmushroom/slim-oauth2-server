#!/usr/bin/env bash

FILENAME="do"
COMPOSE="docker-compose"

if [ $# == 0 ];then

    echo "Usage...

./${FILENAME} composer ...      Run composer commands

./${FILENAME} spec              Run PHPSpec commands

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
        ${COMPOSE} run --rm php7.1 ./vendor/bin/phpspec "$@"

    else
        ${COMPOSE} $@

    fi
fi
