#!/bin/bash

# 获取当前时间的年、月、日并拼接起来
DATE=$(date +"%Y-%m-%d-%H-%M-%S")

# 创建目录
DIRECTORY="$SYSOB_LOG_DIR/$DATE"
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p "$DIRECTORY"
  echo "创建目录 $DIRECTORY 成功！"
else
  echo "目录 $DIRECTORY 已存在。"
fi

# 将目录名称存储到临时文件中
echo "$DIRECTORY" > $SYSOB_LAST_DIR_TMP
echo "目录名称已存储到 $SYSOB_LAST_DIR_TMP 文件中"


exit 0
