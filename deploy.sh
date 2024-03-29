#!/usr/bin/env bash

if [ ! -d "$HOME/google-cloud-sdk/bin" ]; then
  rm -rf "$HOME/google-cloud-sdk"
  curl https://sdk.cloud.google.com | bash > /dev/null
fi

source $HOME/google-cloud-sdk/path.bash.inc

gcloud components update kubectl

make gauth build push deploy #set-image
