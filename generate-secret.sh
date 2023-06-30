#!/usr/bin/env bash

password=$1

if [ -z "$password" ]
then
echo ""
echo "No password set. Picking one randomly.."
password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 64)
echo ""
echo "New password: $password"
echo ""
else
echo ""
echo "Using provided password: $password"
echo ""
fi

export SEALED_SECRETS_CONTROLLER_NAMESPACE="ops"
export SEALED_SECRETS_CONTROLLER_NAME="sealed-secrets"
export SEALED_SECRETS_SCOPE="cluster-wide"


encryptedPassword=$(kubectl create secret generic script --dry-run=client --from-literal "script=$password" -o json | kubeseal -o json | jq -r '.spec.encryptedData.script')

echo ""
echo "Encypted password:"
echo ""
echo "$encryptedPassword"
echo ""

echo "$encryptedPassword" | xclip -sel clip
echo "Copied to Clipboard!"
