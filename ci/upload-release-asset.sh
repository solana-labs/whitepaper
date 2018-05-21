#!/bin/bash -e

usage() {
  if [[ -n "$1" ]]; then
    exitcode=1
    echo "Error: $@"
  fi
  cat <<EOF
  usage: $0 [github org] [github repo] [github release] artifacts

  Attaches the provided list of files to a github release.
EOF

  exit $exitcode
}

ORG=
REPO=
TAG=

ORG=$1
shift
[[ -n "$ORG" ]] || usage ORG not defined

REPO=$1
shift
[[ -n "$REPO" ]] || usage REPO not defined

TAG=$1
shift
[[ -n "$TAG" ]] || usage TAG not defined

[[ -n "$1" ]] || usage No artifacts provided

os=$(uname | tr DL dl)
if [[ ! -x  bin/$os/amd64/github-release ]]; then
  rm -f $os-amd64-github-release.tar.bz2 bin/$os/amd64/github-release
  wget https://github.com/aktau/github-release/releases/download/v0.7.2/$os-amd64-github-release.tar.bz2
  tar jxf $os-amd64-github-release.tar.bz2
  ls -l bin/$os/amd64/github-release
fi

for file in "$@"; do
  (
    set -x
    bin/$os/amd64/github-release upload \
      --tag "$TAG" \
      --user "$ORG" \
      --repo "$REPO" \
      --replace \
      --name $file \
      --file $file \

  )
done

exit 0
