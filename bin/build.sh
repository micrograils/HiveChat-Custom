#! /bin/bash

# This script is used to build the custom version of HiveChat.
# It is called by the build script in CURRENT directory.
# It is not intended to be run directly.

# Get the absolute path of this script.
abs_path=$(cd "$(dirname "$0")"; pwd)
cd "$abs_path"
cd ..

cp -r resources/* HiveChat/
cd HiveChat
cp .env.example .env

# 先找到app服务开始的行号
app_start_line=$(grep -n 'app:' docker-compose.yml | cut -d: -f1)

# 从app服务开始的行之后查找image行
image_line=$(sed -n "${app_start_line},\$p" docker-compose.yml | grep 'image:' | head -n 1)

# 使用awk提取image的值
image_info=$(echo "$image_line" | awk -F': ' '{print $2}')

if [ -z "$image_info" ]; then
    echo "未找到app的image信息。"
fi

echo "app的image信息为: $image_info"
echo "开始构建app的image..."
echo "docker build -t ${image_info} ."
docker build -t ${image_info} .
