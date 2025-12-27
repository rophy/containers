#!/bin/tclsh
# maintainer: Pooja Jain

puts "SETTING CONFIGURATION"
dbset db ora
dbset bm TPC-C

diset connection system_user $::env(ORACLE_USER)
diset connection system_password $::env(ORACLE_PASSWORD)
diset connection instance $::env(ORACLE_INSTANCE)

set warehouse 4
set vu [ numberOfCPUs ]
if { $vu > $warehouse } { set vu $warehouse }
diset tpcc count_ware $warehouse
diset tpcc num_vu $vu
diset tpcc tpcc_user tpcc
diset tpcc tpcc_pass tpcc
diset tpcc tpcc_def_tab users
diset tpcc tpcc_def_temp temp
if { $warehouse >= 200 } { 
diset tpcc partition true 
diset tpcc hash_clusters true
diset tpcc tpcc_ol_tab users
	} else {
diset tpcc partition false 
diset tpcc hash_clusters false
	}

puts "SCHEMA BUILD STARTED"
buildschema
puts "SCHEMA BUILD COMPLETED"

