#!/bin/sh
function mysed() {
	local cur_dir parent_dir workdir
    workdir=$1
    echo "workdir=${workdir}"
    cd ${workdir}
    if [ ${workdir} == "/" ]
    then
        cur_dir=""
    else
        cur_dir=$(pwd)
    fi
    for dir_file in $(ls "${cur_dir}")
	do
		if test -d ${dir_file};then
            cd ${dir_file}
            mysed "${cur_dir}/${dir_file}"
            cd ..
        else
        	echo "pwd = $(pwd)"
            for name in `ls *.java`;
			do
				echo "name = ${name}"
				sed -i '' 's/v1/v2/g' ${name};
			done;
        fi
    done
}
mysed ./
