#! /bin/bash

# This script is used to build the custom version of HiveChat.
# It is called by the build script in CURRENT directory.
# It is not intended to be run directly.

# Get the absolute path of this script.
abs_path=$(cd "$(dirname "$0")"; pwd)
cd "$abs_path"
cd ..

cp -r resources/app HiveChat/
cd HiveChat

# 先找到app服务开始的行号
app_start_line=$(grep -n 'app:' docker-compose.yml | cut -d: -f1)

# 从app服务开始的行之后查找image行
image_line=$(sed -n "${app_start_line},\$p" docker-compose.yml | grep 'image:')

# 使用awk提取image的值
image_info=$(echo "$image_line" | awk -F': ' '{print $2}')

if [ -n "$image_info" ]; then
    echo "app的image信息为: $image_info"
else
    echo "未找到app的image信息。"
fi

docker build -t ${image_info} .
