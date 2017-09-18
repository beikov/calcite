#!/usr/bin/env bash
mvn -Dsurefire.useFile=false -Dcheckstyle.skip=true test &
pid=$!

minutes=0
limit=30
while kill -0 $! >/dev/null 2>&1; do
echo -n -e " \b" # never leave evidences!

if [ $minutes == $limit ]; then
  for vmpid in $(jps -q); do
    if [ ! $pid ==  $vmpid ]; then
      jstack $vmpid
    fi
  done
  exit 1;
fi

minutes=$((minutes+1))

sleep 60
done