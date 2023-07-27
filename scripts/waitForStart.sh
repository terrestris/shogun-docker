#!/bin/sh

URL="$1"
TIMEOUT=360
seconds=0

# Check if the input parameter URL is valid.
if [[ -z $URL ]]; then
    echo "Error: URL must be set"
    exit 1
fi

echo 'Waiting up to' $TIMEOUT 'seconds for HTTP 200 from' $URL
until [ "$seconds" -gt "$TIMEOUT" ] || $(curl --insecure --location --output /dev/null --silent --max-time $TIMEOUT --head --fail $URL); do
  sleep 5
  seconds=$((seconds+5))
done

if [ "$seconds" -lt "$TIMEOUT" ]; then
  echo "OK. Startup of $URL finished in $seconds seconds."
else
  echo "ERROR: Timed out waiting for HTTP 200 from" $URL >&2
  exit 1
fi
