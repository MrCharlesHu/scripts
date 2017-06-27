#!/bin/bash
table=$1
echo "表名：${table}"
mysql -uroot -proot -e "select eid from ${table};"|sed '1d'|sed 's/$/;/'|sed 's/^/ where eid = /' > idseq.sql
vim idseq.sql << EOF
:g/^/exe ":s/^/".line(".")."/"
:%s/^/update ${table} set eid = /g
:wq
EOF
#sleep 5s
echo "我们现在执行更新SQL..."
echo "ALTER TABLE ${table} AUTO_INCREMENT = 1" >> idseq.sql
mysql -uroot -proot < ./idseq.sql
