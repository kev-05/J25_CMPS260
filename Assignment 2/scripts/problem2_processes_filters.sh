#!/bin/bash

echo "Starting background jobs..."
sleep 3 &
PID1=$!
echo "Job 1 PID: $PID1"

sleep 2 &
PID2=$!
echo "Job 2 PID: $PID2"

echo "Waiting for jobs to complete..."
wait

echo "Exit status: $?"
echo "All jobs completed successfully"
