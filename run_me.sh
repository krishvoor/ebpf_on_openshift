#!/bin/bash

################################################
# Define common parameters
################################################

export PATH=$PATH:/usr/share/bcc/tools/
TEMP_DIR=`mktemp -d`
pushd $TEMP_DIR

################################################ List CPU details
lscpu > lscpu_details

################################################ Uname & Hostname details
uname -a > uname_details

################################################ Cachestat
cachestat 5 20 > cachestat_details

################################################ SoftIRQs
softirqs 5 20 > softirqs_details

################################################ LoadAVG
cat /proc/loadavg > loadavg_details

# Defaults at 49 probes, which might be very less
# For more probes 
# profile -F 999  ## Run for duration of workload
# Lesse
# profile -F 255 ## Should always be above 255
profile 60 > profile_details

################################################ System wide perf stats
perf stat -a -- sleep 10 > perf_stat_details

################################################ Give details of Tarball
echo "Details captured"
popd
echo "Create Tarball"
tar -cvf $TEMP_DIR.tar $TEMP_DIR/
echo "Unpack Tarball $TEMP_DIR.tar"