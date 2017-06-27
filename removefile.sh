#!/bin/sh

file_arr=()
file_num=0

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
        if test -d ${dir_file};then
            cd ${dir_file}
            scandir ${cur_dir}/${dir_file}
            cd ..
        else  
            # echo "当前文件是："$filename  
            # if [ ${dir_file: -4} == ".log" ]
            # if [[ $dir_file == *.log* ]]
            # echo "dir_file = $dir_file | target = $target"
            # if [[ $dir_file =~ $target ]]
            if [[ $dir_file =~ .*\.log$ ]]
            then
                file_arr[$file_num]=${cur_dir}/${dir_file}
                file_num=`expr $file_num + 1`
                # echo $file_num
                # echo ${#file_arr[*]}
                # echo ${cur_dir}/${dir_file}
            fi
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
    echo "Do you want to delete those files (${#file_arr[*]}) ?"
    read ANS
    case $ANS in
        y|Y|yes|Yes)
            for file in ${file_arr[*]};
            do
                rm -v $file
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