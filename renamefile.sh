#!/bin/sh

file_arr=()
file_num=0
# expr_match='（更多视频教程关注微信公众号【xinsz08】'
expr_match='(关注微信公众号：xinsz08)'
# expr_match='0'

function scandir() {
    local cur_dir parent_dir workdir
    workdir=$1
    cd ${workdir}
    if [ ${workdir} == "/" ]
    then
        cur_dir=""
    else
        cur_dir=$(pwd)
    fi

    for dir_file in $(ls ${cur_dir})
    do
        # echo "dirname = ${dir_file}"
        if [[ $dir_file =~ $expr_match ]]
        then
            file_arr[$file_num]=${cur_dir}/${dir_file}
            file_num=`expr $file_num + 1`
        fi
        if test -d ${dir_file};then
            cd ${dir_file}
            scandir ${cur_dir}/${dir_file}
            cd ..
        fi
    done
}

if test -d $1
then
    # target=$2
    scandir $1
    if [ ${#file_arr[*]} == 0 ]
    then
        echo "Not files found !"
        exit 1
    fi
    echo "Searched File List (${#file_arr[*]}) :"
    for file in ${file_arr[*]};
    do
        echo $file
    done;
    # This example shows how to prompt for user's input.
    echo "Do you want to rename those files (${#file_arr[*]}) ?"
    read ANS
    case $ANS in
        y|Y|yes|Yes)
            for file in ${file_arr[*]};
            do
                rename -v "s/${expr_match}//" $file
            done;
            ;;
        n|N|no|No)
            exit 1
            ;;
    esac
elif test -f $1
then
    echo "You input a file but not a directory,please reinput and try again !"
    exit 1
else
    echo "The directory doesn't exist which you input,please check !"
    exit 1
fi