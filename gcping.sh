#!/bin/bash

input="region-list"
cmd='./time.sh'

while read line
do
  region=$(echo $line | cut -d' ' -f1)
  ip=$(echo $line | cut -d' ' -f2)
  time=$(bash time.sh $ip)
  echo 'Pinging to '$region'... '$time'ms'
done < "$input"
