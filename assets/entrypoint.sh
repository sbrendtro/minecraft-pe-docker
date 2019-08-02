#!/bin/bash

cd /pocketmine/PocketMine-MP

if ! [ -e server.properties ]; then
    echo >&2 "[WARN] server.properties is not found in $(pwd). Copying from the original assets."
    cp -p ../server.properties.original server.properties
    chown pocketmine:pocketmine server.properties
fi

if ! [ -e PocketMine-MP.phar ]; then
    echo >&2 "[WARN] PocketMine-MP.phar is not found in $(pwd). Installing the latest stable release."
    wget -q -O - https://get.pmmp.io | bash -s -
    chown -R pocketmine:pocketmine /pocketmine
fi

#su - pocketmine "/pocketmine/PocketMine-MP/start.sh"
/pocketmine/PocketMine-MP/start.sh
