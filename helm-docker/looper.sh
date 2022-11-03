#!/usr/bin/bash
if pidof -o %PPID -x "looper.sh">/dev/null; then
  echo "Process alreaddy running.. not starting another one"
else
  while [ 1 ] ; do
    python /sendportusemetrics_prod.py
    sleep 60
  done
fi
