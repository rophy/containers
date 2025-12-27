#!/bin/tclsh
# maintainer: Pooja Jain

set tmpdir $::env(TMP)
puts "SETTING CONFIGURATION"
dbset db ora
dbset bm TPC-C

diset connection system_user $::env(ORACLE_USER)
diset connection system_password $::env(ORACLE_PASSWORD)
diset connection instance $::env(ORACLE_INSTANCE)

diset tpcc tpcc_user tpcc
diset tpcc tpcc_pass tpcc

diset tpcc ora_driver timed
diset tpcc total_iterations 10000000
diset tpcc rampup 2
diset tpcc duration 5
diset tpcc ora_timeprofile true
diset tpcc allwarehouse true
diset tpcc checkpoint false

loadscript
puts "TEST STARTED"
# Use HAMMERDB_VUS env var if set, otherwise auto-detect from CPUs
if { [info exists ::env(HAMMERDB_VUS)] && $::env(HAMMERDB_VUS) ne "" } {
    set vu $::env(HAMMERDB_VUS)
    puts "Using $vu virtual users (from HAMMERDB_VUS)"
} else {
    set vu [ numberOfCPUs ]
    puts "Using $vu virtual users (auto-detected from CPUs)"
}
vuset vu $vu
vucreate
tcstart
tcstatus
set jobid [ vurun ]
vudestroy
tcstop
puts "TEST COMPLETE"
set of [ open $tmpdir/ora_tprocc w ]
puts $of $jobid
close $of
