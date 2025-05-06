#!/bin/bash

# This script is used to deploy the custom version of HiveChat.
# It is called by the deploy script in CURRENT directory.
# It is not intended to be run directly.

# Get the absolute path of this script.
abs_path=$(cd "$(dirname "$0")"; pwd)
cd "$abs_path"
cd ..

cd HiveChat

docker compose down
docker compose up -d
