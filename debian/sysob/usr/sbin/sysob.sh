#!/bin/bash
#
# Script Name: sysob.sh
# Description: sysob脚本的总入口函数，在systemd service中调用该脚本。
# 如果需要新增监控命令，请直接参考sysob-example.sh 编写脚本即可。脚本放在与sysob.sh同级目录下。
# 运行新增命令方式  /usr/sbin/sysob.sh -m example [argv]
# example：/usr/sbin/sysob.sh -m iotop [argv]。会运行sysob-iotop.sh [argv]
# Version: 1.0 
# Author: niecheng
# Last Modified: 2023-05-31
#

args=("${@:4}")

# 定义默认参数
mode=""

# 处理传入参数
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -m|--stringOption)
    mode="$2" # 存储参数值
    shift # 因为参数和对应值是成对出现的，所以需要移动两个位置
    shift
    ;;
    -h|--help)
    echo "Usage: yourscript [OPTIONS]"
    echo "Options:"
    echo "-m, --stringOption arg   Set the string option. "
    echo "-h, --help               Display this help and exit."
    echo "log dir is /var/log/sysob/"
    exit 0
    ;;
    *)
    echo "Invalid option: [$key]. Use --help for usage information."
    exit 1
    ;;
esac
done

if [ -f "$SYSOB_LAST_DIR_TMP" ]; then
	TMP_FULL_NAME=$(cat $SYSOB_LAST_DIR_TMP)
	echo "TMP_FULL_NAME:$TMP_FULL_NAME"
else
	echo "Error $SYSOB_LATS_DIR_TMP file not exist."
	exit 3
fi

# 检查参数是否为空
if [[ -z "$SYSOB_PERIOD" ]]; then
  echo "ERROR: 'SYSOB_PERIOD' parameter is required."
  exit 1
fi

 
# 输出参数信息
echo "String option (-m, --stringOption): $mode"
export DIR_NAME=$TMP_FULL_NAME
SYSOB_FULL_LOG=$DIR_NAME/sysob.log
mkdir -p $DIR_NAME
SCRIPT=$(dirname "$0")

# 检查参数是否为空
if [[ -z "$mode" ]]; then
  echo "ERROR: 'mode' parameter is required."
  exit 1
fi

# 构建脚本路径
script_path="./$SCRIPT/sysob-$mode.sh"

# 检查脚本文件是否存在
if [[ ! -f "$script_path" ]]; then
  echo "ERROR: Script file 'sysob-$mode.sh' for mode '$mode' not found: $script_path."
  exit 2
fi

# 运行脚本文件
"$script_path" $args


