#!/bin/bash -e

cd $(dirname $0)/..

upload_ci_artifact() {
  if ${BUILDKITE:-false}; then
    echo --- artifact: $1
    if [[ -r $1 ]]; then
      (
        set -x
        buildkite-agent artifact upload $1
      )
    else
      echo ^^^ +++
      echo $1 not found
    fi
  fi
}

OK=true

echo --- tool versions
(
  set -x
  pdflatex --version
  luatex --version
)


echo --- solana-whitepaper.tex
(
  set -x
  pdflatex -interaction=nonstopmode -halt-on-error solana-whitepaper.tex
) || OK=false
upload_ci_artifact solana-whitepaper.pdf
upload_ci_artifact solana-whitepaper.log

# TODO: Enable jp translation once it builds correctly in CI
# echo --- solana-whitepaper-jp.tex
# (
#   set -x
#   luatex -interaction=nonstopmode translations/wip_japanese/solana-whitepaper-jp.tex
# ) || OK=false
# upload_ci_artifact solana-whitepaper-jp.pdf
# upload_ci_artifact solana-whitepaper-jp.log

$OK
