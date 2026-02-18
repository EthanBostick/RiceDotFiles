#!/bin/sh
# Pulls temperature and utilization percentage
stats=$(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits)
util=$(echo $stats | cut -d',' -f1)
temp=$(echo $stats | cut -d',' -f2)
formatted_util=$(printf "%3s" "$util")

echo "GPU $formatted_util% :$temp°C"
