#!/bin/bash -e

cd $(dirname $0)/..

upload_ci_artifact() {
  echo --- artifact: $1
  if [[ -r $1 ]]; then
    ls -l $1
    if ${BUILDKITE:-false}; then
      (
        set -x
        buildkite-agent artifact upload $1
      )
    fi
  else
    echo ^^^ +++
    echo $1 not found
  fi
}

OK=true

for tex in *.tex; do
  echo --- $tex
  (
    set -x
    ci/docker-run.sh evilmachines/texlive lualatex -interaction=nonstopmode -halt-on-error $tex
  ) || OK=false
  upload_ci_artifact ${tex%.*}.pdf
  upload_ci_artifact ${tex%.*}.log
  $OK || { echo Failure.; exit 1; }
done

echo Done.

if [[ -z "$BUILDKITE_TAG" ]]; then
  exit 0
fi

echo --- Uploading assets for $BUILDKITE_TAG
ci/docker-run.sh evilmachines/texlive ci/upload-release-asset.sh solana-labs whitepaper "$BUILDKITE_TAG" *.pdf


