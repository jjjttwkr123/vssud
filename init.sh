#!/bin/bash

# Define the directory containing the scripts
service_dir="./service"

# Arrays to store script filenames and corresponding PIDs
scripts=()
pids=()

# Define cleanup function
cleanup() {
  echo "Cleaning up..."
  for pid in "${pids[@]}"; do
    if kill -0 "$pid" 2>/dev/null; then
      kill -9 "$pid"
    fi
  done
  exit 0
}

# Capture SIGINT and SIGTERM singals
trap cleanup SIGINT SIGTERM

# Start all .sh scripts and store their PIDs
for script in "$service_dir"/*.sh; do
  if [ -f "$script" ]; then
    bash "$script" &
    pids+=($!)
    scripts+=("$script")
  fi
done

# Daemon logic
while true; do
  for i in "${!pids[@]}"; do
    if ! kill -0 "${pids[$i]}" 2>/dev/null; then
      echo "Process ${pids[$i]} (${scripts[$i]}) has terminated. Restarting..."
      bash "${scripts[$i]}" &
      pids[$i]=$!
    fi
  done
  sleep 5
done