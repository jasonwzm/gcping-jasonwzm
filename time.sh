#!/bin/bash

COUNT=10
DIFF=0
while [ $COUNT -gt 0 ]
do
START=$(date +%s%3N)
curl -m1 -k $1 > /dev/null 2>&1
END=$(date +%s%3N)
CURRDIFF=$(echo "$END - $START" | bc)
DIFF=$((DIFF + CURRDIFF))
COUNT=$((COUNT-1));
done

echo $((DIFF/10))

