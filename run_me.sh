#!/bin/bash

################################################
# Define common parameters
################################################

cd /usr/share/bcc/tools/
TEMP_DIR=`mktemp -d`
pushd $TEMP_DIR

# List CPU details
lscpu > lscpu_details

# Uname & Hostname details
uname -a > uname_details
hostname -a > hostname_details

# Cachestat
./cachestat 5 20 > cachestat_details

# SoftIRQs
./softirqs 5 20 > softirqs.intel_details

# LoadAVG
cat /proc/loadavg > loadavg.intel_details

# 
./profile 60 > /tmp/profile.intel_details

# System wide perf stats
perf stat -a -- sleep 10 > perf_stat_details


echo "Default details captured"