#!/usr/bin/env bash

if [ -f "$1" ]; then
  password=$(cat "$1")
  echo "Using password from file: $1"
else
  password=$1
  if [ -z "$password" ]; then
    echo "No password set. Generating a random password..."
    password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 64)
  else
    echo "Using provided password."
  fi
fi

echo "Password: $password"

export SEALED_SECRETS_CONTROLLER_NAMESPACE="sealed-secrets"
export SEALED_SECRETS_CONTROLLER_NAME="sealed-secrets"
export SEALED_SECRETS_SCOPE="cluster-wide"

encryptedPassword=$(kubectl create secret generic script --dry-run=client --from-literal "script=$password" -o json | kubeseal -o json | jq -r '.spec.encryptedData.script')

echo ""
echo "Encrypted password:"
echo "$encryptedPassword"
echo ""

echo "$encryptedPassword" | xclip -sel clip
echo "Copied to Clipboard!"
