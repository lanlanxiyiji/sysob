#!/bin/bash
# 修改LOG_NAME，DEFAULT_COMMAND，CUSTOM_COMMAND  即可
LOG_NAME="example.log"
LOG_FULL_NAME=$DIR_NAME/$LOG_NAME

DEFAULT_COMMAND="ps -ef > $LOG_FULL_NAME"
CUSTOM_COMMAND="ps $@ > $LOG_FULL_NAME"

if [ -z "$1" ]; then
    COMMAND="$DEFAULT_COMMAND"
else
    COMMAND="$CUSTOM_COMMAND"
fi

echo "The command to be executed is: $COMMAND"
$COMMAND     # 使用 eval 来运行命令并执行 command 变量中字符串所表示的命令
exit 0
