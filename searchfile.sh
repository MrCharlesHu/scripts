#!/bin/sh

target="us.vpn.bewhere.co.uk"

function scandir() {
    local cur_dir parent_dir workdir
    workdir=$1
    cd ${workdir}
    if [ ${workdir} == "/" ]
    then
        cur_dir=""
    else
        cur_dir=$(pwd)
        # Mac中的文件目录可能会有空格
        # cur_dir=${PWD/ /\\ }
    fi
    # ls `/Applications/FlowVPN\ Connect.app/Contents`
    for dir_file in $(ls "${cur_dir}")
    do
        echo "HERE $dir_file"
        if test -d ${dir_file};then
            cd ${dir_file}
            scandir ’${cur_dir}/${dir_file}‘
            cd ..
        else
            echo "CurrentFile: ${cur_dir}/${dir_file}"
            awk "/${target}/" "${cur_dir}/${dir_file}"
            # awk "/${target}/" "/Applications/FlowVPN\ Connect.app/Contents/Info.plist"
        fi
    done
}

if test -d $1
then
    scandir $1
elif test -f $1
then
    echo "You input a file but not a directory,please reinput and try again !"
    exit 1
else
    echo "The directory doesn't exist which you input,please check !"
    exit 1
fi