#!/bin/bash -e

cd $(dirname $0)/..

upload_ci_artifact() {
  if ${BUILDKITE:-false}; then
    echo --- artifact: $1
    (
      set -x
      buildkite-agent artifact upload $1
    )
  fi
}

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
)
upload_ci_artifact solana-whitepaper.pdf
upload_ci_artifact solana-whitepaper.log

# TODO: Enable jp translation once it builds correctly in CI
# echo --- solana-whitepaper-jp.tex
# (
#   set -x
#   luatex -interaction=nonstopmode translations/wip_japanese/solana-whitepaper-jp.tex
# )
# upload_ci_artifact solana-whitepaper-jp.pdf
# upload_ci_artifact solana-whitepaper-jp.log

exit 0
