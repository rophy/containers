#!/bin/tclsh
# maintainer: Pooja Jain

dbset db ora
dbset bm TPC-C

puts "SETTING CONFIGURATION"
dbset db ora
dbset bm TPC-C

diset connection system_user $::env(ORACLE_USER)
diset connection system_password $::env(ORACLE_PASSWORD)
diset connection instance $::env(ORACLE_INSTANCE)

diset tpcc tpcc_user tpcc
diset tpcc tpcc_pass tpcc


puts "DROP SCHEMA STARTED"
deleteschema
puts "DROP SCHEMA COMPLETED"
