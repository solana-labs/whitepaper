#!/bin/bash -e
#
# Uploads build artifacts to the github release identified by the BUILDKITE_TAG
# environment variable
#

if [[ -z "$BUILDKITE_TAG" ]]; then
  exit 0
fi

cd $(dirname $0)/..
ci/build

if [[ "$BUILDKITE" = "true" ]]; then
  echo --- Installing additional packages
  # The "blang/latex:ubuntu" image is missing some tools, install them
  # manually for now to avoid having to maintain a custom docker image
  apt-get update
  for package in wget bzip2; do
    apt-get install -y $package
  done
fi

echo --- Uploading assets for $BUILDKITE_TAG
ci/upload-release-asset.sh solana-labs whitepaper "$BUILDKITE_TAG" \
  solana-whitepaper.pdf

exit 0
