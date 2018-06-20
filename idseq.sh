#!/bin/bash
table=$1
echo "表名：${table}"
#mysql -h127.0.0.1 -uroot -p123 -e "use plant_insight;select id from ${table} order by id;"|sed '1d'|sed 's/$/;/'|sed 's/^/ where id = /' > idseq.sql
vim idseq.sql << EOF
:g/^/exe ":s/^/".line(".")."/"
:%s/^/update ${table} set id = /g
:wq
EOF
#sleep 5s
echo "我们现在执行更新SQL..."
echo "ALTER TABLE ${table} AUTO_INCREMENT = 1;" >> idseq.sql
#mysql -uroot -p123 < ./idseq.sql
