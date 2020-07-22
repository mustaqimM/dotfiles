awk '/MemTotal:/{MT=$2} /MemFree/{MF=$2} /Buffers/{B=$2} /Cached/{C=$2} /SReclaimable/{SR=$2} /Shmem:/{SM=$2} END {total=(MT-(MF+B+C+SR+SM))/1024/1024; printf "%.2fGB", total}' /proc/meminfo
