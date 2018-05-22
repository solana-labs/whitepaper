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

if [[ ! -x  ./github-release ]]; then
  os=$(uname | tr DL dl)
  rm -f $os-amd64-github-release.tar.bz2
  wget https://github.com/aktau/github-release/releases/download/v0.7.2/$os-amd64-github-release.tar.bz2
  tar --strip-components=3 -jxof $os-amd64-github-release.tar.bz2
  ls -l ./github-release
fi

for file in "$@"; do
  (
    set -x
    ./github-release upload \
      --tag "$TAG" \
      --user "$ORG" \
      --repo "$REPO" \
      --replace \
      --name $file \
      --file $file \

  )
done

exit 0
