#!/usr/bin/env bash
#function print_sql(){
#    echo "-- $1"
#}
function exec_sql(){
    echo $1
    mysql -u root -p123 -h 127.0.0.1 -e "$1"
}
function rename_table(){
    old_table_name="$1.$3"
    new_table_name="$2.$3"
    exec_sql "rename table ${old_table_name} to ${new_table_name}"
}
function table_list(){
    sql="select table_name from information_schema.TABLES where TABLE_SCHEMA='$1' and table_name != 'schema_version'"
    echo $(mysql -u root -p123 -h 127.0.0.1 -Nse "${sql}")
}
function separator(){
    echo "-+-+-+-+-+-+--+-+-+--+-+-+--+-+-+--+-+-+--+-+-+--+-+-+--+-+-+-"
}
readonly SCHEMA_ADMIN="saas_management"
readonly SCHEMA_ENGINE="saas_engine"
readonly SCHEMA_PI="plant_insight"
separator
echo "Firstly, rename table gateway in saas_engine to gateway_status"
exec_sql "rename table ${SCHEMA_ENGINE}.gateway to ${SCHEMA_ENGINE}.gateway_status"
separator
echo "start to read two schema tables info"
exec_sql "create database if not exists ${SCHEMA_PI}"
separator
readonly ADMIN_TABLES=$(table_list ${SCHEMA_ADMIN})
readonly ENGINE_TABLES=$(table_list ${SCHEMA_ENGINE})
readonly PI_TABLES=$(table_list ${SCHEMA_PI})
echo "Tables of ${SCHEMA_ADMIN}: ${ADMIN_TABLES}"
echo "Tables of ${SCHEMA_ENGINE}: ${ENGINE_TABLES}"
echo "Tables of ${SCHEMA_PI}: ${PI_TABLES}"
separator
echo "start to transfer ${SCHEMA_ADMIN} tables"
for admin_table in ${ADMIN_TABLES}
do
    # echo ${admin_table}
    rename_table ${SCHEMA_ADMIN} ${SCHEMA_PI} ${admin_table}
done
echo "Schema ${SCHEMA_ADMIN}'s tables transferred successful!"
separator
echo "start to transfer ${SCHEMA_ENGINE} tables"
for engine_table in ${ENGINE_TABLES}
do
    # echo ${engine_table}
    rename_table ${SCHEMA_ENGINE} ${SCHEMA_PI} ${engine_table}
done
echo "Schema ${SCHEMA_ENGINE}'s tables transferred successful!"
separator
echo "We now list ${SCHEMA_PI} tables: "
for pi_table in $(table_list ${SCHEMA_PI})
do
    echo ${pi_table}
done