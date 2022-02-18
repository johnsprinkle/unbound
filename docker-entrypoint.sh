#!/bin/sh

unboundConfFile=/etc/unbound/unbound.conf
allowedSubnet="$ALLOWED_SUBNET"

if [ -z "$allowedSubnet" ]
then
  echo "ALLOWED_SUBNET not set: exiting"
  exit 1
fi
replacementString="s/%ALLOWED_SUBNET%/$allowedSubnet/g"
echo $replacementString
sed -i $replacementString "$unboundConfFile"

unbound-checkconf || exit 1

exec unbound -d -c "$unboundConfFile"