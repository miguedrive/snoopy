#!/bin/bash
# Log Grabber Auto rotation - SISP
# v1.0

# Assign variables for Current file (the one that is written), and the "new" one (the 'old' one with name YmdHM)
CUR="/var/log/ulog/pcap.log" #We must edit this line with the directory where the extra HD is mounted
#e.g : CUR="/mnt/logs/sdb/pcap.log"
NEW="${CUR}.$(date +%Y-%m-%d---%H-%M)"

# Rename the log
mv ${CUR} ${NEW}

# Create the syslogemu.log file and erase the daemon log (ulogd.log)
touch ${CUR}
#rm "/var/log/ulog/ulogd.log"

# Run ulogd again
kill -SIGHUP `pidof ulogd`

# Wait 1 sec before writing the new file
sleep 1

# Compress the old files
xz -9 ${NEW}
